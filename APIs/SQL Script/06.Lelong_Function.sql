------------------------------------------------
USE LeLongDB 
GO 
------------------------------------------------
-- function string to Table
IF EXISTS (SELECT * FROM sys.objects  
			WHERE  object_id = OBJECT_ID(N'[dbo].[fn_Split]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' )) 
DROP FUNCTION [dbo].[fn_Split] 
GO 
-- =============================================
-- Author:		ThaoND
-- Create date: 24-Feb-2017
-- Description:	function split string by delimiter to Table
-- =============================================
CREATE FUNCTION [dbo].[fn_Split]
(
    @String NVARCHAR(4000),
    @Delimiter NCHAR(1)
)
RETURNS TABLE
AS
RETURN
(
    WITH Split(stpos,endpos)
    AS(
        SELECT 0 AS stpos, CHARINDEX(@Delimiter,@String) AS endpos
        UNION ALL
        SELECT endpos+1, CHARINDEX(@Delimiter,@String,endpos+1)
            FROM Split
            WHERE endpos > 0
    )
    SELECT 'Id' = ROW_NUMBER() OVER (ORDER BY (SELECT 1)),
        'Data' = SUBSTRING(@String,stpos,COALESCE(NULLIF(endpos,0),LEN(@String)+1)-stpos)
    FROM Split
)
GO 
--------------------------------------------------
---- function split to Table
--IF EXISTS (SELECT * FROM sys.objects  
--			WHERE  object_id = OBJECT_ID(N'[dbo].[fn_SplitToTable]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' )) 
--DROP FUNCTION [dbo].[fn_SplitToTable] 
--GO 
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
--------------------------------------------------
---- function string to Table
--IF EXISTS (SELECT * FROM sys.objects  
--			WHERE  object_id = OBJECT_ID(N'[dbo].[fn_StringToTable]') AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' )) 
--DROP FUNCTION [dbo].[fn_StringToTable] 
--GO 
---- =============================================
---- Author:		ThaoND
---- Create date: 24-Feb-2017
---- Description:	function split string to Table
---- =============================================
--CREATE FUNCTION [dbo].[fn_StringToTable]
--( 
--	@list VARCHAR(8000)
--) 
--RETURNS @tbl TABLE (id INT)
--AS 
--BEGIN 
--	DECLARE @pos        int,
--           @nextpos    int,
--           @valuelen   int

--	SELECT @pos = 0, @nextpos = 1

--	WHILE @nextpos > 0
--	BEGIN
--		SELECT @nextpos = charindex(',', @list, @pos + 1)
--		SELECT @valuelen = CASE WHEN @nextpos > 0
--								THEN @nextpos
--								ELSE len(@list) + 1
--							END - @pos - 1
--		INSERT @tbl (id)
--			VALUES (convert(int, substring(@list, @pos + 1, @valuelen)))
--		SELECT @pos = @nextpos
--	END
--	RETURN
--END 
--GO 
--------------------------------------------------