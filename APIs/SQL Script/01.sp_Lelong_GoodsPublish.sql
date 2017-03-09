------------------------------------------------
USE LeLongDB 
GO 
------------------------------------------------
-- sp GoodsPublish Insert 
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublish_Insert]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublish_Insert] 
GO 
---- type PhotoTableType 
IF EXISTS (SELECT * FROM sys.types WHERE is_user_defined = 1 AND NAME = 'PhotoTableType') 
DROP TYPE [dbo].[PhotoTableType]
GO
CREATE TYPE [dbo].[PhotoTableType] AS TABLE 
(
	/*[PhotoId] INT,*/  
	/*[GoodPublishId] INT,*/ 
	[PhotoName] NVARCHAR(255), 
	[PhotoUrl] VARCHAR(255), 
	[PhotoDescription] NVARCHAR(500) 
)
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublish Insert
-- =============================================
CREATE PROCEDURE [dbo].[GoodsPublish_Insert] 
	@UserId INT = 0, 
	@Title NVARCHAR(255) = '', 
	@SubTitle NVARCHAR(255) = '', 
	@Condition NVARCHAR(255) = '', 
	@Guid VARCHAR(50) = '', 
	@Price REAL = 0.0, 
	@SalePrice REAL = 0.0, 
	@Msrp REAL = 0.0, 
	@CostPrice REAL = 0, 
	@SaleType NVARCHAR(255) = '', 
	-- 
	@Category NVARCHAR(255) = '', 
	@StoreCategory INT, 
	@Brand NVARCHAR(255) = '', 
	@ShipWithin INT = 0, 
	@ModelSkuCode NVARCHAR(255) = '', 
	@State NVARCHAR(255) = '', 
	@Link NVARCHAR(500) = '', 
	@Description NVARCHAR(1024) = '', 
	-- 
	@Video NVARCHAR(500) = '', 
	@VideoAlign NVARCHAR(255) = '', 
	@Active INT = 0, 
	@Weight INT = 0, 
	@Quantity INT = 0, 
	-- 
	@ShippingPrice NVARCHAR(255) = '', 
	@WhoPay NVARCHAR(255) = '', 
	@ShippingMethod NVARCHAR(255) = '', 
	@ShipToLocation NVARCHAR(255) = '', 
	@PaymentMethod NVARCHAR(255) = '', 
	@GstType INT = 0, 
	@OptionsStatus INT = 0, 
	--
	@GoodsPublishPhoto [dbo].[PhotoTableType] READONLY 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		DECLARE @v_goodpublishid INT = -1
		-- If Goods exist with GUID then Update else Insert
		IF(EXISTS (SELECT [GoodPublishId] FROM [dbo].[GoodsPublish] WHERE [Guid] = @Guid))
		BEGIN 
			UPDATE [dbo].[GoodsPublish] SET 
				[UserId] = @UserId, 
				[Title] = @Title, 
				[SubTitle] = @SubTitle, 
				[Condition] = @Condition,
				/*[Guid],*/ 
				[Price] = @Price, 
				[SalePrice] = @SalePrice, 
				[Msrp] = @Msrp, 
				[CostPrice] = @CostPrice, 
				[SaleType] = @SalePrice, 
				-- 
				[Category] = @Category, 
				[StoreCategory] = @StoreCategory, 
				[Brand] = @Brand, 
				[ShipWithin] = @ShipWithin, 
				[ModelSkuCode] = @ModelSkuCode, 
				[State] = @State, 
				[Link] = @Link, 
				[Description] = @Description, 
				-- 
				[Video] = @Video, 
				[VideoAlign] = @VideoAlign, 
				[Active] = @Active, 
				[Weight] = @Weight, 
				[Quantity] = @Quantity, 
				-- 
				[ShippingPrice] = @ShippingPrice, 
				[WhoPay] = @WhoPay, 
				[ShippingMethod] = @ShippingMethod, 
				[ShipToLocation] = @ShipToLocation, 
				[PaymentMethod] = @PaymentMethod, 
				[GstType] = @GstType, 
				[OptionsStatus] = @OptionsStatus, 
				/*[CreatedDate],*/ 
				[LastEdited] = GETDATE(), 
				[LastSync] = NULL
			WHERE [Guid] = @Guid 
			--
			SET @v_goodpublishid = (SELECT [GoodPublishId] FROM [dbo].[GoodsPublish] WHERE [Guid] = @Guid) 
			-- 
			DELETE FROM [dbo].[GoodsPublishPhoto] 
			WHERE [GoodPublishId] IN (
				SELECT [GoodPublishId] 
				FROM [dbo].[GoodsPublish] WHERE [Guid] = @Guid) 
		END 
		ELSE 
		BEGIN 
			INSERT INTO [dbo].[GoodsPublish]( 
				[UserId], 
				[Title], 
				[SubTitle], 
				[Condition],
				[Guid], 
				[Price], 
				[SalePrice], 
				[Msrp], 
				[CostPrice], 
				[SaleType], 
				-- 
				[Category], 
				[StoreCategory], 
				[Brand], 
				[ShipWithin], 
				[ModelSkuCode], 
				[State], 
				[Link], 
				[Description], 
				-- 
				[Video], 
				[VideoAlign], 
				[Active], 
				[Weight], 
				[Quantity], 
				-- 
				[ShippingPrice], 
				[WhoPay], 
				[ShippingMethod], 
				[ShipToLocation], 
				[PaymentMethod], 
				[GstType], 
				[OptionsStatus], 
				[CreatedDate], 
				[LastEdited], 
				[LastSync] 
			) 
			VALUES( 
				@UserId, 
				@Title, 
				@SubTitle, 
				@Condition, 
				@Guid, 
				@Price, 
				@SalePrice, 
				@Msrp, 
				@CostPrice, 
				@SaleType, 
				--
				@Category, 
				@StoreCategory, 
				@Brand, 
				@ShipWithin, 
				@ModelSkuCode, 
				@State, 
				@Link, 
				@Description, 
				-- 
				@Video, 
				@VideoAlign , 
				@Active, 
				@Weight, 
				@Quantity, 
				-- 
				@ShippingPrice, 
				@WhoPay, 
				@ShippingMethod, 
				@ShipToLocation, 
				@PaymentMethod, 
				@GstType, 
				@OptionsStatus, 
				GETDATE(), 
				NULL, 
				NULL 
			) 
			-- 
			SELECT @v_goodpublishid = SCOPE_IDENTITY() 
			--
			DELETE FROM [dbo].[GoodsPublishPhoto] WHERE [GoodPublishId] = @v_goodpublishid 
		END
		-- Insert Photo
		INSERT INTO [dbo].[GoodsPublishPhoto]
		(
			[GoodPublishId],
			[PhotoName],
			[PhotoUrl],
			[PhotoDescription] 
		)
		SELECT @v_goodpublishid, 
			[PhotoName], 
			[PhotoUrl], 
			[PhotoDescription] 
		FROM @GoodsPublishPhoto 
		COMMIT TRANSACTION 
	END TRY 
	BEGIN CATCH 
		--Raise Error 
		DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT, @ErrState INT 
		SELECT @ErrMsg = ERROR_NUMBER() + '- (' + ERROR_PROCEDURE() + '): ' + ERROR_MESSAGE(), 
			@ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE() 

		RAISERROR(@ErrMsg, @ErrSeverity, @ErrState) 

		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
	END CATCH
	RETURN @v_goodpublishid
