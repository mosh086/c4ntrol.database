CREATE TABLE [org].[Supplier]
(
	[Id]				BIGINT IDENTITY(1,1)	NOT NULL PRIMARY KEY,
	[CompanyId]			BIGINT					NOT NULL,
	[Name]				NVARCHAR(256)			NOT NULL,
	[ContactName]		NVARCHAR(256)			NULL,
	[Email]				NVARCHAR(256)			NULL,
	[PhoneNumber]		NVARCHAR(20)			NULL,
	[TaxId]				NVARCHAR(50)			NULL,
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
	[DeletedBy]			BIGINT					NULL,

	CONSTRAINT [FK_Supplier_Company_CompanyId]
		FOREIGN KEY ([CompanyId])
		REFERENCES [org].[Company]([Id])
)

GO;

CREATE INDEX [IX_Supplier_CompanyId]
	ON [org].[Supplier]([CompanyId])

GO;

CREATE INDEX [IX_Supplier_Name]
	ON [org].[Supplier]([Name])
