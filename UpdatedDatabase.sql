USE [master]
GO
/****** Object:  Database [Sample2]    Script Date: 4/3/2020 12:11:30 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[CalacluateAge]    Script Date: 4/3/2020 12:11:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[CalacluateAge] (@Dob Date)
Returns int
as
begin
DECLARE @Age int
SET @Age = DATEDIFF(YEAR,@Dob,GetDATE()) -
		CASE
			WHEN (MONTH(@Dob) > Month(GETDATE())) OR
			(MONTH (@Dob) = MONTH(GETDATE()) AND DAY(@Dob) > Day(GETDATE()))
			THEN 1 ELSE 0
			END
			Return @Age
END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_MSTVF_GetEmployee]    Script Date: 4/3/2020 12:11:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_MSTVF_GetEmployee](@Gender nvarchar(50))
RETURNS @table TABLE (id int, Name nvarchar(50), Age INT , Gender nvarchar(50))
as 
Begin
	declare @ID int
	select @ID= g.ID from tbl_Gender g where g.Gender = @Gender
	INSERT INTO @table
	Select P.ID, Name, Age ,j.Gender FROM tbl_Person P, tbl_Gender j
	where P.GenderID=@ID AND  j.Gender = @Gender
	Return
END
GO
/****** Object:  Table [dbo].[tbl_EmployeeType]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_EmployeeType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_EmployeeType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Employee]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Employee](
	[ID] [int] NOT NULL,
	[PersonID] [int] NOT NULL,
	[EmployeeTypeID] [int] NOT NULL,
	[Salary] [int] NULL,
	[City] [nvarchar](50) NULL,
	[DOB] [date] NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwEmployeeCount]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[vwEmployeeCount]
as
Select et.ID,et.Type , Count(*) as TotalEmployee from tbl_Employee e
join tbl_EmployeeType et
on et.ID=e.EmployeeTypeID
group by et.ID, et.Type
GO
/****** Object:  Table [dbo].[tbl_Person]    Script Date: 4/3/2020 12:11:31 PM ******/
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
	[City] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_Person_Table] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_EmployeeByGender]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_EmployeeByGender](@Gender INT)
Returns TABLE
AS

RETURN ( 
       

	   select P.ID ,P.Name , P.City , P.GenderID from tbl_Person P
	   where GenderID=@Gender
	   )
	   
