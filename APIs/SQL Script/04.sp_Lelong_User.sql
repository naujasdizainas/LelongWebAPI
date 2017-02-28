------------------------------------------------
USE LeLongDB
GO
------------------------------------------------
-- sp User Insert
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_User_Ins]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_User_Ins] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	User Insert
-- =============================================
CREATE PROCEDURE [dbo].[usp_User_Ins] 
	@UserName VARCHAR(255), 
	@PassWord VARCHAR(255), 
	@Access_Token VARCHAR(255), 
	@Refresh_Token VARCHAR(255), 
	@LoginAttempt INT, 
	@MaxPostingAllow INT, 
	@PostingAlready INT, 
	@NumberOfPhotosAllow INT 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		INSERT INTO [dbo].[User]( 
			[UserName], 
			[PassWord], 
			[Access_Token], 
			[Refresh_Token], 
			[LoginAttempt], 
			[MaxPostingAllow], 
			[PostingAlready], 
			[NumberOfPhotosAllow] 
		) 
		VALUES( 
			@UserName, 
			@PassWord, 
			@Access_Token, 
			@Refresh_Token, 
			@LoginAttempt, 
			@MaxPostingAllow, 
			@PostingAlready, 
			@NumberOfPhotosAllow  
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
-- sp User Select By
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_User_SelById]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_User_SelById] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	User Select by Id
-- =============================================
CREATE PROCEDURE [dbo].[usp_User_SelById] 
	@UserId INT 
AS 
BEGIN 
	SELECT 
		[UserId], 
		[UserName], 
		[PassWord], 
		[Access_Token], 
		[Refresh_Token], 
		[LoginAttempt], 
		[MaxPostingAllow], 
		[PostingAlready], 
		[NumberOfPhotosAllow] 
	FROM [dbo].[User] 
	WHERE [UserId] = @UserId 
END 
GO 
------------------------------------------------
-- sp User Select All
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_User_SelAll]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_User_SelAll] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	User Select All
-- =============================================
CREATE PROCEDURE [dbo].[usp_User_SelAll] 
AS 
BEGIN 
	SELECT 
		[UserId], 
		[UserName], 
		[PassWord], 
		[Access_Token], 
		[Refresh_Token], 
		[LoginAttempt], 
		[MaxPostingAllow], 
		[PostingAlready], 
		[NumberOfPhotosAllow] 
	FROM [dbo].[User] 
END 
GO 
------------------------------------------------
-- sp User Update
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_User_Upd]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_User_Upd] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	User Update
-- =============================================
CREATE PROCEDURE [dbo].[usp_User_Upd] 
	@UserId INT, 
	@UserName VARCHAR(255), 
	@PassWord VARCHAR(255), 
	@Access_Token VARCHAR(255), 
	@Refresh_Token VARCHAR(255), 
	@LoginAttempt INT, 
	@MaxPostingAllow INT, 
	@PostingAlready INT, 
	@NumberOfPhotosAllow INT 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		UPDATE [dbo].[User] SET 
			[UserName] = @UserName, 
			[PassWord] = @PassWord, 
			[Access_Token] = @Access_Token, 
			[Refresh_Token] = @Refresh_Token, 
			[LoginAttempt] = @LoginAttempt, 
			[MaxPostingAllow] = @MaxPostingAllow, 
			[PostingAlready] = @PostingAlready, 
			[NumberOfPhotosAllow] = @NumberOfPhotosAllow 
		WHERE [UserId] = @UserId 
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
-- sp User Delete
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[usp_User_Del]') AND type IN (N'P', N'PC')) 
DROP PROCEDURE [dbo].[usp_User_Del] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	User Delete
-- =============================================
CREATE PROCEDURE [dbo].[usp_User_Del] 
	@UserId INT 
AS 
BEGIN 
	BEGIN TRY 
		BEGIN TRANSACTION 
		DELETE [dbo].[User] 
		WHERE [UserId] = @UserId 
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