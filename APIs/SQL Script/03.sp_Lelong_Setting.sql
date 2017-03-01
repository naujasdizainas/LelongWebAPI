------------------------------------------------
USE LeLongDB 
GO 
------------------------------------------------
-- sp Setting Insert
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[Setting_Insert]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[Setting_Insert] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Setting Insert
-- =============================================
CREATE PROCEDURE [dbo].[Setting_Insert] 
	@SettingFieldId VARCHAR(255), 
	@IsInstalled VARCHAR(255) 
AS 
BEGIN 
	BEGIN TRY 
		IF EXISTS (SELECT * FROM [dbo].[Setting] WHERE SettingFieldId = @SettingFieldId)
		RETURN -1

		BEGIN TRANSACTION 
		INSERT INTO [dbo].[Setting]( 
			SettingFieldId, 
			IsInstalled 
		) 
		VALUES( 
			@SettingFieldId, 
			@IsInstalled 
		)
		 
		RETURN SCOPE_IDENTITY()
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
-- sp Setting Select By
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[Setting_SelectById]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[Setting_SelectById] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Setting Select by Id
-- =============================================
CREATE PROCEDURE [dbo].[Setting_SelectById] 
	@SettingFieldId VARCHAR(255) 
AS 
BEGIN 
	SELECT 
		[SettingFieldId], 
		[IsInstalled] 
	FROM [dbo].[Setting] 
	WHERE [SettingFieldId] = @SettingFieldId 
END 
GO 
------------------------------------------------
-- sp Setting Select All
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[Setting_SelectAll]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[Setting_SelectAll] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Setting Select All
-- =============================================
CREATE PROCEDURE [dbo].[Setting_SelectAll] 
AS 
BEGIN 
	SELECT 
		[SettingFieldId], 
		[IsInstalled] 
	FROM [dbo].[Setting] 
END 
GO 
------------------------------------------------
-- sp Setting Update
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[Setting_Update]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[Setting_Update] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Setting Update
-- =============================================
CREATE PROCEDURE [dbo].[Setting_Update] 
	@SettingFieldId VARCHAR(255), 
	@IsInstalled VARCHAR(255) 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		UPDATE [dbo].[Setting] SET 
			[SettingFieldId] = @SettingFieldId, 
			[IsInstalled] = @IsInstalled
		WHERE [SettingFieldId] = @SettingFieldId 
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
-- sp Setting Delete
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[Setting_Delete]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[Setting_Delete] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Setting Delete
-- =============================================
CREATE PROCEDURE [dbo].[Setting_Delete] 
	@SettingFieldId VARCHAR(255) 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		DELETE [dbo].[Setting] 
		WHERE [SettingFieldId] = @SettingFieldId 
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