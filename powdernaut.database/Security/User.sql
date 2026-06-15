CREATE TABLE [sec].[User]
(
	[Id]					BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Name]					NVARCHAR(512) NULL,
	[UserName]				NVARCHAR(256) NOT NULL,
	[NormalizedUserName]	NVARCHAR(256) NOT NULL,
	[Email]					NVARCHAR(256) NOT NULL,
	[NormalizedEmail]		NVARCHAR(256) NOT NULL,
	[EmailConfirmed]		BIT NOT NULL DEFAULT(0),
	[PhoneNumber]			NVARCHAR(20) NULL,
	[PhoneNumberConfirmed]	BIT NOT NULL DEFAULT(0),

	[PasswordHash]			NVARCHAR(MAX) NULL,
	[SecurityStamp]			NVARCHAR(MAX) NULL,
	[TwoFactorEnabled]		BIT NOT NULL DEFAULT(0),
	[LockoutEnd]			DATETIMEOFFSET NULL,
	[LockoutEnabled]		BIT NOT NULL DEFAULT(0),
	[AccessFailedCount]		INT NOT NULL,

	[EntityId]				UNIQUEIDENTIFIER NOT NULL DEFAULT(NEWID()),
	[ConcurrencyStamp]		NVARCHAR(MAX) NULL,

	[CreatedAt]				DATETIME2 NOT NULL DEFAULT(GETUTCDATE()),
	[CreatedBy]				BIGINT NOT NULL,
	[LastUpdatedAt]			DATETIME2 NULL,
	[LastUpdatedBy]			BIGINT NULL,
	[IsDeleted]				BIT NOT NULL DEFAULT(0),
	[DeletedAt]				DATETIME2 NULL,
	[DeletedBy]				BIGINT NULL
)

GO;

CREATE UNIQUE INDEX [UQ_User_NormalizedUserName]
	ON [sec].[User]([NormalizedUserName])
	WHERE [NormalizedUserName] IS NOT NULL

GO;

CREATE INDEX [IX_User_NormalizedEmail]
	ON [sec].[User]([NormalizedEmail])
