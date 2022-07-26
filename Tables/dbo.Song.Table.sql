/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2012 (11.0.6020)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2012
    Target Database Engine Edition : Microsoft SQL Server Express Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [Music]
GO
/****** Object:  Table [dbo].[Song]    Script Date: 2021-08-08 4:10:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Song](
	[isrc] [char](14) NOT NULL,
	[title] [varchar](30) NULL,
	[songyear] [int] NULL,
	[artistname] [varchar](30) NULL,
 CONSTRAINT [PK__Song] PRIMARY KEY CLUSTERED 
(
	[isrc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Key_Candidate] UNIQUE NONCLUSTERED 
(
	[title] ASC,
	[artistname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Song]  WITH CHECK ADD  CONSTRAINT [Fk_Artist_Song] FOREIGN KEY([artistname])
REFERENCES [dbo].[Artist] ([artistname])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Song] CHECK CONSTRAINT [Fk_Artist_Song]
GO
ALTER TABLE [dbo].[Song]  WITH CHECK ADD  CONSTRAINT [CHK_songYr] CHECK  (([dbo].[ext]([artistname])<=[songyear]))
GO
ALTER TABLE [dbo].[Song] CHECK CONSTRAINT [CHK_songYr]
GO
