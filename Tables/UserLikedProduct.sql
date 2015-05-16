/****** Object:  Table [swapnal].[UserLikedProduct]    Script Date: 5/15/2015 10:19:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [swapnal].[UserLikedProduct](
	[UserCode] [uniqueidentifier] NOT NULL,
	[ProductCode] [uniqueidentifier] NOT NULL,
	[LikedDate] DATETIME NOT NULL
) ON [PRIMARY]

GO