END 
GO 
----------------------------------------------
-- sp GoodsPublish Update
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublish_Update]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublish_Update] 
GO 
---- type PhotoTableType 
IF EXISTS (SELECT * FROM sys.types WHERE is_user_defined = 1 AND NAME = 'PhotoTypeUpd') 
DROP TYPE [dbo].[PhotoTypeUpd]
GO
CREATE TYPE [dbo].[PhotoTypeUpd] AS TABLE 
(
	[PhotoId] INT,   
	[GoodPublishId] INT, 
	[PhotoName] NVARCHAR(255), 
	[PhotoUrl] VARCHAR(255), 
	[PhotoDescription] NVARCHAR(500) 
)
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublish Update
-- =============================================
CREATE PROCEDURE [dbo].[GoodsPublish_Update] 
	@GoodPublishId INT, 
	@UserId INT, 
	@Title NVARCHAR(255), 
	@SubTitle NVARCHAR(255), 
	@Condition NVARCHAR(255),
	@Guid VARCHAR(50), 
	@Price REAL, 
	@SalePrice REAL, 
	@Msrp REAL, 
	@CostPrice REAL, 
	@SaleType NVARCHAR(255), 
	-- 
	@Category NVARCHAR(255), 
	@StoreCategory INT, 
	@Brand NVARCHAR(255), 
	@ShipWithin INT, 
	@ModelSkuCode NVARCHAR(255), 
	@State NVARCHAR(255), 
	@Link NVARCHAR(500), 
	@Description NVARCHAR(1024), 
	-- 
	@Video NVARCHAR(500), 
	@VideoAlign NVARCHAR(255), 
	@Active INT, 
	@Weight INT, 
	@Quantity INT, 
	-- 
	@ShippingPrice NVARCHAR(255), 
	@WhoPay NVARCHAR(255), 
	@ShippingMethod NVARCHAR(255), 
	@ShipToLocation NVARCHAR(255), 
	@PaymentMethod NVARCHAR(255), 
	@GstType INT, 
	@OptionsStatus INT, 
	@LastSync DATE, 
	@GoodsPublishPhoto [dbo].[PhotoTypeUpd] READONLY 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		UPDATE [dbo].[GoodsPublish] SET 
			[UserId] = @UserId, 
			[Title] = @Title, 
			[SubTitle] = @SubTitle, 
			[Condition] = @Condition, 
			[Guid] = @Guid, 
			[Price] = @Price, 
			[SalePrice] = @SalePrice, 
			[Msrp] = @Msrp, 
			[CostPrice] = @CostPrice, 
			[SaleType] = @SaleType, 
			-- 
			[Category] = @Category, 
			[StoreCategory] = @StoreCategory, 
			[Brand] = @Brand, 
			[ShipWithin] = @ShipWithin, 
			[ModelSkuCode] = @ModelSkuCode, 
			[State] = @State, 
			[Link] = @Link, 
			[Description] = @Description, 
			-- 
			[Video] = @Video, 
			[VideoAlign] = @VideoAlign, 
			[Active] = @Active, 
			[Weight] = @Weight, 
			[Quantity] = @Quantity, 
			-- 
			[ShippingPrice] = @ShippingPrice, 
			[WhoPay] = @WhoPay, 
			[ShippingMethod] = @ShippingMethod, 
			[ShipToLocation] = @ShipToLocation, 
			[PaymentMethod] = @PaymentMethod, 
			[GstType] = @GstType, 
			[OptionsStatus] = @OptionsStatus, 
			[LastEdited] = GETDATE(), 
			[LastSync] = @LastSync 
		WHERE [GoodPublishId] = @GoodPublishId 
		--- Update Photo
		UPDATE [dbo].[GoodsPublishPhoto] SET 
			[PhotoName] = P.[PhotoName],  
			[PhotoUrl] = P.[PhotoUrl], 
			[PhotoDescription] = P.[PhotoDescription] 
		FROM [dbo].[GoodsPublishPhoto] GP
		INNER JOIN @GoodsPublishPhoto P ON (GP.PhotoId = P.PhotoId) 
			   AND (GP.[GoodPublishId] = @GoodPublishId) 
		  
		COMMIT TRANSACTION 
	END TRY 
	BEGIN CATCH 
		--Raise Error 
		DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT, @ErrState INT 
		SELECT @ErrMsg = ERROR_NUMBER() + '- (' + ERROR_PROCEDURE() + '): ' + ERROR_MESSAGE(), 
			@ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE() 

		RAISERROR(@ErrMsg, @ErrSeverity, @ErrState) 
		--Rollback
		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
	END CATCH
