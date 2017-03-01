------------------------------------------------
USE LeLongDB 
GO 
------------------------------------------------
-- sp Wizard Insert
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_Wizard_Ins]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_Wizard_Ins] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Wizard Insert
-- =============================================
CREATE PROCEDURE [dbo].[usp_Wizard_Ins] 
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
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_Wizard_SelById]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_Wizard_SelById] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Wizard Select by Id
-- =============================================
CREATE PROCEDURE [dbo].[usp_Wizard_SelById] 
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
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_Wizard_SelAll]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_Wizard_SelAll] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Wizard Select All
-- =============================================
CREATE PROCEDURE [dbo].[usp_Wizard_SelAll] 
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
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_Wizard_Upd]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_Wizard_Upd] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Wizard Update
-- =============================================
CREATE PROCEDURE [dbo].[usp_Wizard_Upd] 
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
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_Wizard_Del]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_Wizard_Del] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	Wizard Delete
-- =============================================
CREATE PROCEDURE [dbo].[usp_Wizard_Del] 
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