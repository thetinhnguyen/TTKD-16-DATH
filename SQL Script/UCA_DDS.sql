IF DB_ID ('UCA_DDS') IS NOT NULL DROP DATABASE [UCA_DDS]
GO
CREATE DATABASE [UCA_DDS]
GO
USE [UCA_DDS]
GO

CREATE TABLE dimDate(
	[DateTime] DATE PRIMARY KEY,
	[Day] AS (DATEPART(DAY,[DateTime])),
	[DayOfWeek] AS (DATEPART(WEEKDAY,[DateTime])),
	[Month] AS (DATEPART(MONTH,[DateTime])),
	[Quarter] AS (DATEPART(QUARTER,[DateTime])),
	[Year] AS (DATEPART(YEAR,[DateTime])),
	[CreatedDate] DATETIME,
	[UpdatedDate] DATETIME,
)

CREATE TABLE dimTime(
	[Time] Time PRIMARY KEY,
	[Hour] AS CAST(DATEPART(HOUR, [Time]) AS int),
	[SessionOfDay] nvarchar(255),
)

CREATE TABLE [dimLocation] (
	[Location_NK]  int PRIMARY KEY,
	[city] varchar(50),
    [county] varchar(50),
    [country_name] varchar(50),
    [region_name] varchar(50),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
)


CREATE TABLE [dbo].[dimSeverity](
	[Severity_NK] [int] PRIMARY KEY,
	[Severity_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
)

CREATE TABLE [dbo].[dimLocalAuthorityDistrict](
    [Local_Authority_District_NK] int PRIMARY KEY,
	[Local_Authority_District_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
)

-- Dim cho Fact_Accidents
CREATE TABLE [dbo].[dimBuiltUpRoadType](
	[Built_up_Road_Type_ID] [int] PRIMARY KEY,
	[Built_up_Road_Type_Name] nvarchar(255)
)

CREATE TABLE [dbo].[dimUrbanOrRural](
	[Urban_Rural_NK] [int] PRIMARY KEY,
	[Urban_Rural_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
)

CREATE TABLE [dbo].[dimVehicleType](
	[Vehicle_Type_NK] [int] PRIMARY KEY,
	[Vehicle_Type_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
)

CREATE TABLE [dbo].[dimRoadType](
	[Road_Type_NK] [int] PRIMARY KEY,
	[Road_Type_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
) 

CREATE TABLE [dbo].[dimJourneyPurpose](
	[Journey_Purpose_NK] [int] PRIMARY KEY,
	[Journey_Purpose_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
) 

--Dim cho Fact_Casualities
CREATE TABLE [dimAge] (
	[Age] [int] PRIMARY KEY,
    [Age_Band] nvarchar(255),
	[Age_Group] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
) 

CREATE TABLE [dbo].[dimSexOfPerson](
	[Sex_of_Person_NK] [int] PRIMARY KEY,
	[Sex_of_Person_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
)

CREATE TABLE [dbo].[dimCasualtyType](
	[Casualty_Type_NK] [int] PRIMARY KEY,
	[Casualty_Type_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
) 



---Fact
CREATE TABLE Fact_Accidents(
	[Fact_Accidents_ID] int IDENTITY(1, 1) NOT NULL,
	[Date] DATE FOREIGN KEY REFERENCES dimDate,
	[Time] TIME FOREIGN KEY REFERENCES dimTime,
	[Severity_NK] [int] FOREIGN KEY REFERENCES dimSeverity,
	[Local_Authority_District_NK] [int] FOREIGN KEY REFERENCES dimLocalAuthorityDistrict,
	[Built_up_Road_Type_ID] [int] FOREIGN KEY REFERENCES dimBuiltUpRoadType,
	[Urban_Rural_NK] [int] FOREIGN KEY REFERENCES dimUrbanOrRural,
	[Vehicle_Type_NK] [int] FOREIGN KEY REFERENCES dimVehicleType,
	[Road_Type_NK] [int] FOREIGN KEY REFERENCES dimRoadType,
	[Journey_Purpose_NK] [int] FOREIGN KEY REFERENCES dimJourneyPurpose,
	[Location_NK] [int] FOREIGN KEY REFERENCES dimLocation, 
	NumOfAccidents INT, --So luong TNGT cho cau 4,5,9
	TotalAccidents INT, --Tong so luong TNGT cho cau 7
	Variance FLOAT, -- Do tang giam TNGT
	Created_timestamp DATETIME,
	Update_timestamp DATETIME,
	PRIMARY KEY (Fact_Accidents_ID)
)


CREATE TABLE Fact_Casualities(
	[Fact_Casualities_ID] int IDENTITY(1, 1) NOT NULL,
	[Date] DATE FOREIGN KEY REFERENCES dimDate,
	[Time] TIME FOREIGN KEY REFERENCES dimTime,
	[Severity_NK] [int] FOREIGN KEY REFERENCES dimSeverity,
	[Local_Authority_District_NK] [int] FOREIGN KEY REFERENCES dimLocalAuthorityDistrict,
	[Age] [int] FOREIGN KEY REFERENCES dimAge,
	[Sex_of_Person_NK] [int] FOREIGN KEY REFERENCES dimSexOfPerson,
	[Casualty_Type_NK] [int] FOREIGN KEY REFERENCES dimCasualtyType,
	[Location_NK] [int] FOREIGN KEY REFERENCES dimLocation, 
	NumOfCasualities INT, --So luong nan nhan cho cau 1,2,6
	NumOfDead INT, --Tong so luong nguoi tu vong cho cau 3
	Created_timestamp DATETIME,
	Update_timestamp DATETIME,
	PRIMARY KEY (Fact_Casualities_ID)
)