GO
/****** Object:  UserDefinedFunction [dbo].[fn_EmpolyeeNamebyID]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fn_EmpolyeeNamebyID](@id int)
ReturnS nvarchar(50)
WITH SCHEMABINDING
as
Begin
 RETURN (select Name  from dbo.tbl_Person where ID= @id)
END
GO
/****** Object:  Table [dbo].[tbl_Gender]    Script Date: 4/3/2020 12:11:31 PM ******/
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
/****** Object:  View [dbo].[vwPersonFemale]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwPersonFemale]
as
Select tbl_Person.ID,Name,Gender,Age from tbl_Person
JOIN tbl_Gender
on tbl_Person.GenderID=tbl_Gender.ID
where tbl_Gender.Gender='Female'
GO
/****** Object:  View [dbo].[vwnonConfidentail]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwnonConfidentail]
as
Select tbl_Person.ID,Name,Gender from tbl_Person
JOIN tbl_Gender
on tbl_Person.GenderID=tbl_Gender.ID
GO
/****** Object:  View [dbo].[vwFemalePerson]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwFemalePerson]
as
Select Gender , Count(g.ID) as Total
FROM tbl_Person
JOIN tbl_Gender g
on tbl_Person.GenderID=g.ID
Group by Gender 
GO
/****** Object:  View [dbo].[vwEmployee]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE View [dbo].[vwEmployee]
as
select e.ID,Name, e.City
from tbl_Employee e
join tbl_Person
on tbl_Person.ID=e.PersonID
GO
/****** Object:  View [dbo].[vwGender]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create VIEW [dbo].[vwGender]
with schemabinding
as
Select ET.Type,
sum(E.Salary) as SalarySum,
COUNT_BIG(*) as Total
From dbo.tbl_EmployeeType ET
JOIN dbo.tbl_Employee E
on E.EmployeeTypeID= ET.ID
Group by ET.Type
GO
/****** Object:  View [dbo].[vwEmployeeType]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwEmployeeType]
with schemabinding
as
Select ET.Type,
sum(ISNULL(E.Salary,0)) as SalarySum,
COUNT_BIG(*) as Total
From dbo.tbl_EmployeeType ET
JOIN dbo.tbl_Employee E
on E.EmployeeTypeID= ET.ID
Group by ET.Type
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [UIX_vwEmployeeType]    Script Date: 4/3/2020 12:11:31 PM ******/
CREATE UNIQUE CLUSTERED INDEX [UIX_vwEmployeeType] ON [dbo].[vwEmployeeType]
(
	[Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwEmployeeAdd]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[vwEmployeeAdd]
AS

Select E.ID,P.Name,ET.Type,E.Salary,E.City,E.DOB
from tbl_Employee E
Join tbl_EmployeeType ET
ON ET.ID=E.EmployeeTypeID
Join tbl_Person P
ON P.ID=E.PersonID
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[ID] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[Salary] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dateandtime]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dateandtime](
	[c_time] [time](7) NULL,
	[c_date] [date] NULL,
	[c_smalldateandtime] [smalldatetime] NULL,
	[c_dateandtime] [datetime] NULL,
	[c_dateandtime2] [datetime2](7) NULL,
	[c_dateandtimeoffset] [datetimeoffset](7) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Em]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Em](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Manager]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Manager](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](10) NULL,
	[ManagerID] [nchar](10) NULL,
 CONSTRAINT [PK_tbl_Manager] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_PakCustomers]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_PakCustomers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
 CONSTRAINT [UQ__PakCustomers_ID] UNIQUE CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_PersonAudit]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_PersonAudit](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AuditData] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_PersonAudit] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_PersonAuditD]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_PersonAuditD](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AuditData] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_PersonAuditD] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_UKCustomers]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_UKCustomers](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TBL_UKCustomers_COMPOSITE]    Script Date: 4/3/2020 12:11:31 PM ******/
