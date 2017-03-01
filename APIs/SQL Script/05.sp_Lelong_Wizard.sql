------------------------------------------------
USE LeLongDB 
GO 
------------------------------------------------
-- sp Wizard Insert
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[Wizard_Insert]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[Wizard_Insert] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Wizard Insert
-- =============================================
CREATE PROCEDURE [dbo].[Wizard_Insert] 
	@UserId INT, 
	@DaysOfShip INT, 
	@ItemsCategory NVARCHAR(255), 
	@ShippingFee NVARCHAR(255) 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		INSERT INTO [dbo].[Wizard]( 
			[UserId], 
			[DaysOfShip], 
			[ItemsCategory], 
			[ShippingFee]  
		) 
		VALUES( 
			@UserId, 
			@DaysOfShip, 
			@ItemsCategory, 
			@ShippingFee 
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
-- sp Wizard Select By
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[Wizard_SelectById]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[Wizard_SelectById] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Wizard Select by Id
-- =============================================
CREATE PROCEDURE [dbo].[Wizard_SelectById] 
	@WizardId INT 
AS 
BEGIN 
	SELECT 
		[WizardId], 
		[UserId], 
		[DaysOfShip], 
		[ItemsCategory], 
		[ShippingFee] 
	FROM [dbo].[Wizard] 
	WHERE [WizardId] = @WizardId 
END 
GO 
------------------------------------------------
-- sp Wizard Select All
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[Wizard_SectlAll]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[Wizard_SelectAll] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Wizard Select All
-- =============================================
CREATE PROCEDURE [dbo].[Wizard_SelectAll] 
AS 
BEGIN 
	SELECT 
		[WizardId], 
		[UserId], 
		[DaysOfShip], 
		[ItemsCategory], 
		[ShippingFee] 
	FROM [dbo].[Wizard] 
END 
GO 
------------------------------------------------
-- sp Wizard Update
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[Wizard_Update]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[Wizard_Update] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Wizard Update
-- =============================================
CREATE PROCEDURE [dbo].[Wizard_Update] 
	@WizardId INT, 
	@UserId INT, 
	@DaysOfShip INT, 
	@ItemsCategory NVARCHAR(255), 
	@ShippingFee NVARCHAR(255) 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		UPDATE [dbo].[Wizard] SET 
			[WizardId] = @WizardId, 
			[UserId] = @UserId, 
			[DaysOfShip] = @DaysOfShip, 
			[ItemsCategory] = @ItemsCategory, 
			[ShippingFee] = @ShippingFee 
		WHERE [WizardId] = @WizardId 
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
-- sp Wizard Delete
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[Wizard_Delete]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[Wizard_Delete] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Wizard Delete
-- =============================================
CREATE PROCEDURE [dbo].[Wizard_Delete] 
	@WizardId INT 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		DELETE [dbo].[Wizard] 
		WHERE [WizardId] = @WizardId 
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