END 
GO 
------------------------------------------------
-- sp GoodsPublish Select By Id
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublish_SelectById]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublish_SelectById] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublish Select by Id
-- =============================================
CREATE PROCEDURE [dbo].[GoodsPublish_SelectById] 
	@GoodPublishId INT, 
	@UserId INT 
AS 
BEGIN 
	SELECT 
		[GoodPublishId], 
		[UserId], 
		[Title], 
		[SubTitle], 
		[Condition], 
		[Guid], 
		[Price], 
		[SalePrice], 
		[Msrp], 
		[CostPrice], 
		[SaleType], 
		-- 
		[Category], 
		[StoreCategory], 
		[Brand], 
		[ShipWithin], 
		[ModelSkuCode], 
		[State], 
		[Link], 
		[Description], 
		-- 
		[Video], 
		[VideoAlign], 
		[Active], 
		[Weight], 
		[Quantity], 
		-- 
		[ShippingPrice], 
		[WhoPay], 
		[ShippingMethod], 
		[ShipToLocation], 
		[PaymentMethod], 
		[GstType], 
		[OptionsStatus], 
		[CreatedDate], 
		[LastEdited], 
		[LastSync] 
	FROM [dbo].[GoodsPublish] G 
	WHERE [GoodPublishId] = @GoodPublishId 
	  AND [UserId] = @UserId 
	  AND [Active] <> 0 
	-- Get photo by Goods Id
	SELECT 
		P.[PhotoId], 
		P.[PhotoName],
		P.[PhotoUrl], 
		P.[PhotoDescription] 
	FROM [dbo].[GoodsPublishPhoto] P 
	INNER JOIN [dbo].[GoodsPublish] G ON P.[GoodPublishId] = G.[GoodPublishId] 
	WHERE P.[GoodPublishId] = @GoodPublishId 
	  AND G.[UserId] = @UserId 
	  AND G.[Active] <> 0
