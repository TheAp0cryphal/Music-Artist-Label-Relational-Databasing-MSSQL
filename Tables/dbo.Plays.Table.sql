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
/****** Object:  Table [dbo].[Plays]    Script Date: 2021-08-08 4:10:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Plays](
	[artistname] [varchar](30) NOT NULL,
	[msin] [char](5) NOT NULL,
	[share] [decimal](18, 3) NULL,
 CONSTRAINT [PK_Group] PRIMARY KEY CLUSTERED 
(
	[msin] ASC,
	[artistname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Plays]  WITH CHECK ADD  CONSTRAINT [FK_Artist_Plays] FOREIGN KEY([artistname])
REFERENCES [dbo].[Artist] ([artistname])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Plays] CHECK CONSTRAINT [FK_Artist_Plays]
GO
ALTER TABLE [dbo].[Plays]  WITH CHECK ADD  CONSTRAINT [FK_Musician_Plays] FOREIGN KEY([msin])
REFERENCES [dbo].[Musician] ([msin])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Plays] CHECK CONSTRAINT [FK_Musician_Plays]
GO
/****** Object:  Trigger [dbo].[onMembers]    Script Date: 2021-08-08 4:10:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[onMembers] 
	ON [dbo].[Plays]
		AFTER INSERT, UPDATE, DELETE
			AS
				UPDATE a1
				SET a1.members=a2.ct
				FROM Artist a1
				Inner JOIN
				(
				SELECT count(*) as ct,A.artistName 
					FROM Plays p
						Inner JOIN Artist as A ON A.artistName = p.artistName
					group by A.artistName
				) as a2 on a2.artistname=a1.artistname

			
GO
ALTER TABLE [dbo].[Plays] ENABLE TRIGGER [onMembers]
GO
/****** Object:  Trigger [dbo].[onShare]    Script Date: 2021-08-08 4:10:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE
	TRIGGER [dbo].[onShare]
		ON [dbo].[Plays]
			AFTER INSERT, update, delete
				AS 
				BEGIN 
				declare @total decimal (18,3)


				if(exists(SELECT sum(P.share),p.artistname
					from plays p 
						 Inner JOIN Artist as A on p.artistname = A.artistname
									JOIN Musician as M on M.msin = P.msin
									 
									group by p.artistname
									having  sum(P.share)<>1))
				begin
					Raiserror('Sum of Share is not equal to 1.0',16,10)
				end

				END;
GO
ALTER TABLE [dbo].[Plays] ENABLE TRIGGER [onShare]
GO
