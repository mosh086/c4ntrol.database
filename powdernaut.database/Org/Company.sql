CREATE TABLE [org].[Company]
(
	[Id]				BIGINT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
	[Name]				NVARCHAR(256)			NOT NULL,
	[LegalName]			NVARCHAR(256)			NULL,
	[TaxId]				NVARCHAR(50)			NULL,
	[Email]				NVARCHAR(256)			NULL,
	[PhoneNumber]		NVARCHAR(20)			NULL,
	[Website]			NVARCHAR(256)			NULL,
	[AddressLine1]		NVARCHAR(256)			NULL,
	[AddressLine2]		NVARCHAR(256)			NULL,
	[City]				NVARCHAR(128)			NULL,
	[State]				NVARCHAR(128)			NULL,
	[PostalCode]		NVARCHAR(20)			NULL,
	[Country]			NVARCHAR(128)			NULL,
	[IsActive]			BIT						NOT NULL DEFAULT(1),

	[EntityId]			UNIQUEIDENTIFIER		NOT NULL DEFAULT(NEWID()),
	[ConcurrencyStamp]	NVARCHAR(MAX)			NULL,

	[CreatedAt]			DATETIME2				NOT NULL DEFAULT(GETUTCDATE()),
	[CreatedBy]			BIGINT					NOT NULL,
	[LastUpdatedAt]		DATETIME2				NULL,
	[LastUpdatedBy]		BIGINT					NULL,
	[IsDeleted]			BIT						NOT NULL DEFAULT(0),
	[DeletedAt]			DATETIME2				NULL,
	[DeletedBy]			BIGINT					NULL
)

GO;

CREATE INDEX [IX_Company_Name]
	ON [org].[Company]([Name])

GO;

CREATE INDEX [IX_Company_TaxId]
	ON [org].[Company]([TaxId])
	WHERE [TaxId] IS NOT NULL
