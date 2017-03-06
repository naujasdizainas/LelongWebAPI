------------------------------------------------
USE LeLongDB 
GO 
------------------------------------------------
-- sp GoodsPublishPhoto Insert
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublishPhoto_Insert]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublishPhoto_Insert] 
GO 
---- =============================================
---- Author:		ThaoND
---- Create date: 24-Feb-2017
---- Description:	GoodsPublishPhoto Insert
---- =============================================
--CREATE PROCEDURE [dbo].[GoodsPublishPhoto_Insert] 
--	@GoodPublishId INT,
--	@PhotoName NVARCHAR(255),
--	@PhotoUrl VARCHAR(255),
--	@PhotoDescription NVARCHAR(500) 
--AS 
--BEGIN 
--	BEGIN TRY 
--		BEGIN TRANSACTION 
--		INSERT INTO [dbo].[GoodsPublishPhoto]( 
--			[GoodPublishId],
--			[PhotoName],
--			[PhotoUrl],
--			[PhotoDescription]  
--		) 
--		VALUES( 
--			@GoodPublishId,
--			@PhotoName,
--			@PhotoUrl,
--			@PhotoDescription 
--		) 
--		COMMIT TRANSACTION 
--	END TRY 
--	BEGIN CATCH 
--		--Raise Error 
--		DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT, @ErrState INT 
--		SELECT @ErrMsg = ERROR_NUMBER() + '- (' + ERROR_PROCEDURE() + '): ' + ERROR_MESSAGE(), 
--			@ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE() 

--		RAISERROR(@ErrMsg, @ErrSeverity, @ErrState) 

--		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
--	END CATCH
--END 
--GO 
------------------------------------------------
-- sp GoodsPublishPhoto Update
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublishPhoto_Update]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublishPhoto_Update] 
GO 
---- =============================================
---- Author:		ThaoND
---- Create date: 24-Feb-2017
---- Description:	GoodsPublishPhoto Update
---- =============================================
--CREATE PROCEDURE [dbo].[GoodsPublishPhoto_Update] 
--	@PhotoId INT, 
--	@GoodPublishId INT,
--	@PhotoName NVARCHAR(255),
--	@PhotoUrl VARCHAR(255),
--	@PhotoDescription NVARCHAR(500) 
--AS 
--BEGIN 
--	BEGIN TRY 
--		BEGIN TRANSACTION 
--		UPDATE [dbo].[GoodsPublishPhoto] SET 
--			[GoodPublishId] = @GoodPublishId,
--			[PhotoName] = @PhotoName,
--			[PhotoUrl] = @PhotoUrl,
--			[PhotoDescription] = @PhotoDescription 
--		WHERE [PhotoId] = @PhotoId 
--		COMMIT TRANSACTION 
--	END TRY 
--	BEGIN CATCH 
--		--Raise Error 
--		DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT, @ErrState INT 
--		SELECT @ErrMsg = ERROR_NUMBER() + '- (' + ERROR_PROCEDURE() + '): ' + ERROR_MESSAGE(), 
--			@ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE() 

--		RAISERROR(@ErrMsg, @ErrSeverity, @ErrState) 
--		--Rollback
--		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
--	END CATCH
--END 
--GO 
------------------------------------------------
-- sp GoodsPublishPhoto Select By Id
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublishPhoto_SelectById]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublishPhoto_SelectById] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublishPhoto select by Id
-- =============================================
CREATE PROCEDURE [dbo].[GoodsPublishPhoto_SelectById] 
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
-- sp GoodsPublishPhoto Get Url
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublishPhoto_Get_Url]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublishPhoto_Get_Url] 
GO 
-- =============================================
-- Author:		Thangtv
-- Create date: 24-Feb-2017
-- Description:	GoodsPublishPhoto update Url after saved in folder serve
-- =============================================
CREATE PROCEDURE [dbo].[GoodsPublishPhoto_Get_Url] 
	@Name VARCHAR(200)  
AS 
BEGIN 
     SELECT PhotoUrl FROM dbo.GoodsPublishPhoto WHERE PhotoName = @Name
END 
GO 
------------------------------------------------
-- sp GoodsPublishPhoto update Url
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublishPhoto_Update_Url]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublishPhoto_Update_Url] 
GO 
-- =============================================
-- Author:		Thangtv
-- Create date: 24-Feb-2017
-- Description:	GoodsPublishPhoto update Url after saved in folder serve
-- =============================================
CREATE PROCEDURE [dbo].[GoodsPublishPhoto_Update_Url] 
	@Url VARCHAR(255),
	@Name VARCHAR(200)  
AS 
BEGIN 

     UPDATE [dbo].[GoodsPublishPhoto]  SET [PhotoUrl] = @Url
	 WHERE [PhotoName] = @Name
		
