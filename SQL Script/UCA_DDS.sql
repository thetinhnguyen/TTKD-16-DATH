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

--drop TABLE Fact_Accidents
CREATE TABLE Fact_Accidents(
	[Date] DATE FOREIGN KEY REFERENCES dimDate,
	[Session_In_Day] INT FOREIGN KEY REFERENCES dimSessionInDay,
	[Severity_NK] [int] FOREIGN KEY REFERENCES dimSeverity,
	[Built_up_Road_Type_ID] [int] FOREIGN KEY REFERENCES dimBuiltUpRoadType,
	[Urban_Rural_NK] [int] FOREIGN KEY REFERENCES dimUrbanOrRural,
	[Location_NK] [int] FOREIGN KEY REFERENCES dimLocation, 
	[Road_Type_NK] [int] FOREIGN KEY REFERENCES dimRoadType,
	[Vehicle_Type_NK] [int] FOREIGN KEY REFERENCES dimVehicleType, --FK Vehicles_NDS
	[Journey_Purpose_NK] [int] FOREIGN KEY REFERENCES dimJourneyPurpose, --FK Vehicles_NDS
	[NumOfAcc] int,
	PRIMARY KEY ([Date], 
				Session_in_Day, 
				Severity_NK, 
				Built_up_Road_Type_ID,
				Urban_Rural_NK,
				Location_NK,
				Road_Type_NK,
				Journey_Purpose_NK,
				Vehicle_Type_NK)
)

--select * from Fact_Casualities ORDER BY NumOfDead DESC
-- drop TABLE Fact_Casualities
CREATE TABLE Fact_Casualities(
	[Date] DATE FOREIGN KEY REFERENCES dimDate,
	[Severity_NK] [int] FOREIGN KEY REFERENCES dimSeverity,
	[Local_Authority_District_NK] [int] FOREIGN KEY REFERENCES dimLocalAuthorityDistrict,
	[Location_NK] [int] FOREIGN KEY REFERENCES dimLocation,
	[Age] [int] FOREIGN KEY REFERENCES dimAge,
	[Sex_of_Person_NK] [int] FOREIGN KEY REFERENCES dimSexOfPerson,
	[Casualty_Type_NK] [int] FOREIGN KEY REFERENCES dimCasualtyType,
	[NumOfCas]INT,
	PRIMARY KEY ([Date], Local_Authority_District_NK, Location_NK, Severity_NK, Age, Sex_of_Person_NK, Casualty_Type_NK )
)

CREATE TABLE Fact_Variance(
	[Date] DATE FOREIGN KEY REFERENCES dimDate,
	[Location_NK] [int] FOREIGN KEY REFERENCES dimLocation, 
	[Total] int,
	PRIMARY KEY ([Date],[Location_NK])
)