CREATE CLUSTERED INDEX [IX_TBL_UKCustomers_COMPOSITE] ON [dbo].[tbl_UKCustomers]
(
	[ID] DESC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
INSERT [dbo].[Customers] ([ID], [Name], [Salary]) VALUES (1, N'hammad', 2000)
INSERT [dbo].[Customers] ([ID], [Name], [Salary]) VALUES (2, N'gia', 2000)
INSERT [dbo].[Customers] ([ID], [Name], [Salary]) VALUES (1, N'hammad', 2000)
INSERT [dbo].[Customers] ([ID], [Name], [Salary]) VALUES (3, N'kim', 1500)
INSERT [dbo].[Customers] ([ID], [Name], [Salary]) VALUES (4, N'pam', 1300)
INSERT [dbo].[dateandtime] ([c_time], [c_date], [c_smalldateandtime], [c_dateandtime], [c_dateandtime2], [c_dateandtimeoffset]) VALUES (CAST(N'22:10:30.8233333' AS Time), CAST(N'2020-03-27' AS Date), CAST(N'2020-03-27T22:11:00' AS SmallDateTime), CAST(N'2020-03-27T22:10:30.823' AS DateTime), CAST(N'2020-03-27T22:10:30.8233333' AS DateTime2), CAST(N'2020-03-27T22:10:30.8233333+05:00' AS DateTimeOffset))
INSERT [dbo].[dateandtime] ([c_time], [c_date], [c_smalldateandtime], [c_dateandtime], [c_dateandtime2], [c_dateandtimeoffset]) VALUES (CAST(N'22:16:34.0933333' AS Time), CAST(N'2020-03-27' AS Date), CAST(N'2020-03-27T22:17:00' AS SmallDateTime), CAST(N'2020-03-27T22:16:34.093' AS DateTime), CAST(N'2020-03-27T22:16:34.0933333' AS DateTime2), CAST(N'2020-03-27T22:16:34.0949621+05:00' AS DateTimeOffset))
SET IDENTITY_INSERT [dbo].[tbl_Em] ON 

INSERT [dbo].[tbl_Em] ([ID], [FirstName], [MiddleName], [LastName]) VALUES (1, N'Mike', NULL, NULL)
INSERT [dbo].[tbl_Em] ([ID], [FirstName], [MiddleName], [LastName]) VALUES (2, N'Hammad', N'james', N'haili')
INSERT [dbo].[tbl_Em] ([ID], [FirstName], [MiddleName], [LastName]) VALUES (3, N'kim', NULL, N'todd')
INSERT [dbo].[tbl_Em] ([ID], [FirstName], [MiddleName], [LastName]) VALUES (4, N'jonney', N'kim', N'don')
INSERT [dbo].[tbl_Em] ([ID], [FirstName], [MiddleName], [LastName]) VALUES (5, N'Mike', NULL, NULL)
SET IDENTITY_INSERT [dbo].[tbl_Em] OFF
INSERT [dbo].[tbl_Employee] ([ID], [PersonID], [EmployeeTypeID], [Salary], [City], [DOB]) VALUES (1, 1, 1, 50000, N'London', CAST(N'2020-03-27' AS Date))
INSERT [dbo].[tbl_Employee] ([ID], [PersonID], [EmployeeTypeID], [Salary], [City], [DOB]) VALUES (3, 3, 1, 50000, N'los vegas', CAST(N'2000-03-27' AS Date))
INSERT [dbo].[tbl_Employee] ([ID], [PersonID], [EmployeeTypeID], [Salary], [City], [DOB]) VALUES (8, 2, 2, 30300, N'abu dahbi', CAST(N'2000-12-03' AS Date))
INSERT [dbo].[tbl_Employee] ([ID], [PersonID], [EmployeeTypeID], [Salary], [City], [DOB]) VALUES (5, 5, 3, 20000, N'New York', CAST(N'2010-07-07' AS Date))
INSERT [dbo].[tbl_Employee] ([ID], [PersonID], [EmployeeTypeID], [Salary], [City], [DOB]) VALUES (6, 6, 3, 15000, N'London', CAST(N'2002-08-17' AS Date))
INSERT [dbo].[tbl_Employee] ([ID], [PersonID], [EmployeeTypeID], [Salary], [City], [DOB]) VALUES (9, 9, 2, 34300, N'abu dahbi', CAST(N'1990-12-08' AS Date))
INSERT [dbo].[tbl_Employee] ([ID], [PersonID], [EmployeeTypeID], [Salary], [City], [DOB]) VALUES (7, 7, 2, 30000, N'bombay', CAST(N'2003-01-04' AS Date))
SET IDENTITY_INSERT [dbo].[tbl_EmployeeType] ON 

INSERT [dbo].[tbl_EmployeeType] ([ID], [Type]) VALUES (1, N'Permanent')
INSERT [dbo].[tbl_EmployeeType] ([ID], [Type]) VALUES (2, N'Temporary')
INSERT [dbo].[tbl_EmployeeType] ([ID], [Type]) VALUES (3, N'Contract')
SET IDENTITY_INSERT [dbo].[tbl_EmployeeType] OFF
INSERT [dbo].[tbl_Gender] ([ID], [Gender]) VALUES (1, N'Male')
INSERT [dbo].[tbl_Gender] ([ID], [Gender]) VALUES (2, N'Female')
INSERT [dbo].[tbl_Gender] ([ID], [Gender]) VALUES (3, N'Unknow')
SET IDENTITY_INSERT [dbo].[tbl_Manager] ON 

INSERT [dbo].[tbl_Manager] ([ID], [Name], [ManagerID]) VALUES (1, N'Mike      ', N'2         ')
INSERT [dbo].[tbl_Manager] ([ID], [Name], [ManagerID]) VALUES (2, N'Tod       ', NULL)
INSERT [dbo].[tbl_Manager] ([ID], [Name], [ManagerID]) VALUES (3, N'sam       ', N'1         ')
INSERT [dbo].[tbl_Manager] ([ID], [Name], [ManagerID]) VALUES (4, N'ben       ', N'1         ')
INSERT [dbo].[tbl_Manager] ([ID], [Name], [ManagerID]) VALUES (5, N'mary      ', N'2         ')
INSERT [dbo].[tbl_Manager] ([ID], [Name], [ManagerID]) VALUES (6, N'abcdefghij', N'1         ')
SET IDENTITY_INSERT [dbo].[tbl_Manager] OFF
SET IDENTITY_INSERT [dbo].[tbl_PakCustomers] ON 

INSERT [dbo].[tbl_PakCustomers] ([ID], [Name], [Email]) VALUES (1, N'hammad', N'h@h.com')
INSERT [dbo].[tbl_PakCustomers] ([ID], [Name], [Email]) VALUES (2, N'gia', N'g@g.com')
SET IDENTITY_INSERT [dbo].[tbl_PakCustomers] OFF
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [City]) VALUES (1, N'marrium', N'm@m.com', 2, 40, N'London')
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [City]) VALUES (2, N'marky', N'mk@m.com', 1, 40, N'New York')
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [City]) VALUES (3, N'Kasshish', N'kim@k.com', 2, 27, N'oslo')
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [City]) VALUES (5, N'Maria', N'Mraa@k.com', 2, 30, N'New Jersey')
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [City]) VALUES (6, N'dash', N'dash@d.com', 1, 20, N'Lahore')
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [City]) VALUES (7, N'jame', N'jam@j.com', 2, 23, N'London')
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [City]) VALUES (8, N'helli', N'jmkx', 1, 34, N'New Jersey')
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [City]) VALUES (9, N'afaan', N'af@aaa.com', 1, 34, N'New York')
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [City]) VALUES (10, N'danny', N'd@ddd.com', 1, 33, N'')
INSERT [dbo].[tbl_Person] ([ID], [Name], [Email], [GenderID], [Age], [City]) VALUES (11, N'marrium', N'ma@m.com', 2, 40, N'London')
SET IDENTITY_INSERT [dbo].[tbl_PersonAudit] ON 

