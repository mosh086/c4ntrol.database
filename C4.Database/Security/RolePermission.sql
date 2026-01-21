CREATE TABLE [sec].[RolePermission]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[RoleId] INT NOT NULL,
	[PermissionId] INT NOT NULL,
    CONSTRAINT [FK_RolePermission_Role] FOREIGN KEY ([RoleId]) REFERENCES [sec].[Role]([Id]), 
    CONSTRAINT [FK_RolePermission_Permission] FOREIGN KEY ([PermissionId]) REFERENCES [sec].[Permission]([Id])
)