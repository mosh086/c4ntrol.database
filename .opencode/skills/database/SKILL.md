# Database Skill — SQL Server SSDT Project

Provides best practices and conventions for the powdernaut.database SSDT (SQL Server Data Tools) project.

## Schema Organization

- Group tables by domain into schemas: `sec` (security), `core`, `audit`, `ref` (reference), `app`
- Own schemas in a single file per schema: `security.sql` → `CREATE SCHEMA [sec]`
- Folder per schema to mirror the `.sqlproj` structure

## Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Schema | `[lowercase]` | `[sec]`, `[core]` |
| Table | `[PascalCase]` singular | `[User]`, `[UserRole]` |
| Column | `[PascalCase]` | `[NormalizedUserName]` |
| Primary Key | `PK_TableName` | `PK_User` |
| Foreign Key | `FK_ChildTable_ParentTable_Column` | `FK_UserRole_User_UserId` |
| Unique Constraint | `UQ_TableName_Columns` | `UQ_User_NormalizedEmail` |
| Default Constraint | `DF_TableName_Column` | `DF_User_CreatedAt` |
| Index | `IX_TableName_Columns` | `IX_UserRole_RoleId` |
| Unique Index | `UQ_TableName_Columns` | `UQ_Role_NormalizedName` |

## Table Design

### Audit Columns (every table)

```sql
[CreatedAt]     DATETIME2      NOT NULL DEFAULT(GETUTCDATE()),
[CreatedBy]     BIGINT         NOT NULL,
[LastUpdatedAt] DATETIME2      NULL,
[LastUpdatedBy] BIGINT         NULL,
```

### Soft Delete (every table)

```sql
[IsDeleted]     BIT            NOT NULL DEFAULT(0),
[DeletedAt]     DATETIME2      NULL,
[DeletedBy]     BIGINT         NULL,
```

### Primary Key & Entity Identifier

```sql
[Id]           BIGINT              IDENTITY(1,1) NOT NULL PRIMARY KEY,
[EntityId]     UNIQUEIDENTIFIER    NOT NULL DEFAULT(NEWID()),
```

- `Id` — internal surrogate key (clustered)
- `EntityId` — public/external identifier (non-guessable)

### Column Types

- `NVARCHAR` (not `VARCHAR`) for Unicode support
- `NVARCHAR(MAX)` only when length is truly unbounded; otherwise explicit length
- `DATETIME2` for date/time (not `DATETIME`)
- `BIT NOT NULL DEFAULT(0)` for boolean flags
- `BIGINT` for foreign keys and identity columns
- `UNIQUEIDENTIFIER` for public entity identifiers

## Indexing

- Clustered index on `Id` (primary key)
- Non-clustered index on every foreign key column
- Filtered `WHERE [IsDeleted] = 0` on indexes where soft-delete rows are excluded from queries
- Unique filtered indexes for nullable columns: `WHERE [Column] IS NOT NULL`
- Avoid over-indexing; one index per query pattern

## Constraints

- Always name constraints explicitly (never rely on auto-naming)
- Foreign keys use `ON DELETE CASCADE` only when child rows have no meaning without the parent
- Check constraints for business rules inline with table definition

```sql
CONSTRAINT [CK_User_EmailConfirmed]
    CHECK ([EmailConfirmed] IN (0, 1))
```

## Stored Procedures

```sql
CREATE PROCEDURE [sec].[usp_User_GetById]
    @Id BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [Id],
        [UserName],
        [Email]
    FROM [sec].[User]
    WHERE [Id] = @Id
      AND [IsDeleted] = 0;
END;
```

- Prefix: `usp_` for user stored procedures
- Use `SET NOCOUNT ON`
- Use `TRY-CATCH` for transactional procedures
- Schema-qualify all object references
- Always use parameters (never dynamic SQL)

## Views

```sql
CREATE VIEW [sec].[v_UserActive]
AS
SELECT
    [Id],
    [UserName],
    [Email]
FROM [sec].[User]
WHERE [IsDeleted] = 0;
```

- Prefix: `v_` for views
- Use `SCHEMABINDING` when performance matters
- No `SELECT *` — always explicit column lists
- No `ORDER BY` unless accompanied by `TOP/OFFSET`

## Functions

```sql
CREATE FUNCTION [sec].[ufn_GetUserDisplayName]
(
    @UserId BIGINT
)
RETURNS NVARCHAR(256)
AS
BEGIN
    RETURN (SELECT [Name] FROM [sec].[User] WHERE [Id] = @UserId);
END;
```

- Prefix: `ufn_` for scalar, `ift_` for inline table-valued
- Schema-bound when possible
- Deterministic when possible

## SSDT Project Structure

```
powdernaut.database/
├── powdernaut.database.sqlproj
├── security.sql                  (schema definition)
├── Security/
│   ├── User.sql
│   ├── Role.sql
│   ├── UserRoles.sql
│   ├── UserClaim.sql
│   ├── RoleClaim.sql
│   ├── UserLogin.sql
│   └── UserToken.sql
├── Core/                         (future domain schemas)
├── Reference/
└── Scripts/
    ├── PreDeployment.sql
    └── PostDeployment.sql
```

- One file per object, organized by schema folder
- `.sqlproj` includes all build items explicitly
- Pre/Post-deployment scripts for seed data and migrations

## File Template

```sql
CREATE TABLE [sec].[TableName]
(
    [Id]                BIGINT IDENTITY(1,1)     NOT NULL PRIMARY KEY,
    [Name]              NVARCHAR(256)            NOT NULL,
    [NormalizedName]    NVARCHAR(256)            NOT NULL,

    [EntityId]          UNIQUEIDENTIFIER         NOT NULL DEFAULT(NEWID()),
    [ConcurrencyStamp]  NVARCHAR(512)            NULL,

    [CreatedAt]         DATETIME2                NOT NULL DEFAULT(GETUTCDATE()),
    [CreatedBy]         BIGINT                   NOT NULL,
    [LastUpdatedAt]     DATETIME2                NULL,
    [LastUpdatedBy]     BIGINT                   NULL,
    [IsDeleted]         BIT                      NOT NULL DEFAULT(0),
    [DeletedAt]         DATETIME2                NULL,
    [DeletedBy]         BIGINT                   NULL
);

GO;

CREATE UNIQUE INDEX [UQ_TableName_NormalizedName]
    ON [sec].[TableName]([NormalizedName])
    WHERE [NormalizedName] IS NOT NULL;

GO;

CREATE INDEX [IX_TableName_CreatedAt]
    ON [sec].[TableName]([CreatedAt]);
```

## Security

- Application connects via a dedicated login with only necessary permissions
- Grant `EXECUTE` on schema level for stored procedures: `GRANT EXECUTE ON SCHEMA :: [sec] TO [app_user]`
- No direct table access from the application layer
- Use `ROW LEVEL SECURITY` for multi-tenant isolation if needed
- Always encrypt sensitive columns (passwords hashed in app layer; no plain-text storage)

## Source Control (Git)

- One object per file (no giant migration scripts in source)
- Use SSDT schema compare for generating change scripts
- `.sqlproj` and all `.sql` files are committed
- Exclude `bin/`, `obj/`, `.vs/`, `*.dbmdl`, `*.jfm`, `*.mdf`, `*.ldf`
- Commit messages follow convention: `schema: description` (`sec: add UserLogin table`)
