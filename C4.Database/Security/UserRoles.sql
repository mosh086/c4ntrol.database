CREATE TABLE [sec].[UserRoles]
(
	[Id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[UserId] INT NOT NULL,
	[RoleId] INT NOT NULL,
    CONSTRAINT [FK_UserRoles_User] FOREIGN KEY ([UserId]) REFERENCES [sec].[User] ([Id]), 
    CONSTRAINT [FK_UserRoles_Role] FOREIGN KEY ([RoleId]) REFERENCES [sec].[Role] ([Id]),
    CONSTRAINT [UQ_UserRoles_User_Role] UNIQUE ([UserId], [RoleId])
)