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
/****** Object:  StoredProcedure [dbo].[spMusicianMoreThanOneArtist]    Script Date: 2021-08-08 4:10:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*Return msin, last name and artist names of musicians who play for at least two artists, 
but who do not play for one particular artist – where that
artist is determined by a variable passed to the procedure. 
Result should be sorted by artist name, last name and msin (in ascending order). */


CREATE Procedure [dbo].[spMusicianMoreThanOneArtist]
		@Art varchar(30)
			AS
				BEGIN
				Select M.msin, M.lastname, A.artistname
				FROM Artist as A
							JOIN Plays as P on A.artistname = P.artistname
								JOIN Musician as M on M.msin = P.msin
									WHERE A.artistname <> @Art and M.msin in
				(SELECT M.msin
					FROM Artist as A
							JOIN Plays as P on A.artistname = P.artistname
								JOIN Musician as M on M.msin = P.msin
									GROUP by M.msin having count(distinct A.artistname) >1 and M.msin NOT in		
									
												(SELECT M.msin
													FROM Artist as A
														JOIN Plays as P on A.artistname = P.artistname
															JOIN Musician as M on M.msin = P.msin
																WHERE A.artistname =  @Art ))
				Order by A.artistname, M.lastname, M.msin
																END
GO
