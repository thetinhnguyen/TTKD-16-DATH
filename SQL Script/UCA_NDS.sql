USE MASTER
GO
IF DB_ID ('UCA_NDS') IS NOT NULL DROP DATABASE [UCA_NDS]
GO
CREATE DATABASE [UCA_NDS]
GO
USE [UCA_NDS]
/****** Object:  Table [dbo].[Accidents_NDS]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- select Accident_Index, Time, RIGHT('00' + CAST(DATEPART(HOUR, Time) AS VARCHAR),2) from Accidents_NDS
CREATE TABLE [dbo].[Accidents_NDS](
	[Accident_Index] [int] IDENTITY(1,1) NOT NULL,
    [Accident_NK] varchar(50),
    [Accident_Severity] int,
    [Number_of_Vehicles] int,
    [Number_of_Casualties] int,
    [Date] datetime,
    [Day_of_Week] int,
    [Time] datetime,
    [Local_Authority_District] int,	--[Local_Authority_Id]
	[Local_Authority_Highway] varchar(50),
    [Road_Type] int,
    [Speed_limit] int,
    [Road_Surface_Conditions] int,
    [Special_Conditions_at_Site] int,
    [Carriageway_Hazards] int,
    [Urban_or_Rural_Area] int, -- 1: Urban, 2: Rural, 3:Un..
    [LSOA_of_Accident_Location] varchar(50),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Accident_Index] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[Vehicles_NDS]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Vehicles_NDS] (
	[Vehicles_Id] [int] IDENTITY(1,1) NOT NULL,
    [Accident_Index] int,
	[Vehicle_Reference] int,
    [Vehicle_Type] int,
    [Journey_Purpose_of_Driver] int,
    [Age_of_Driver] int,
    [Age_of_Vehicle] int,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Vehicles_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Casualties_NDS]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Casualties_NDS] (
	[Casualties_Id] [int] IDENTITY(1,1) NOT NULL,
    [Accident_Index] int,
	[Vehicle_Reference] int,
    [Sex_of_Casualty] int,
    [Age_of_Casualty] int,
	[Age_Band_of_Casualty] int,
    [Casualty_Severity] int,
    [Casualty_Type] int,
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Casualties_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Local_Authority_District_NDS]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO  

CREATE TABLE [dbo].[Local_Authority_District_NDS](
	[Local_Authority_District_Id] [int] IDENTITY(1,1) NOT NULL,
    [Local_Authority_District_NK] int,
	[Local_Authority_District_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Local_Authority_District_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Age_Band_of_Casualty_NDS]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [Age_Band_of_Casualty_NDS] (
	[Age_Band_of_Casualty_Id] [int] IDENTITY(1,1) NOT NULL,
    [Age_Band_of_Casualty_NK] int,
    [Age_Band_of_Casualty_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Age_Band_of_Casualty_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Accident_location_NDS]    Script Date: 10/21/2021 12:19:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Accident_location_NDS] (
	[Accident_location_Id] [int] IDENTITY(1,1) NOT NULL,
	[Accident_Index] int,
	[city] varchar(50),
    [county] varchar(50),
    [country_name] varchar(50),
    [region_name] varchar(50),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Accident_location_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Vehicle_Type_NDS]    Script Date: 2021/12/25 21:59:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle_Type_NDS](
	[Vehicle_Type_ID] [int] IDENTITY(1,1) NOT NULL,
	[Vehicle_Type_NK] [int] NULL,
	[Vehicle_Type_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Vehicle_Type_NDS] PRIMARY KEY CLUSTERED 
(
	[Vehicle_Type_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


/****** Object:  Table [dbo].[Road_Type_NDS]    Script Date: 2021/12/25 21:59:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Road_Type_NDS](
	[Road_Type_ID] [int] IDENTITY(1,1) NOT NULL,
	[Road_Type_NK] [int] NULL,
	[Road_Type_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Road_Type_NDS] PRIMARY KEY CLUSTERED 
(
	[Road_Type_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Casualty_Type_NDS]    Script Date: 2021/12/25 21:59:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Casualty_Type_NDS](
	[Casualty_Type_ID] [int] IDENTITY(1,1) NOT NULL,
	[Casualty_Type_NK] [int] NULL,
	[Casualty_Type_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Casualty_Type_NDS] PRIMARY KEY CLUSTERED 
(
	[Casualty_Type_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO 

/****** Object:  Table [dbo].[Journey_Purpose_NDS]    Script Date: 2021/12/25 21:59:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Journey_Purpose_NDS](
	[Journey_Purpose_ID] [int] IDENTITY(1,1) NOT NULL,
	[Journey_Purpose_NK] [int] NULL,
	[Journey_Purpose_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Journey_Purpose_NDS] PRIMARY KEY CLUSTERED 
(
	[Journey_Purpose_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Severity_NDS]    Script Date: 2021/12/25 21:59:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Severity_NDS](
	[Severity_ID] [int] IDENTITY(1,1) NOT NULL,
	[Severity_NK] [int] NULL,
	[Severity_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Severity_NDS] PRIMARY KEY CLUSTERED 
(
	[Severity_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Sex_of_Person_NDS]    Script Date: 2021/12/25 21:59:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sex_of_Person_NDS](
	[Sex_of_Person_ID] [int] IDENTITY(1,1) NOT NULL,
	[Sex_of_Person_NK] [int] NULL,
	[Sex_of_Person_Name] nvarchar(255),
	[CreatedDate] [datetime] NULL,
	[UpdatedDate] [datetime] NULL,
 CONSTRAINT [PK_Sex_of_Person_NDS] PRIMARY KEY CLUSTERED 
(
	[Sex_of_Person_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Accidents_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Accident_Local] FOREIGN KEY([Local_Authority_District])
REFERENCES [dbo].[Local_Authority_District_NDS] ([Local_Authority_District_Id])
GO

ALTER TABLE [dbo].[Accidents_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Accidents_NDS_Road_Type] FOREIGN KEY([Road_Type])
REFERENCES [dbo].[Road_Type_NDS] ([Road_Type_ID])
GO
ALTER TABLE [dbo].[Accidents_NDS] CHECK CONSTRAINT [FK_Accidents_NDS_Road_Type]
GO

ALTER TABLE [dbo].[Accidents_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Accidents_NDS_Accident_Severity] FOREIGN KEY([Accident_Severity])
REFERENCES [dbo].[Severity_NDS] ([Severity_ID])
GO
ALTER TABLE [dbo].[Accidents_NDS] CHECK CONSTRAINT [FK_Accidents_NDS_Accident_Severity]
GO

ALTER TABLE [dbo].[Accident_location_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Accident_Location_Accident] FOREIGN KEY([Accident_Index])
REFERENCES [dbo].[Accidents_NDS] ([Accident_Index])
GO

ALTER TABLE [dbo].[Vehicles_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Vehicles_Accident] FOREIGN KEY([Accident_Index])
REFERENCES [dbo].[Accidents_NDS] ([Accident_Index])
GO

ALTER TABLE [dbo].[Vehicles_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Vehicles_NDS_Journey_Purpose] FOREIGN KEY([Journey_Purpose_of_Driver])
REFERENCES [dbo].[Journey_Purpose_NDS] ([Journey_Purpose_ID])
GO
ALTER TABLE [dbo].[Vehicles_NDS] CHECK CONSTRAINT [FK_Vehicles_NDS_Journey_Purpose]
GO

ALTER TABLE [dbo].[Vehicles_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Vehicles_NDS_Vehicle_Type] FOREIGN KEY([Vehicle_Type])
REFERENCES [dbo].[Vehicle_Type_NDS] ([Vehicle_Type_ID])
GO
ALTER TABLE [dbo].[Vehicles_NDS] CHECK CONSTRAINT [FK_Vehicles_NDS_Vehicle_Type]
GO

ALTER TABLE [dbo].[Casualties_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Casualties_NDS_Casualty_Severity] FOREIGN KEY([Casualty_Severity])
REFERENCES [dbo].[Severity_NDS] ([Severity_ID])
GO
ALTER TABLE [dbo].[Casualties_NDS] CHECK CONSTRAINT [FK_Casualties_NDS_Casualty_Severity]
GO

ALTER TABLE [dbo].[Casualties_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Casualties_NDS_Casualty_Type] FOREIGN KEY([Casualty_Type])
REFERENCES [dbo].[Casualty_Type_NDS] ([Casualty_Type_ID])
GO
ALTER TABLE [dbo].[Casualties_NDS] CHECK CONSTRAINT [FK_Casualties_NDS_Casualty_Type]
GO

ALTER TABLE [dbo].[Casualties_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Casualties_NDS_Sex_of_Casualty] FOREIGN KEY([Sex_of_Casualty])
REFERENCES [dbo].[Sex_of_Person_NDS] ([Sex_of_Person_ID])
GO
ALTER TABLE [dbo].[Casualties_NDS] CHECK CONSTRAINT [FK_Casualties_NDS_Sex_of_Casualty]
GO

ALTER TABLE [dbo].[Casualties_NDS]  WITH CHECK ADD  CONSTRAINT [FK_Casualties_Accident] FOREIGN KEY([Accident_Index])
REFERENCES [dbo].[Accidents_NDS] ([Accident_Index])
GO

ALTER TABLE [dbo].[Casualties_NDS]   WITH CHECK ADD  CONSTRAINT [FK_Casualties_Age_Band_of_Casualty] FOREIGN KEY( [Age_Band_of_Casualty])
REFERENCES [dbo].[Age_Band_of_Casualty_NDS] ( [Age_Band_of_Casualty_Id])
GO
