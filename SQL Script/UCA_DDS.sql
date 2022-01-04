USE MASTER
GO
IF DB_ID ('UCA_DDS') IS NOT NULL DROP DATABASE [UCA_DDS]
GO
CREATE DATABASE [UCA_DDS]
GO
USE [UCA_DDS]

CREATE TABLE dimDateTime(
	[DateTime] DATETIME PRIMARY KEY,
	[Hour] AS (DATEPART(HOUR,[DateTime])),
	[SessionOfDay] nvarchar(255),
	[Day] AS (DATEPART(DAY,[DateTime])),
	[DayOfWeek] AS (DATEPART(WEEKDAY,[DateTime])),
	[Month] AS (DATEPART(MONTH,[DateTime])),
	[Quarter] AS (DATEPART(QUARTER,[DateTime])),
	[Year] AS (DATEPART(YEAR,[DateTime])),
	[CreatedDate] DATETIME,
	[UpdatedDate] DATETIME,
)
GO

CREATE TABLE [dimAge] (
	[Age] int PRIMARY KEY,
    [Age_Band] nvarchar(255),
	[Age_Group] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
) GO

--???
CREATE TABLE [dimLocation] (
	[Accident_Index] int PRIMARY KEY,
	[city] varchar(50),
    [county] varchar(50),
    [country_name] varchar(50),
    [region_name] varchar(50),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
)GO

CREATE TABLE [dbo].[dimLocalAuthorityDistrict](
    [Local_Authority_District_NK] int,
	[Local_Authority_District_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
)GO

CREATE TABLE [dbo].[dimSeverity](
	[Severity_NK] [int] PRIMARY KEY,
	[Severity_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
)GO

CREATE TABLE [dbo].[dimSexOfPerson](
	[Sex_of_Person_NK] [int] PRIMARY KEY,
	[Sex_of_Person_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
)GO

CREATE TABLE [dbo].[dimBuiltUpRoadType](
	[Built_up_Road_Type_ID] [int] PRIMARY KEY,
	[Built_up_Road_Type_Name] nvarchar(255)
)GO

CREATE TABLE [dbo].[dimUrbanOrRural](
	[Urban_Rural_NK] [int] PRIMARY KEY,
	[Urban_Rural_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
)GO

CREATE TABLE [dbo].[dimVehicleType](
	[Vehicle_Type_NK] [int] PRIMARY KEY,
	[Vehicle_Type_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
)GO

CREATE TABLE [dbo].[dimRoadType](
	[Road_Type_NK] [int] PRIMARY KEY,
	[Road_Type_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
) GO

CREATE TABLE [dbo].[dimCasualtyType](
	[Casualty_Type_NK] [int] PRIMARY KEY,
	[Casualty_Type_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
)GO 

CREATE TABLE [dbo].[dimJourneyPurpose](
	[Journey_Purpose_NK] [int] PRIMARY KEY,
	[Journey_Purpose_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
) GO

---Fact