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


--CREATE DATABASE [UCA_STAGE]
-- DROP DATABASE [UCA_STAGE]
USE [UCA_STAGE]
GO

/****** Object:  Table [dbo].[Accidents_Stage]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Accidents_Stage](
    [Accident_Index] varchar(50),
    [Accident_Severity] varchar(50),
    [Number_of_Vehicles] varchar(50),
    [Number_of_Casualties] varchar(50),
    [Date] varchar(50),
    [Day_of_Week] varchar(50),
    [Time] varchar(50),
    [Local_Authority_(District)] varchar(50),
    [Local_Authority_(Highway)] varchar(50),
    [Road_Type] varchar(50),
    [Speed_limit] varchar(50),
    [Road_Surface_Conditions] varchar(50),
    [Special_Conditions_at_Site] varchar(50),
    [Carriageway_Hazards] varchar(50),
    [Urban_or_Rural_Area] varchar(50),
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
    [Vehicle_Type] varchar(50),
    [Journey_Purpose_of_Driver] varchar(50),
    [Age_of_Driver] varchar(50),
    [Age_of_Vehicle] varchar(50)
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Casualties_Stage]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Casualties_Stage] (
    [Accident_Index] varchar(50),
    [Sex_of_Casualty] varchar(50),
    [Age_of_Casualty] varchar(50),
    [Age_Band_of_Casualty] varchar(50),
    [Casualty_Severity] varchar(50),
    [Casualty_Type] varchar(50)
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[LDA_to_dim_Scotland_NIreland_Stage]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LDA_to_dim_Scotland_NIreland_Stage] (
    [Local_Authority_(District)] int,
    [county] varchar(50),
    [country_name] varchar(50),
    [region_name] varchar(50)
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[LSOA_to_dim_Eng_Wales_Stage]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LSOA_to_dim_Eng_Wales_Stage] (
    [lsoa11cd] varchar(50),
    [city] varchar(50),
    [county] varchar(50),
    [country_name] varchar(50),
    [region_name] varchar(50)
) ON [PRIMARY]
GO