END 
GO 
------------------------------------------------
-- sp GoodsPublishPhoto Select By GoodsId
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublishPhoto_SelectByGoodPublishId]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublishPhoto_SelectByGoodPublishId] 
GO 
---- =============================================
---- Author:		ThaoND
---- Create date: 24-Feb-2017
---- Description:	GoodsPublishPhoto select by GoodsId
---- =============================================
--CREATE PROCEDURE [dbo].[GoodsPublishPhoto_SelectByGoodPublishId] 
--	@GoodPublishId INT 
--AS 
--BEGIN 
--	SELECT 
--		[PhotoId], 
--		[GoodPublishId],
--		[PhotoName],
--		[PhotoUrl],
--		[PhotoDescription] 
--	FROM [dbo].[GoodsPublishPhoto] 
--	WHERE [GoodPublishId] = @GoodPublishId 
--END 
--GO 
------------------------------------------------
-- sp GoodsPublishPhoto Select By List GoodsId
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublishPhoto_SelectByListGoodsId]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublishPhoto_SelectByListGoodsId] 
GO 
---- =============================================
---- Author:		ThaoND
---- Create date: 24-Feb-2017
---- Description:	GoodsPublishPhoto select by GoodsId
---- =============================================
--CREATE PROCEDURE [dbo].[GoodsPublishPhoto_SelectByListGoodsId] 
--	@ListGoodsId VARCHAR(1000) 
--AS 
--BEGIN 
--	--DECLARE @query AS NVARCHAR(4000) 
--	--SET @query = 'SELECT [PhotoId], [GoodPublishId], [PhotoName], [PhotoUrl], [PhotoDescription] 
--	--			  FROM [dbo].[GoodsPublishPhoto] 
--	--			  WHERE [GoodPublishId] IN (' + @ListGoodsId  + ')'
--	--EXECUTE(@query)
--	SELECT [PhotoId], [GoodPublishId], [PhotoName], [PhotoUrl], [PhotoDescription]  
--	FROM [dbo].[GoodsPublishPhoto] 
--	WHERE [GoodPublishId] IN (SELECT id FROM [fn_StringToTable](@ListGoodsId))
--END 
--GO 
------------------------------------------------
-- sp GoodsPublishPhoto Select All
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublishPhoto_SelectAll]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublishPhoto_SelectAll] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublishPhoto Select All
-- =============================================
CREATE PROCEDURE [dbo].[GoodsPublishPhoto_SelectAll] 
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
-- sp GoodsPublishPhoto Delete
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublishPhoto_Delete]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublishPhoto_Delete] 
GO 
---- =============================================
---- Author:		ThaoND
---- Create date: 24-Feb-2017
---- Description:	GoodsPublishPhoto Delete
---- =============================================
--CREATE PROCEDURE [dbo].[GoodsPublishPhoto_Delete] 
--	@PhotoId INT 
--AS 
--BEGIN 
--	BEGIN TRY 
--		BEGIN TRANSACTION 
--		DELETE [dbo].[GoodsPublishPhoto] 
--		WHERE [PhotoId] = @PhotoId 
--		COMMIT TRANSACTION 
--	END TRY 
--	BEGIN CATCH 
--		--Raise Error 
--		DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT, @ErrState INT 
--		SELECT @ErrMsg = ERROR_NUMBER() + '- (' + ERROR_PROCEDURE() + '): ' + ERROR_MESSAGE(), 
--			@ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE() 

--		RAISERROR(@ErrMsg, @ErrSeverity, @ErrState) 
--		--Rollback
--		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
--	END CATCH
--END 
--GO 
------------------------------------------------
-- sp GoodsPublishPhoto Delete by Goods Id
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublishPhoto_DeleteByGoodPublishId]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublishPhoto_DeleteByGoodPublishId] 
GO 
---- =============================================
---- Author:		ThaoND
---- Create date: 24-Feb-2017
---- Description:	GoodsPublishPhoto Delete
---- =============================================
--CREATE PROCEDURE [dbo].[GoodsPublishPhoto_DeleteByGoodPublishId] 
--	@GoodPublishId INT 
--AS 
--BEGIN 
--	BEGIN TRY 
--		BEGIN TRANSACTION 
--		DELETE [dbo].[GoodsPublishPhoto] 
--		WHERE [GoodPublishId] = @GoodPublishId 
--		COMMIT TRANSACTION 
--	END TRY 
--	BEGIN CATCH 
--		--Raise Error 
--		DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT, @ErrState INT 
--		SELECT @ErrMsg = ERROR_NUMBER() + '- (' + ERROR_PROCEDURE() + '): ' + ERROR_MESSAGE(), 
--			@ErrSeverity = ERROR_SEVERITY(), @ErrState = ERROR_STATE() 

--		RAISERROR(@ErrMsg, @ErrSeverity, @ErrState) 
--		--Rollback
--		IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
--	END CATCH
--END 
--GO 
------------------------------------------------