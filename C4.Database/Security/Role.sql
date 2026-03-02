CREATE TABLE [sec].[Role]
(
	[Id]				BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Name]				NVARCHAR(256) NOT NULL,
	[NormalizedName]	NVARCHAR(256) NOT NULL,
	[Title]				NVARCHAR(256) NOT NULL,
	[Description]		NVARCHAR(512) NULL,

	[EntityId]          UNIQUEIDENTIFIER NOT NULL DEFAULT(NEWID()),
	[ConcurrencyStamp]	NVARCHAR(512) NULL,

	[CreatedAt]		DATETIME2 NOT NULL DEFAULT(GETUTCDATE()),
	[CreatedBy]		BIGINT NOT NULL,
	[LastUpdatedAt]	DATETIME2 NULL,
	[LastUpdatedBy] BIGINT NULL,
	[IsDeleted]		BIT NOT NULL DEFAULT(0),
	[DeletedAt]		DATETIME2 NULL,
	[DeletedBy]		BIGINT NULL
)

GO;

CREATE UNIQUE INDEX [RoleNameIndex]
    ON [sec].[Role]([NormalizedName])
    WHERE [NormalizedName] IS NOT NULL