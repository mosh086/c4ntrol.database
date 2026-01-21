CREATE TABLE [sec].[UserRoles]
(
	[Id] INT NOT NULL PRIMARY KEY,
	[UserId] INT NOT NULL,
	[RoleId] INT NOT NULL, 
    CONSTRAINT [FK_UserRoles_User] FOREIGN KEY ([UserId]) REFERENCES [sec].[User]([Id]), 
    CONSTRAINT [FK_UserRoles_Role] FOREIGN KEY ([RoleId]) REFERENCES [sec].[Role]([Id])
)