END 
GO 
------------------------------------------------
-- sp GoodsPublish Select By Guid
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublish_SelectByGuid]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublish_SelectByGuid] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublish Select by Guid
-- =============================================
CREATE PROCEDURE [dbo].[GoodsPublish_SelectByGuid] 
	@Guid VARCHAR(50), 
	@UserId INT 
AS 
BEGIN 
	SELECT 
		G.[GoodPublishId], 
		[UserId], 
		[Title], 
		[SubTitle], 
		[Condition], 
		[Guid], 
		[Price], 
		[SalePrice], 
		[Msrp], 
		[CostPrice], 
		[SaleType], 
		-- 
		[Category], 
		[StoreCategory], 
		[Brand], 
		[ShipWithin], 
		[ModelSkuCode], 
		[State], 
		[Link], 
		[Description], 
		-- 
		[Video], 
		[VideoAlign], 
		[Active], 
		[Weight], 
		[Quantity], 
		-- 
		[ShippingPrice], 
		[WhoPay], 
		[ShippingMethod], 
		[ShipToLocation], 
		[PaymentMethod], 
		[GstType], 
		[OptionsStatus], 
		[CreatedDate], 
		[LastEdited], 
		[LastSync] 
	FROM [dbo].[GoodsPublish] G	
	WHERE G.[Guid] = @Guid 
	  AND G.[UserId] = @UserId 
	  AND [Active] <> 0 
	-- 
	SELECT 
		[PhotoId], 
		[PhotoName],
		[PhotoUrl], 
		[PhotoDescription] 
	FROM [dbo].[GoodsPublishPhoto] P
	/*WHERE [GoodPublishId] = 
	  (SELECT [GoodPublishId] FROM [dbo].[GoodsPublish] WHERE [Guid] = @Guid)*/
	INNER JOIN [dbo].[GoodsPublish] G ON P.[GoodPublishId] = G.[GoodPublishId] 
	WHERE G.[Guid] = @Guid 
	  AND G.[UserId] = @UserId 
	  AND [Active] <> 0 
END 
GO 
------------------------------------------------
-- sp GoodsPublish Select By List Guid
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublish_SelectByListGuid]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublish_SelectByListGuid] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublish Select by List Guid
-- =============================================
CREATE PROCEDURE [dbo].[GoodsPublish_SelectByListGuid] 
	@ListGuid VARCHAR(4000), 
	@UserId INT 
