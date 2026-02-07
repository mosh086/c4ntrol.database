CREATE TABLE [sec].[UserClaim]
(
	[Id] BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[UserId] BIGINT NOT NULL,
	[ClaimType] NVARCHAR(MAX) NULL,
	[ClaimValue] NVARCHAR(MAX) NULL,
    
	CONSTRAINT [FK_UserClaim_User_UserId] 
		FOREIGN KEY ([UserId]) 
		REFERENCES [sec].[User]([Id]) 
		ON DELETE CASCADE
)

GO;

CREATE INDEX [IX_UserClaim_UserId]
    ON [sec].[UserClaim]([UserId])