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
-- sp GoodsPublishPhoto Select By GoodsId
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublishPhoto_SelectByGoodPublishId]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublishPhoto_SelectByGoodPublishId] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublishPhoto select by GoodsId
-- =============================================
CREATE PROCEDURE [dbo].[GoodsPublishPhoto_SelectByGoodPublishId] 
	@GoodPublishId INT 
AS 
BEGIN 
	SELECT 
		[PhotoId], 
		[GoodPublishId],
		[PhotoName],
		[PhotoUrl],
		[PhotoDescription] 
	FROM [dbo].[GoodsPublishPhoto] 
	WHERE [GoodPublishId] = @GoodPublishId 
END 
GO 
------------------------------------------------
-- function split split to Table
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[fn_SplitToTable]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' )) 
DROP FUNCTION [dbo].[fn_SplitToTable] 
GO 
---- =============================================
---- Author:		ThaoND
---- Create date: 24-Feb-2017
---- Description:	function split string to array
---- =============================================
--CREATE FUNCTION [dbo].[fn_SplitToTable]
--( 
--	@listitems VARCHAR(8000)
--) 
--RETURNS @tableitems TABLE (item INT)
--AS 
--BEGIN 
--	DECLARE 
--        @LastCommaPosition INT, 
--        @NextCommaPosition INT, 
--        @EndOfStringPosition INT, 
--        @StartOfStringPosition INT, 
--        @LengthOfString INT, 
--        @ItemString VARCHAR(100), 
--        @IDValue INT 

--    SET @LastCommaPosition = 0 
--    SET @NextCommaPosition = -1 

--    IF LTRIM(RTRIM(@listitems)) <> ''
--    BEGIN

--        WHILE(@NextCommaPosition <> 0)
--        BEGIN
--            SET @NextCommaPosition = CHARINDEX(',',@listitems,@LastCommaPosition + 1)

--            IF @NextCommaPosition = 0 
--                SET @EndOfStringPosition = LEN(@listitems) 
--            ELSE 
--                SET @EndOfStringPosition = @NextCommaPosition - 1 

--            SET @StartOfStringPosition  = @LastCommaPosition + 1 
--            SET @LengthOfString = (@EndOfStringPosition + 1) - @StartOfStringPosition 
--            SET @ItemString =  SUBSTRING(@listitems,@StartOfStringPosition,@LengthOfString)               

--            IF (@ItemString <> '') 
--                INSERT @tableitems VALUES(@ItemString) 

--            SET @LastCommaPosition = @NextCommaPosition

--        END --WHILE(@NextCommaPosition <> 0)
--    END --IF LTRIM(RTRIM(@IDList)) <> ''

--    RETURN

--	--ErrorBlock:

--	--RETURN
--END 
--GO 
------------------------------------------------
-- function string to Table
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[fn_StringToTable]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' )) 
DROP FUNCTION [dbo].[fn_StringToTable] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	function split string to Table
-- =============================================
CREATE FUNCTION [dbo].[fn_StringToTable]
( 
	@list VARCHAR(8000)
) 
RETURNS @tbl TABLE (id INT)
AS 
BEGIN 
	DECLARE @pos        int,
           @nextpos    int,
           @valuelen   int

	SELECT @pos = 0, @nextpos = 1

	WHILE @nextpos > 0
	BEGIN
		SELECT @nextpos = charindex(',', @list, @pos + 1)
		SELECT @valuelen = CASE WHEN @nextpos > 0
								THEN @nextpos
								ELSE len(@list) + 1
							END - @pos - 1
		INSERT @tbl (id)
			VALUES (convert(int, substring(@list, @pos + 1, @valuelen)))
		SELECT @pos = @nextpos
	END
	RETURN
END 
GO 
------------------------------------------------
-- sp GoodsPublishPhoto Select By List GoodsId
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[GoodsPublishPhoto_SelectByListGoodsId]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[GoodsPublishPhoto_SelectByListGoodsId] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	GoodsPublishPhoto select by GoodsId
-- =============================================
CREATE PROCEDURE [dbo].[GoodsPublishPhoto_SelectByListGoodsId] 
	@ListGoodsId VARCHAR(1000) 
AS 
BEGIN 
	--DECLARE @query AS NVARCHAR(4000) 
	--SET @query = 'SELECT [PhotoId], [GoodPublishId], [PhotoName], [PhotoUrl], [PhotoDescription] 
	--			  FROM [dbo].[GoodsPublishPhoto] 
	--			  WHERE [GoodPublishId] IN (' + @ListGoodsId  + ')'
	--EXECUTE(@query)
	SELECT [PhotoId], [GoodPublishId], [PhotoName], [PhotoUrl], [PhotoDescription]  
	FROM [dbo].[GoodsPublishPhoto] 
	WHERE [GoodPublishId] IN (SELECT id FROM [fn_StringToTable](@ListGoodsId))
END 
GO 
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