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
/****** Object:  StoredProcedure [dbo].[spSongsWithTheInTitle]    Script Date: 2021-08-08 4:10:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[spSongsWithTheInTitle]
	@n int
		AS
			BEGIN

			SELECT S.artistname, M.lastname, Count (Distinct S.title)
					FROM Musician as M
						JOIN Plays as P on P.msin = M.msin
						Join Song as S on S.artistname = P.artistname
						Group by S.artistname, M.lastname having S.artistname in
	
			(((Select Distinct S.Artistname 
				FROM Plays as P
					Join Artist as A on A.artistname = P.artistname
					Join Musician as M on M.msin = P.msin
					Join Song as S on S.artistname = A.artistname
						Where S.title Like '% __ the %')

						Union

			(Select Distinct S.Artistname
				FROM Plays as P
					Join Artist as A on A.artistname = P.artistname
					Join Musician as M on M.msin = P.msin
					Join Song as S on S.artistname = P.artistname
						Where S.title Like '__ the %'))

						Intersect

						
			(Select S.artistname
				FROM Plays as P
					Join Artist as A on A.artistname = P.artistname
					Join Musician as M on M.msin = P.msin
					Join Song as S on S.artistname = P.artistname
						Group by S.artistname having Count(Distinct S.title) >= @n))

			ORDER by count(Distinct S.title) desc, S.artistname, M.lastname asc
			
						END
GO