INSERT [dbo].[tbl_PersonAudit] ([ID], [AuditData]) VALUES (1, N'The Person Data having ID 9 is added on Mar 29 2020  1:46PM')
INSERT [dbo].[tbl_PersonAudit] ([ID], [AuditData]) VALUES (2, N'The Person Data having ID 10 is added at Mar 29 2020  1:47PM')
INSERT [dbo].[tbl_PersonAudit] ([ID], [AuditData]) VALUES (3, N'Employee With Id = 3 Changes NAME FROM kim to KasshishAge From 25 to 27')
INSERT [dbo].[tbl_PersonAudit] ([ID], [AuditData]) VALUES (4, N'The Person Data having ID 10 is added at Mar 30 2020 12:21AM')
INSERT [dbo].[tbl_PersonAudit] ([ID], [AuditData]) VALUES (5, N'Employee With Id = 5 Changes  NAME FROM Mraa to Maria')
INSERT [dbo].[tbl_PersonAudit] ([ID], [AuditData]) VALUES (6, N'Employee With Id = 7 Changes ')
INSERT [dbo].[tbl_PersonAudit] ([ID], [AuditData]) VALUES (7, N'Employee With Id = 9 Changes ')
INSERT [dbo].[tbl_PersonAudit] ([ID], [AuditData]) VALUES (8, N'Employee With Id = 3 Changes ')
INSERT [dbo].[tbl_PersonAudit] ([ID], [AuditData]) VALUES (9, N'Employee With Id = 8 Changes ')
INSERT [dbo].[tbl_PersonAudit] ([ID], [AuditData]) VALUES (10, N'Employee With Id = 10 Changes ')
INSERT [dbo].[tbl_PersonAudit] ([ID], [AuditData]) VALUES (11, N'Employee With Id = 10 Changes ')
INSERT [dbo].[tbl_PersonAudit] ([ID], [AuditData]) VALUES (12, N'The Person Data having ID 11 is added at Apr  2 2020  7:57PM')
SET IDENTITY_INSERT [dbo].[tbl_PersonAudit] OFF
SET IDENTITY_INSERT [dbo].[tbl_PersonAuditD] ON 

INSERT [dbo].[tbl_PersonAuditD] ([ID], [AuditData]) VALUES (1, N'The Person Data having ID 10 is DELETED at Mar 29 2020  1:52PM')
SET IDENTITY_INSERT [dbo].[tbl_PersonAuditD] OFF
SET IDENTITY_INSERT [dbo].[tbl_UKCustomers] ON 

