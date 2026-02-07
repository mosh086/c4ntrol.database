CREATE TABLE [sec].[UserToken]
(
	[UserId]        BIGINT NOT NULL,
    [LoginProvider] NVARCHAR(450) NOT NULL,
    [Name]          NVARCHAR(450) NOT NULL,
    [Value]         NVARCHAR(MAX) NULL, 
    
    CONSTRAINT [PK_UserToken]
        PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_UserToken_User_UserId] 
		FOREIGN KEY ([UserId]) 
		REFERENCES [sec].[User]([Id]) 
		ON DELETE CASCADE
)