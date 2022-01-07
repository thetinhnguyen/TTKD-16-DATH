IF DB_ID ('UCA_DDS') IS NOT NULL DROP DATABASE [UCA_DDS]
GO
CREATE DATABASE [UCA_DDS]
GO
USE [UCA_DDS]
GO

--select * from dimAge where age=-1
CREATE TABLE dimDate(
	[Date] DATE PRIMARY KEY,
	[Day] int,
	[DayOfWeek] int,
	[Month] int,
	[Quarter] int,
	[Year] int
)

CREATE TABLE dimSessionInDay(
	[Session_in_Day_ID] int PRIMARY KEY,
	[Session_in_Day] nvarchar(255),
)

CREATE TABLE [dimLocation] (
	[Location_NK]  int PRIMARY KEY,
	[city] varchar(50),
    [county] varchar(50),
    [country_name] varchar(50),
    [region_name] varchar(50)
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
	[Built_up_Road_Type_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
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
	[Age_Group] nvarchar(255)
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

GO

---Fact
CREATE TABLE Fact_Accidents(
	[Fact_Accidents_ID] int IDENTITY(1, 1) NOT NULL,
	[Date] DATE FOREIGN KEY REFERENCES dimDate,
	[Session_In_Day] INT FOREIGN KEY REFERENCES dimSessionInDay,
	[Severity_NK] [int] FOREIGN KEY REFERENCES dimSeverity,
	[Local_Authority_District_NK] [int] FOREIGN KEY REFERENCES dimLocalAuthorityDistrict,
	[Built_up_Road_Type_ID] [int] FOREIGN KEY REFERENCES dimBuiltUpRoadType,
	[Urban_Rural_NK] [int] FOREIGN KEY REFERENCES dimUrbanOrRural,
	[Vehicle_Type_NK] [int] FOREIGN KEY REFERENCES dimVehicleType, --FK Vehicles_NDS
	[Road_Type_NK] [int] FOREIGN KEY REFERENCES dimRoadType,
	[Journey_Purpose_NK] [int] FOREIGN KEY REFERENCES dimJourneyPurpose, --FK Vehicles_NDS
	[Location_NK] [int] FOREIGN KEY REFERENCES dimLocation, 
	NumOfAcc_Sev_Sess INT, --So luong TNGT cho cau 4
	NumOfAcc_Sev_Area_RoadType INT, --So luong TNGT cho cau 5
	NumOfAcc_JourP_VehicleType INT, --Tong so luong TNGT cho cau 7
	NumOfAcc_JourP_VehicleType_BUR INT, --Tong so luong TNGT cho cau 9
	PRIMARY KEY (Fact_Accidents_ID)
)


CREATE TABLE Fact_Casualities(
	[Fact_Casualities_ID] int IDENTITY(1, 1) NOT NULL,
	[Date] DATE FOREIGN KEY REFERENCES dimDate,
	[Severity_NK] [int] FOREIGN KEY REFERENCES dimSeverity,
	[Local_Authority_District_NK] [int] FOREIGN KEY REFERENCES dimLocalAuthorityDistrict,
	[Age] [int] FOREIGN KEY REFERENCES dimAge,
	[Sex_of_Person_NK] [int] FOREIGN KEY REFERENCES dimSexOfPerson,
	[Casualty_Type_NK] [int] FOREIGN KEY REFERENCES dimCasualtyType,
	[Location_NK] [int] FOREIGN KEY REFERENCES dimLocation, 
	[NumOfAcc_Severity_Local_Year] INT, --So luong nan nhan cho cau 1,2,6
	[NumOfAcc_Severity_Local_Quarter] int,
	[NumOfAcc_Severity_Casualty_Group] int,
	NumOfDead INT, --Tong so luong nguoi tu vong cho cau 3
	Update_timestamp DATETIME,
	PRIMARY KEY (Fact_Casualities_ID)
)

CREATE  TABLE [dbo].[Fact_Variance](
	[Fact_Variance_ID]  int IDENTITY(1, 1) NOT NULL,
	[Year_1]  Int,
	[Year_2] Int,
	[Count_in_Year1] [int] NULL,
	[Count_in_Year2] [int] NULL,
	[Variance] float NULL,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
	PRIMARY KEY (Fact_Variance_ID)
)