INSERT [dbo].[tbl_UKCustomers] ([ID], [Name], [Email]) VALUES (3, N'james', N'j@j.com')
INSERT [dbo].[tbl_UKCustomers] ([ID], [Name], [Email]) VALUES (1, N'james', N'j@j.com')
INSERT [dbo].[tbl_UKCustomers] ([ID], [Name], [Email]) VALUES (4, N'gia', N'g@g.com')
INSERT [dbo].[tbl_UKCustomers] ([ID], [Name], [Email]) VALUES (2, N'gia', N'g@g.com')
SET IDENTITY_INSERT [dbo].[tbl_UKCustomers] OFF
/****** Object:  Index [IX_tbl_Person_Salary]    Script Date: 4/3/2020 12:11:31 PM ******/
CREATE NONCLUSTERED INDEX [IX_tbl_Person_Salary] ON [dbo].[tbl_Employee]
(
	[Salary] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [tbl_Employee_UK_PersonID]    Script Date: 4/3/2020 12:11:31 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [tbl_Employee_UK_PersonID] ON [dbo].[tbl_Employee]
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UIX_tbl_PakCustomersEmail]    Script Date: 4/3/2020 12:11:31 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UIX_tbl_PakCustomersEmail] ON [dbo].[tbl_PakCustomers]
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_tbl_Person_Email]    Script Date: 4/3/2020 12:11:31 PM ******/
ALTER TABLE [dbo].[tbl_Person] ADD  CONSTRAINT [UQ_tbl_Person_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_TBL_UKCustomers_EMAIL]    Script Date: 4/3/2020 12:11:31 PM ******/
CREATE NONCLUSTERED INDEX [IX_TBL_UKCustomers_EMAIL] ON [dbo].[tbl_UKCustomers]
(
	[Email] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [bl_Employee_FK_EmployeeType] FOREIGN KEY([EmployeeTypeID])
REFERENCES [dbo].[tbl_EmployeeType] ([ID])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [bl_Employee_FK_EmployeeType]
GO
ALTER TABLE [dbo].[tbl_Employee]  WITH CHECK ADD  CONSTRAINT [tbl_Employee_FK_Person] FOREIGN KEY([PersonID])
REFERENCES [dbo].[tbl_Person] ([ID])
GO
ALTER TABLE [dbo].[tbl_Employee] CHECK CONSTRAINT [tbl_Employee_FK_Person]
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
/****** Object:  StoredProcedure [dbo].[sp_PersonGet]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_PersonGet]
@ID int,
@check nvarchar(50) out
as
Begin

	if(@ID is NUll)
	Begin
		Raiserror('Id can not be null',16,1)
	End
	Else
	Begin
		
		select @check = Name from 
		tbl_Person where ID=@ID
		if(@check is NULL)
		Begin
		Raiserror('Id not Found',16,1)
		End
	End

END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployee]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spGetEmployee]
@City nvarchar(50)
AS
BEGIN 
SELECT p.Name,e.City from tbl_Employee e
Join tbl_Person p 
ON p.ID = e.PersonID
AND e.City = @City
END
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeCountbyGender]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[spGetEmployeeCountbyGender]
@Genders nvarchar(50),
@Count int output
as
begin
 DECLARE  @ID  int
    exec spGetGenderID @Genders ,@ID output
  select COUNT(*) from tbl_Person p
  where p.GenderID = @ID
end
GO
/****** Object:  StoredProcedure [dbo].[spGetEmployeeCountbyGenderID]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spGetEmployeeCountbyGenderID]
@ID int,
@total int output
as 
begin
 select @total = COUNT(*) FRom tbl_Person p
 where p.GenderID=@ID
 end
GO
/****** Object:  StoredProcedure [dbo].[spGetGenderID]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[spGetGenderID]
@Gender nvarchar(50),
@Id int OUTPUT
as
Begin
Select @Id = ID from tbl_Gender
where tbl_Gender.Gender=@Gender
End
GO
/****** Object:  StoredProcedure [dbo].[spGetNamebyID]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spGetNamebyID]
@Id int,
@Name nvarchar(50) output
as
begin
 select @Name=Name from tbl_Person
 where ID= @Id
end
GO
/****** Object:  StoredProcedure [dbo].[spgetNamebyID1]    Script Date: 4/3/2020 12:11:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc  [dbo].[spgetNamebyID1]
@Id int
as Begin
 return (select Name from tbl_Person
 where ID= @Id)
end
GO
