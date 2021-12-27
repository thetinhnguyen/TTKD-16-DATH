--CREATE DATABASE UCA_LSET_CET
--GO
--USE UCA_LSET_CET
--go

--CREATE TABLE LSET_CET
--(
--	ID INT IDENTITY(1,1) PRIMARY KEY,
--	LSET DATETIME,
--	CET DATETIME
--)

--INSERT INTO LSET_CET(LSET) VALUES('2012-12-31')

--SELECT * 
--FROM LSET_CET

USE MASTER
GO
IF DB_ID ('UCA_STAGE') IS NOT NULL DROP DATABASE [UCA_STAGE]
GO
CREATE DATABASE [UCA_STAGE]
GO
USE [UCA_STAGE]


/****** Object:  Table [dbo].[Accidents_Stage]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Accidents_Stage](
    [Accident_Index] varchar(50),
    [Accident_Severity] int,
    [Number_of_Vehicles] int,
    [Number_of_Casualties] int,
    [Date] datetime,
    [Day_of_Week] int,
    [Time] datetime,
    [Local_Authority_(District)] int,
    [Local_Authority_(Highway)] varchar(50),
    [Road_Type] int,
    [Speed_limit] int,
    [Road_Surface_Conditions] int,
    [Special_Conditions_at_Site] int,
    [Carriageway_Hazards] int,
    [Urban_or_Rural_Area] int,
    [LSOA_of_Accident_Location] varchar(50),
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Vehicles_Stage]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Vehicles_Stage] (
    [Accident_Index] varchar(50),
	[Vehicle_Reference] int,
    [Vehicle_Type] int,
    [Journey_Purpose_of_Driver] int,
    [Age_of_Driver] int,
    [Age_of_Vehicle] int
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Casualties_Stage]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Casualties_Stage] (
    [Accident_Index] varchar(50),
	[Vehicle_Reference] int,
    [Sex_of_Casualty] int,
    [Age_of_Casualty] int,
    [Age_Band_of_Casualty] int,
    [Casualty_Severity] int,
    [Casualty_Type] int
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Accident_location_Stage]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Accident_location_Stage] (
	[Accident_Index] varchar(50),
	[city] varchar(50),
    [county] varchar(50),
    [country_name] varchar(50),
    [region_name] varchar(50)
) ON [PRIMARY]
GO