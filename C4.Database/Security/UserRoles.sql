CREATE TABLE [sec].[UserRole]
(
	[UserId]		BIGINT NOT NULL,
	[RoleId]		BIGINT NOT NULL, 
    
	CONSTRAINT [PK_UserRole] 
		PRIMARY KEY ([UserId], [RoleID]),
	CONSTRAINT [FK_UserRole_User_UserId] 
		FOREIGN KEY ([UserId]) 
		REFERENCES [sec].[User]([Id]) 
		ON DELETE CASCADE,
	CONSTRAINT [FK_UserRole_Role_RoleId] 
		FOREIGN KEY ([RoleId]) 
		REFERENCES [sec].[Role]([Id]) 
		ON DELETE CASCADE
)

GO;

CREATE INDEX [IX_UserRole_RoleId]
    ON [sec].[UserRole]([RoleId])