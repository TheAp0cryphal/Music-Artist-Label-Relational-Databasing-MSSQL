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
/****** Object:  UserDefinedFunction [dbo].[ext]    Script Date: 2021-08-08 4:10:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[ext] (@artistName varchar(100))
RETURNS int
AS
BEGIN
	declare @artistYr int;
	set @artistYr=isnull((select year(startdate) from Artist where ltrim(rtrim(lower(artistname)))=ltrim(rtrim(lower(@artistName)))),0)
	RETURN @artistYr
END
GO
