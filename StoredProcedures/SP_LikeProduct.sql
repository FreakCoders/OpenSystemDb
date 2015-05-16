SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Code King Maker
-- Create date: 16/05/2015
-- Description:	Like/Unlike product 
-- =============================================
CREATE PROCEDURE [swapnil].[SP_LikeProduct] 
	-- Add the parameters for the stored procedure here
	@UserCode AS [uniqueidentifier] = NULL,
	@ProductCode AS [uniqueidentifier] = NULL,
	@IsLiked AS BIT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @LikeCount INT
	SET @LikeCount = 0
	IF(@IsLiked = 1)
	BEGIN
		IF NOT EXISTS (SELECT NULL FROM [swapnil].[UserLikedProduct] WHERE ProdcutId = @ProductCode AND UserId = @UserCode)
		BEGIN
			INSERT INTO [swapnil].[UserLikedProduct](UserId, ProductId, LikedDate)
				VALUES(@UserCode, @ProductCode, GETDATE())
			SELECT @LikeCount = ISNULL(LikeCount, 0) FROM [swapnil].[ProductCatalogue] WHERE ProductCode = @ProductCode
			SET @LikeCount = @LikeCount + 1
			UPDATE [swapnil].[ProductCatalogue] SET LikedCount = @LikeCount WHERE ProductCode = @ProductCode					
		END
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT NULL FROM [swapnil].[UserLikedProduct] WHERE ProdcutId = @ProductId AND UserId = @UserCode)
		BEGIN
			DELETE FROM [swapnil].[UserLikedProduct] WHERE UserID =  @UserCode AND ProductId = @ProductId
			SELECT @LikeCount = LikeCount FROM [swapnil].[ProductCatalogue] WHERE ProductCode = @ProductId
			SET @LikeCount = @LikeCount - 1
			UPDATE [swapnil].[ProductCatalogue] SET LikedCount = @LikCount WHERE ProductCode = @ProductId					
		END
	END
	IF @IsSuccess = 1	
		SELECT @IsSuccess AS ResultValue, 'Success' AS Result, @LikeCount AS LikeCount
	ELSE
		SELECT @IsSuccess AS ResultValue, 'Something went wrong' AS Result
END
GO
