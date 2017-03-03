-- =============================================
USE LeLongDB
GO 
------------------------------------------------
--Table Setting 
IF NOT EXISTS (SELECT * FROM sys.objects 
			WHERE type = 'U' AND object_id = OBJECT_ID(N'[dbo].[Setting]')) 
CREATE TABLE [dbo].[Setting] 
( 
	[SettingFieldId] VARCHAR(255) NOT NULL, 
	[IsInstalled] VARCHAR(255) 
) 
GO 
------------------------------------------------
--Table User
IF NOT EXISTS (SELECT * FROM sys.objects 
			WHERE type = 'U' AND object_id = OBJECT_ID(N'[dbo].[User]')) 
CREATE TABLE [dbo].[User] 
( 
	[UserId] INT IDENTITY(1, 1), 
	[UserName] VARCHAR(255) NOT NULL, 
	[PassWord] VARCHAR(255) NOT NULL, 
	[Access_Token] VARCHAR(255) NOT NULL, 
	[Refresh_Token] VARCHAR(255), 
	[LoginAttempt] INT, 
	[MaxPostingAllow] INT, 
	[PostingAlready] INT, 
	[NumberOfPhotosAllow] INT, 
	CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
	(
		[UserId] ASC
	)
) ON [PRIMARY] 
GO 
------------------------------------------------
--Table Wizard
IF NOT EXISTS (SELECT * FROM sys.objects 
			WHERE type = 'U' AND object_id = OBJECT_ID(N'[dbo].[Wizard]')) 
CREATE TABLE [dbo].[Wizard] 
( 
	[WizardId] INT IDENTITY(1,1), 
	[UserId] INT, 
	[DaysOfShip] INT, 
	[ItemsCategory] NVARCHAR(255), 
	[ShippingFee] NVARCHAR(255), 
	CONSTRAINT [PK_Wizard] PRIMARY KEY CLUSTERED 
	(
		[WizardId] ASC 
	), 
	CONSTRAINT [FK_Wizard_User] FOREIGN KEY([UserId]) 
	REFERENCES [dbo].[User]([UserId]) 
) ON [PRIMARY] 
GO 
------------------------------------------------
--Table GoodsPublish 
IF NOT EXISTS (SELECT * FROM sys.objects 
			WHERE type = 'U' AND object_id = OBJECT_ID(N'[dbo].[GoodsPublish]')) 
CREATE TABLE [dbo].[GoodsPublish] 
( 
	[GoodPublishId] INT IDENTITY(1,1), 
	[UserId] INT, 
	[Title] NVARCHAR(255) NOT NULL, 
	[SubTitle] NVARCHAR(255), 
	[Condition] NVARCHAR(255), 
	[Guid] VARCHAR(50), 
	--
	[Price] REAL, 
	[SalePrice] REAL, 
	[Msrp] REAL, 
	[CostPrice] REAL, 
	[SaleType] NVARCHAR(255), 
	-- 
	[Category] NVARCHAR(255), 
	[StoreCategory] INT, 
	[Brand] NVARCHAR(255), 
	[ShipWithin] INT, 
	[ModelSkuCode] NVARCHAR(255), 
	[State] NVARCHAR(255), 
	--
	[Link] NVARCHAR(500), 
	[Description] NVARCHAR(1000), 
	[Video] NVARCHAR(500), 
	[VideoAlign] NVARCHAR(255), 
	[Active] INT, 
	[Weight] INT, 
	--
	[Quantity] INT, 
	[ShippingPrice] NVARCHAR(255), 
	[WhoPay] NVARCHAR(255), 
	[ShippingMethod] NVARCHAR(255), 
	[ShipToLocation] NVARCHAR(255), 
	-- 
	[PaymentMethod] NVARCHAR(255), 
	[GstType] INT, 
	[OptionsStatus] INT, 
	[CreatedDate] DATE, 
	[LastEdited] DATE, 
	[LastSync] DATE, 
	CONSTRAINT [PK_GoodPublishId] PRIMARY KEY CLUSTERED 
	(
		[GoodPublishId] ASC 
	), 
	CONSTRAINT [FK_GoodPublish_User] FOREIGN KEY([UserId]) 
	REFERENCES [dbo].[User]([UserId])
) ON [PRIMARY]
GO 
------------------------------------------------
--Table GoodsPublishPhoto
IF NOT EXISTS (SELECT * FROM sys.objects 
			WHERE type = 'U' AND object_id = OBJECT_ID(N'[dbo].[GoodsPublishPhoto]')) 
CREATE TABLE [dbo].[GoodsPublishPhoto] 
( 
	[PhotoId] INT IDENTITY(1,1), 
	[GoodPublishId] INT,
	[PhotoName] NVARCHAR(255),
	[PhotoUrl] VARCHAR(255),
	[PhotoDescription] NVARCHAR(500) 
	CONSTRAINT [PK_PhotoId] PRIMARY KEY CLUSTERED 
	(
		[PhotoId] ASC 
	),
	CONSTRAINT [FK_Photo_GoodPublish] FOREIGN KEY([GoodPublishId]) 
	REFERENCES [dbo].[GoodsPublish]([GoodPublishId]) 
) 
GO 
------------------------------------------------