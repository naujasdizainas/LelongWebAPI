------------------------------------------------
USE LeLongDB 
GO 
------------------------------------------------
-- sp Setting Insert
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_Setting_Ins]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_Setting_Ins] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Setting Insert
-- =============================================
CREATE PROCEDURE [dbo].[usp_Setting_Ins] 
	@SettingFieldId VARCHAR(255), 
	@IsInstalled VARCHAR(255), 
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
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_Setting_SelById]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_Setting_SelById] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Setting Select by Id
-- =============================================
CREATE PROCEDURE [dbo].[usp_Setting_SelById] 
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
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_Setting_SelAll]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_Setting_SelAll] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Setting Select All
-- =============================================
CREATE PROCEDURE [dbo].[usp_Setting_SelAll] 
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
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_Setting_Upd]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_Setting_Upd] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Setting Update
-- =============================================
CREATE PROCEDURE [dbo].[usp_Setting_Upd] 
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
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_Setting_Del]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_Setting_Del] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Setting Delete
-- =============================================
CREATE PROCEDURE [dbo].[usp_Setting_Del] 
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