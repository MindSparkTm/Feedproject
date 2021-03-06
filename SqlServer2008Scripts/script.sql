USE [master]
GO
/****** Object:  Database [RSS]    Script Date: 26-06-2017 14:08:46 ******/
CREATE DATABASE [RSS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RSS', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\RSS.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'RSS_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\RSS_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [RSS] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RSS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RSS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RSS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RSS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RSS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RSS] SET ARITHABORT OFF 
GO
ALTER DATABASE [RSS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RSS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RSS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RSS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RSS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RSS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RSS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RSS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RSS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RSS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RSS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RSS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RSS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RSS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RSS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RSS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RSS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RSS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [RSS] SET  MULTI_USER 
GO
ALTER DATABASE [RSS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RSS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RSS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RSS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [RSS] SET DELAYED_DURABILITY = DISABLED 
GO
USE [RSS]
GO
/****** Object:  UserDefinedTableType [dbo].[CustomersType]    Script Date: 26-06-2017 14:08:46 ******/
CREATE TYPE [dbo].[CustomersType] AS TABLE(
	[Id] [int] NULL,
	[Name] [varchar](100) NULL,
	[Country] [varchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[FeedContent]    Script Date: 26-06-2017 14:08:46 ******/
CREATE TYPE [dbo].[FeedContent] AS TABLE(
	[title] [varchar](max) NULL,
	[link] [varchar](max) NULL,
	[publicationdate] [varchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[Feedinfo]    Script Date: 26-06-2017 14:08:46 ******/
CREATE TYPE [dbo].[Feedinfo] AS TABLE(
	[title] [varchar](50) NULL,
	[link] [varchar](50) NULL,
	[publicationdate] [varchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[FeedType]    Script Date: 26-06-2017 14:08:46 ******/
CREATE TYPE [dbo].[FeedType] AS TABLE(
	[title] [varchar](50) NULL,
	[link] [varchar](50) NULL,
	[publicationdate] [varchar](50) NULL,
	[itemviewed] [varchar](50) NULL
)
GO
/****** Object:  Table [dbo].[FEED]    Script Date: 26-06-2017 14:08:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FEED](
	[articleid] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](max) NULL,
	[link] [varchar](max) NULL,
	[publicationdate] [date] NULL,
	[itemviewed] [int] NOT NULL CONSTRAINT [DF_FEED_itemviewed]  DEFAULT ((0)),
	[feedpullCount] [int] NULL CONSTRAINT [DF_FEED_feedpullCount]  DEFAULT ((0)),
 CONSTRAINT [PK_FEED] PRIMARY KEY CLUSTERED 
(
	[articleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[checkiffeedalreadyexists]    Script Date: 26-06-2017 14:08:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[checkiffeedalreadyexists]

As
Begin

     SELECT publicationdate FROM FEED WHERE publicationdate = CAST(GETDATE() AS DATE) 
End
GO
/****** Object:  StoredProcedure [dbo].[GetFeeddata]    Script Date: 26-06-2017 14:08:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetFeeddata]
as
begin
    select * from dbo.Feed WHERE publicationdate = CAST(GETDATE() AS DATE)order by itemviewed DESC;
    
end;
GO
/****** Object:  StoredProcedure [dbo].[GetFeeddatabyViewCount]    Script Date: 26-06-2017 14:08:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetFeeddatabyViewCount]
as
begin
    select * from dbo.Feed WHERE publicationdate = CAST(GETDATE() AS DATE) order by itemviewed DESC ;
    
end;

GO
/****** Object:  StoredProcedure [dbo].[Insert_Feed]    Script Date: 26-06-2017 14:08:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Insert_Feed]
	@tblFeed FeedContent READONLY
AS
BEGIN
	SET NOCOUNT ON;
	
	INSERT INTO FEED(title, link,publicationdate)
	SELECT title, link,publicationdate FROM @tblFeed
END


GO
/****** Object:  StoredProcedure [dbo].[Update_FeedCount]    Script Date: 26-06-2017 14:08:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Update_FeedCount]
    @id int
  
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE FEED
    SET itemviewed=itemviewed+1
    WHERE articleid=@id
END
GO
USE [master]
GO
ALTER DATABASE [RSS] SET  READ_WRITE 
GO
