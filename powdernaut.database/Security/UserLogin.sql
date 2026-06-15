CREATE TABLE [sec].[UserLogin]
(
	[LoginProvider]         NVARCHAR(450) NOT NULL,
    [ProviderKey]           NVARCHAR(450) NOT NULL,
    [ProviderDisplayName]   NVARCHAR(MAX) NULL,
    [UserId]                BIGINT NOT NULL, 
    CONSTRAINT [PK_UserLogin] 
        PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_UserLogin_User_UserId] 
		FOREIGN KEY ([UserId]) 
		REFERENCES [sec].[User]([Id]) 
		ON DELETE CASCADE
)

GO;

CREATE INDEX [IX_UserLogin_UserId]
    ON [sec].[UserLogin]([UserId])