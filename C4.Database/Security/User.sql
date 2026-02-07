CREATE TABLE [sec].[User]
(
	[Id]					BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[FirstName]				NVARCHAR(256) NULL,
	[LastName]				NVARCHAR(256) NULL,
	[UserName]				NVARCHAR(256) NOT NULL,
	[NormalizedUserName]	NVARCHAR(256) NOT NULL,
    [Email]					NVARCHAR(256) NOT NULL,
    [NormalizedEmail]		NVARCHAR(256) NOT NULL,
    [EmailConfirmed]		BIT NOT NULL DEFAULT(0),
    [PasswordHash]			NVARCHAR(MAX) NULL,
    [SecurityStamp]			NVARCHAR(MAX) NULL,
    [ConcurrencyStamp]		NVARCHAR(MAX) NULL,
    [PhoneNumber]			NVARCHAR(MAX) NULL,
    [PhoneNumberConfirmed]	BIT NOT NULL DEFAULT(0),
    [TwoFactorEnabled]		BIT NOT NULL DEFAULT(0),
    [LockoutEnd]			DATETIMEOFFSET NULL,
    [LockoutEnabled]		BIT NOT NULL DEFAULT(0),
    [AccessFailedCount]		INT NOT NULL,

	[CreatedAt]		DATETIME2 NOT NULL DEFAULT(GETUTCDATE()),
	[CreatedBy]		NVARCHAR(256) NOT NULL,
	[LastUpdateAt]	DATETIME2 NULL,
	[LastUpdatedBy] NVARCHAR(256) NULL,
	[IsDeleted]		BIT NOT NULL DEFAULT(0),
	[DeletedAt]		DATETIME2 NULL,
	[DeletedBy]		NVARCHAR(256) NULL
)

GO;

CREATE UNIQUE INDEX [UserNameIndex]
    ON [sec].[User]([NormalizedUserName])
    WHERE [NormalizedUserName] IS NOT NULL

GO;

CREATE INDEX [EmailIndex]
    ON [sec].[User]([NormalizedEmail])