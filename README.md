# PowderNaut Database

Corporate database for the explosive materials management system at **PowderNaut Mining**.

## Overview

PowderNaut Database is an SSDT (SQL Server Data Tools) project powering the explosive materials control platform. It manages mining companies and their explosive material suppliers, along with the ASP.NET Identity-based authentication and authorization system.

## Schemas

### `[org]` — Organization

Mining companies and explosive material suppliers.

| Table | Description |
|---|---|
| `Company` | Registered mining companies. Legal, tax, and contact information. |
| `Supplier` | Explosive material suppliers linked to a company. Contact and tax details. |

### `[sec]` — Security (ASP.NET Identity)

Authentication, authorization, and access control.

| Table | Description |
|---|---|
| `User` | System users with multi-factor authentication and lockout support. |
| `Role` | Roles with name, title, and description. |
| `UserRole` | Many-to-many user-role assignments. |
| `UserClaim` | Custom claims per user. |
| `RoleClaim` | Claims assigned to roles. |
| `UserLogin` | External logins (OAuth, OpenID Connect). |
| `UserToken` | Access and refresh tokens per user and provider. |

## Tech Stack

- **SQL Server Azure SQL Database** (SQLAzureV12)
- **SSDT** — SQL Server Data Tools (`.sqlproj`)
- **Solution** `.slnx` for multi-project organization

## Structure

```
powdernaut.database/
├── Org/
│   ├── Company.sql
│   └── Supplier.sql
├── Security/
│   ├── User.sql
│   ├── Role.sql
│   ├── UserRole.sql
│   ├── UserClaim.sql
│   ├── RoleClaim.sql
│   ├── UserLogin.sql
│   └── UserToken.sql
├── Scripts/
│   ├── PreDeployment.sql
│   └── PostDeployment.sql
├── org.sql
├── security.sql
└── powdernaut.database.sqlproj
```

## Conventions

- **Identity**: `BIGINT IDENTITY(1,1)` as PK on all business tables.
- **Audit**: `CreatedAt/By`, `LastUpdatedAt/By`, soft-delete with `IsDeleted`, `DeletedAt/By`.
- **Concurrency**: `EntityId` (`UNIQUEIDENTIFIER`) as public identifier; `ConcurrencyStamp` for optimistic concurrency.
- **Schema-per-domain**: `[org]` for business, `[sec]` for identity and access.

## License

MIT
