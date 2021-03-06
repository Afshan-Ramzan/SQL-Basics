USE [master]
GO
/****** Object:  Database [Sample2]    Script Date: 3/24/2020 1:46:32 PM ******/
CREATE DATABASE [Sample2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Sample1', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Sample1.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Sample1_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\Sample1_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Sample2] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Sample2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Sample2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Sample2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Sample2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Sample2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Sample2] SET ARITHABORT OFF 
GO
ALTER DATABASE [Sample2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Sample2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Sample2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Sample2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Sample2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Sample2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Sample2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Sample2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Sample2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Sample2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Sample2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Sample2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Sample2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Sample2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Sample2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Sample2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Sample2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Sample2] SET RECOVERY FULL 
GO
ALTER DATABASE [Sample2] SET  MULTI_USER 
GO
ALTER DATABASE [Sample2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Sample2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Sample2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Sample2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Sample2] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Sample2', N'ON'
GO
ALTER DATABASE [Sample2] SET QUERY_STORE = OFF
GO
USE [Sample2]
GO
/****** Object:  Table [dbo].[tbl_EmployeeType]    Script Date: 3/24/2020 1:46:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_EmployeeType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Gender]    Script Date: 3/24/2020 1:46:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Gender](
	[ID] [int] NOT NULL,
	[Gender] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Person]    Script Date: 3/24/2020 1:46:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Person](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[GenderID] [int] NULL,
	[Age] [int] NULL,
	[EmployeeID] [int] NULL,
	[City] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_Person_Table] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_EmployeeType] ON 

INSERT [dbo].[tbl_EmployeeType] ([ID], [Type]) VALUES (1, N'Permanent')
INSERT [dbo].[tbl_EmployeeType] ([ID], [Type]) VALUES (2, N'Temporary')
INSERT [dbo].[tbl_EmployeeType] ([ID], [Type]) VALUES (3, N'Contract')
SET IDENTITY_INSERT [dbo].[tbl_EmployeeType] OFF
INSERT [dbo].[tbl_Gender] ([ID], [Gender]) VALUES (1, N'Male')
INSERT [dbo].[tbl_Gender] ([ID], [Gender]) VALUES (2, N'Female')
INSERT [dbo].[tbl_Gender] ([ID], [Gender]) VALUES (3, N'Unknow')
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [EmployeeID], [City]) VALUES (1, N'mary', N'm@m.com', 2, 40, 1, N'London')
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [EmployeeID], [City]) VALUES (2, N'mark', N'mk@m.com', 1, 40, 2, N'New York')
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [EmployeeID], [City]) VALUES (3, N'kim', N'kim@k.com', NULL, 25, 3, N'Kabul')
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [EmployeeID], [City]) VALUES (5, N'Mraa', N'Mraa@k.com', NULL, 30, 2, N'New Jersey')
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [EmployeeID], [City]) VALUES (6, N'dash', N'dash@d.com', 1, 20, 1, N'Lahore')
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_tbl_Person_Email]    Script Date: 3/24/2020 1:46:33 PM ******/
ALTER TABLE [dbo].[tbl_Person] ADD  CONSTRAINT [UQ_tbl_Person_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_Person] ADD  CONSTRAINT [DF_tbl_Person_GenderID]  DEFAULT ((3)) FOR [GenderID]
GO
ALTER TABLE [dbo].[tbl_Person]  WITH NOCHECK ADD  CONSTRAINT [FK_tbl_Person_tbl_Person1] FOREIGN KEY([ID])
REFERENCES [dbo].[tbl_Person] ([ID])
GO
ALTER TABLE [dbo].[tbl_Person] CHECK CONSTRAINT [FK_tbl_Person_tbl_Person1]
GO
ALTER TABLE [dbo].[tbl_Person]  WITH CHECK ADD  CONSTRAINT [tbl_Person_FK_GenderId] FOREIGN KEY([GenderID])
REFERENCES [dbo].[tbl_Gender] ([ID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_Person] CHECK CONSTRAINT [tbl_Person_FK_GenderId]
GO
ALTER TABLE [dbo].[tbl_Person]  WITH CHECK ADD  CONSTRAINT [CK_tbl_Person_Age] CHECK  (([Age]>(0) AND [Age]<(150)))
GO
ALTER TABLE [dbo].[tbl_Person] CHECK CONSTRAINT [CK_tbl_Person_Age]
GO
USE [master]
GO
ALTER DATABASE [Sample2] SET  READ_WRITE 
GO
