------------------------------------------------
USE LeLongDB 
GO 
------------------------------------------------
-- sp GoodsPublishPhoto Insert
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_GoodsPublishPhoto_Ins]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_GoodsPublishPhoto_Ins] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublishPhoto Insert
-- =============================================
CREATE PROCEDURE [dbo].[usp_GoodsPublishPhoto_Ins] 
	@GoodPublishId INT,
	@PhotoName NVARCHAR(255),
	@PhotoUrl VARCHAR(255),
	@PhotoDescription NVARCHAR(500) 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		INSERT INTO [dbo].[GoodsPublishPhoto]( 
			[GoodPublishId],
			[PhotoName],
			[PhotoUrl],
			[PhotoDescription]  
		) 
		VALUES( 
			@GoodPublishId,
			@PhotoName,
			@PhotoUrl,
			@PhotoDescription 
		) 
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
-- sp GoodsPublishPhoto Select By Id
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_GoodsPublishPhoto_SelById]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_GoodsPublishPhoto_SelById] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublishPhoto select by Id
-- =============================================
CREATE PROCEDURE [dbo].[usp_GoodsPublishPhoto_SelById] 
	@PhotoId INT 
AS 
BEGIN 
	SELECT 
		[PhotoId], 
		[GoodPublishId],
		[PhotoName],
		[PhotoUrl],
		[PhotoDescription] 
	FROM [dbo].[GoodsPublishPhoto] 
	WHERE [PhotoId] = @PhotoId 
END 
GO 
------------------------------------------------
-- sp GoodsPublishPhoto Select All
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_GoodsPublishPhoto_SelAll]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_GoodsPublishPhoto_SelAll] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublishPhoto Select All
-- =============================================
CREATE PROCEDURE [dbo].[usp_GoodsPublishPhoto_SelAll] 
AS 
BEGIN 
	SELECT 
		[PhotoId], 
		[GoodPublishId],
		[PhotoName],
		[PhotoUrl],
		[PhotoDescription] 
	FROM [dbo].[GoodsPublishPhoto] 
END 
GO 
------------------------------------------------
-- sp GoodsPublishPhoto Update
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_Setting_Upd]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_Setting_Upd] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublishPhoto Update
-- =============================================
CREATE PROCEDURE [dbo].[usp_GoodsPublishPhoto_Upd] 
	@PhotoId INT, 
	@GoodPublishId INT,
	@PhotoName NVARCHAR(255),
	@PhotoUrl VARCHAR(255),
	@PhotoDescription NVARCHAR(500) 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		UPDATE [dbo].[GoodsPublishPhoto] SET 
			[GoodPublishId] = @GoodPublishId,
			[PhotoName] = @PhotoName,
			[PhotoUrl] = @PhotoUrl,
			[PhotoDescription] = @PhotoDescription 
		WHERE [PhotoId] = @PhotoId 
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
-- sp GoodsPublishPhoto Delete
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_GoodsPublishPhoto_Del]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_GoodsPublishPhoto_Del] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublishPhoto Delete
-- =============================================
CREATE PROCEDURE [dbo].[usp_GoodsPublishPhoto_Del] 
	@PhotoId INT 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		DELETE [dbo].[GoodsPublishPhoto] 
		WHERE [PhotoId] = @PhotoId 
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