AS 
BEGIN 
	SELECT 
		G.[GoodPublishId], 
		[UserId], 
		[Title], 
		[SubTitle], 
		[Condition], 
		[Guid], 
		[Price], 
		[SalePrice], 
		[Msrp], 
		[CostPrice], 
		[SaleType], 
		-- 
		[Category], 
		[StoreCategory], 
		[Brand], 
		[ShipWithin], 
		[ModelSkuCode], 
		[State], 
		[Link], 
		[Description], 
		-- 
		[Video], 
		[VideoAlign], 
		[Active], 
		[Weight], 
		[Quantity], 
		-- 
		[ShippingPrice], 
		[WhoPay], 
		[ShippingMethod], 
		[ShipToLocation], 
		[PaymentMethod], 
		[GstType], 
		[OptionsStatus], 
		[CreatedDate], 
		[LastEdited], 
		[LastSync] 
	FROM [dbo].[GoodsPublish] G	
	WHERE [GoodPublishId] IN (
		SELECT [GoodPublishId] FROM [dbo].[GoodsPublish] P
		/*WHERE [Guid] IN(SELECT [Data] FROM [dbo].[fn_Split](@ListGuid, ','))*/
		INNER JOIN [dbo].[fn_Split](@ListGuid, ',') S ON P.[Guid] = S.[Data]) 
	AND G.[UserId] = @UserId 
	AND [Active] <> 0 
	-- 
	SELECT [PhotoId], G.[GoodPublishId], [PhotoName], [PhotoUrl], [PhotoDescription]  
	FROM [dbo].[GoodsPublishPhoto] P 
	INNER JOIN [dbo].[GoodsPublish] G ON P.[GoodPublishId] = G.[GoodPublishId] 
	WHERE G.[GoodPublishId] IN (
		SELECT [GoodPublishId] FROM [dbo].[GoodsPublish] G1
		/*WHERE [Guid] IN(SELECT [Data] FROM [dbo].[fn_Split](@ListGuid, ','))*/
		INNER JOIN [dbo].[fn_Split](@ListGuid, ',') S ON G1.[Guid] = S.[Data]) 
	AND G.[UserId] = @UserId 
	AND [Active] <> 0 
END 
GO 
------------------------------------------------
-- sp GoodsPublish Select All
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublish_SelectAll]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublish_SelectAll] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublish Select All
-- =============================================
CREATE PROCEDURE [dbo].[GoodsPublish_SelectAll] 
	@UserId INT 
AS 
BEGIN 
	SELECT 
		[GoodPublishId], 
		[UserId], 
		[Title], 
		[SubTitle], 
		[Condition],
		[Guid], 
		[Price], 
		[SalePrice], 
		[Msrp], 
		[CostPrice], 
		[SaleType], 
		-- 
		[Category], 
		[StoreCategory], 
		[Brand], 
		[ShipWithin], 
		[ModelSkuCode], 
		[State], 
		[Link], 
		[Description], 
		-- 
		[Video], 
		[VideoAlign], 
		[Active], 
		[Weight], 
		[Quantity], 
		-- 
		[ShippingPrice], 
		[WhoPay], 
		[ShippingMethod], 
		[ShipToLocation], 
		[PaymentMethod], 
		[GstType], 
		[OptionsStatus], 
		[CreatedDate], 
		[LastEdited], 
		[LastSync]  
	FROM [dbo].[GoodsPublish] 
	WHERE [UserId] = @UserId 
	  AND [Active] <> 0 
	ORDER BY [GoodPublishId] DESC 
	-- 
	SELECT [PhotoId], G.[GoodPublishId], [PhotoName], [PhotoUrl], [PhotoDescription]  
	FROM [dbo].[GoodsPublishPhoto] P 
	INNER JOIN [dbo].[GoodsPublish] G ON P.[GoodPublishId] = G.[GoodPublishId] 
	WHERE G.[UserId] = @UserId 
	  AND [Active] <> 0 
END 
GO 
------------------------------------------------
-- sp GoodPublish Delete
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodPublish_Delete]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodPublish_Delete] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodPublish Delete
-- =============================================
CREATE PROCEDURE [dbo].[GoodPublish_Delete] 
	@Guid VARCHAR(50) 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		-- delete by logic 
		UPDATE [GoodsPublish]
		SET [Active] = 0
		WHERE [Guid] = @Guid
		COMMIT TRANSACTION 
	END TRY 
	BEGIN CATCH 
		--Raise Error 
		DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT, @ErrState INT 
		SELECT @ErrMsg = ERROR_NUMBER() + '- (' + ERROR_PROCEDURE() + '): ' + ERROR_MESSAGE(), 
			@ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE() 

		RAISERROR(@ErrMsg, @ErrSeverity, @ErrState) 
		--Rollback
		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
	END CATCH
END 
GO 
------------------------------------------------