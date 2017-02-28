------------------------------------------------
USE LeLongDB 
GO 
------------------------------------------------
-- type PhotoTableType 
IF NOT EXISTS (SELECT * FROM sys.types WHERE is_user_defined = 1 AND NAME = 'PhotoTableType') 
CREATE TYPE [dbo].[PhotoTableType] AS TABLE 
(
	/*[PhotoId] INT,*/  
	[GoodPublishId] INT, 
	[PhotoName] NVARCHAR(255), 
	[PhotoUrl] VARCHAR(255), 
	[PhotoDescription] NVARCHAR(500) 
)
GO 
------------------------------------------------
-- sp GoodsPublish Insert
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_GoodsPublish_Ins]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_GoodsPublish_Ins] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublish Insert
-- =============================================
CREATE PROCEDURE [dbo].[usp_GoodsPublish_Ins] 
	@UserId INT, 
	@Title NVARCHAR(255), 
	@SubTitle NVARCHAR(255), 
	@Guid VARCHAR(50), 
	@SalePrice REAL, 
	@Msrp REAL, 
	@CostPrice REAL, 
	@SaleType NVARCHAR(255), 
	-- 
	@Category INT, 
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
	--
	@GoodsPublishPhoto [dbo].[PhotoTableType] READONLY 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		DECLARE @v_GoodsPublish_Id INT
		-- 
		INSERT INTO [dbo].[GoodsPublish]( 
			[UserId], 
			[Title], 
			[SubTitle], 
			[Guid], 
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
			@Guid, 
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
			@LastSync 
		) 
		-- 
		SET @v_GoodsPublish_Id = SCOPE_IDENTITY() 
		DECLARE @i INT = 0 
		WHILE (@i <= (SELECT MAX([GoodPublishId]) FROM @GoodsPublishPhoto)) 
		BEGIN 
			INSERT INTO [dbo].[GoodsPublishPhoto]
			(
				[GoodPublishId],
				[PhotoName],
				[PhotoUrl],
				[PhotoDescription] 
			)
			SELECT [GoodPublishId], 
				[PhotoName], 
				[PhotoUrl], 
				[PhotoDescription] 
			FROM @GoodsPublishPhoto 
			SET @i = @i+1 
		END -- End While
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
END 
GO 
------------------------------------------------
-- sp GoodsPublish Update
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_GoodsPublish_Upd]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_GoodsPublish_Upd] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublish Update
-- =============================================
CREATE PROCEDURE [dbo].[usp_GoodsPublish_Upd] 
	@GoodPublishId INT, 
	@UserId INT, 
	@Title NVARCHAR(255), 
	@SubTitle NVARCHAR(255), 
	@Guid VARCHAR(50), 
	@SalePrice REAL, 
	@Msrp REAL, 
	@CostPrice REAL, 
	@SaleType NVARCHAR(255), 
	-- 
	@Category INT, 
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
	@GoodsPublishPhoto [dbo].[PhotoTableType] READONLY 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		UPDATE [dbo].[GoodsPublish] SET 
			[UserId] = @UserId, 
			[Title] = @Title, 
			[SubTitle] = @SubTitle, 
			[Guid] = @Guid, 
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
		-- 
		DECLARE @i INT = 0 
		WHILE (@i <= (SELECT MAX([GoodPublishId]) FROM @GoodsPublishPhoto)) 
		BEGIN 
			UPDATE [dbo].[GoodsPublishPhoto] SET  
				[PhotoName] = T.[PhotoName],
				[PhotoUrl] = T.[PhotoUrl], 
				[PhotoDescription] = T.[PhotoDescription] 
			FROM @GoodsPublishPhoto T
			WHERE [GoodsPublishPhoto].[GoodPublishId] = @GoodPublishId 
			SET @i = @i+1 
		END 
		
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
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_GoodsPublish_SelById]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_GoodsPublish_SelById] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublish Select by Id
-- =============================================
CREATE PROCEDURE [dbo].[usp_GoodsPublish_SelById] 
	@GoodPublishId INT 
AS 
BEGIN 
	SELECT 
		G.[GoodPublishId], 
		[UserId], 
		[Title], 
		[SubTitle], 
		[Guid], 
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
		-- 
		P.[PhotoId], 
		P.[PhotoName],
		P.[PhotoUrl], 
		P.[PhotoDescription] 
	FROM [dbo].[GoodsPublish] G
	INNER JOIN [dbo].[GoodsPublishPhoto] P ON G.[GoodPublishId] = P.[GoodPublishId] 
	WHERE G.[GoodPublishId] = @GoodPublishId 
END 
GO 
------------------------------------------------
-- sp GoodsPublish Select By Guid
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_GoodsPublish_SelByGuid]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_GoodsPublish_SelByGuid] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublish Select by Guid
-- =============================================
CREATE PROCEDURE [dbo].[usp_GoodsPublish_SelByGuid] 
	@Guid VARCHAR(50) 
AS 
BEGIN 
	SELECT 
		G.[GoodPublishId], 
		[UserId], 
		[Title], 
		[SubTitle], 
		[Guid], 
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
		-- 
		P.[PhotoId], 
		P.[PhotoName],
		P.[PhotoUrl], 
		P.[PhotoDescription] 
	FROM [dbo].[GoodsPublish] G
	INNER JOIN [dbo].[GoodsPublishPhoto] P ON G.[GoodPublishId] = P.[GoodPublishId] 
	WHERE G.[Guid] = @Guid 
END 
GO 
------------------------------------------------
-- sp GoodsPublish Select All
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_GoodsPublish_SelAll]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_GoodsPublish_SelAll] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublish Select All
-- =============================================
CREATE PROCEDURE [dbo].[usp_GoodsPublish_SelAll] 
AS 
BEGIN 
	SELECT 
		G.[GoodPublishId], 
		[UserId], 
		[Title], 
		[SubTitle], 
		[Guid], 
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
		P.[PhotoId], 
		P.[PhotoName],
		P.[PhotoUrl], 
		P.[PhotoDescription] 
	FROM [dbo].[GoodsPublish] G 
	INNER JOIN [dbo].[GoodsPublishPhoto] P ON G.[GoodPublishId] = P.[GoodPublishId] 
END 
GO 
------------------------------------------------
-- sp GoodPublish Delete
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_GoodPublish_Del]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_GoodPublish_Del] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodPublish Delete
-- =============================================
CREATE PROCEDURE [dbo].[usp_GoodPublish_Del] 
	@GoodPublishId INT 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		DELETE [dbo].[GoodsPublish] 
		WHERE [GoodPublishId] = @GoodPublishId 
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