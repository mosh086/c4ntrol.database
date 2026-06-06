CREATE TABLE [sec].[RoleClaim]
(
	[Id]			BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[RoleId]		BIGINT NOT NULL,
	[ClaimType]		NVARCHAR(MAX) NULL,
	[ClaimValue]	NVARCHAR(MAX) NULL,
    
	CONSTRAINT [FK_RoleClaim_Role_RoleId] 
		FOREIGN KEY ([RoleId]) 
		REFERENCES [sec].[Role]([Id]) 
		ON DELETE CASCADE
)

GO;

CREATE INDEX [IX_RoleClaim_RoleId]
    ON [sec].[RoleClaim]([RoleId])
