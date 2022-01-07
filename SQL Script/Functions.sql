﻿use UCA_NDS
go

-- Ham xac dinh thoi diem trong ngay
create or alter FUNCTION dbo.getSession_in_Day(@Time time)
returns int
as
begin
declare @type int;
	if @Time is Null set @type = -1;
	else
	Begin
		declare @hour int = CAST(DATEPART(HOUR, @Time) AS int);
		if @hour >= 5 and @hour < 12
			set @type = 1;
		else if @hour >= 12 and @hour < 17
			set @type = 2;
		else if @hour >= 17 and @hour < 21
			set @type = 3;
		else set  @type = 4;
end
	return @type;
end

-- Query Du lieu de nap bang Fact Accidents

-- Tinh Variance de  tinh muc do  tang gia, cua TNGT qua cac nam
select table1.Y as 'Year 1', table2.Y as 'Year 2', table1.NumOfAccY1, table2.NumOfAccY2,
	CAST((table2.NumOfAccY2 - table1.NumOfAccY1) as float) / CAST(table1.NumOfAccY1 as float) as 'Variance (%)'
from (select DATEPART(YEAR,Date) as Y, COUNT(*) AS NumOfAccY1
		from Accidents_NDS
		GROUP BY DATEPART(YEAR,Date)) as table1,
	 (select DATEPART(YEAR,Date) as Y, COUNT(*) AS NumOfAccY2 
		from Accidents_NDS
		GROUP BY DATEPART(YEAR,Date)) as table2
where table1.Y < table2.Y
order by table1.Y, table2.Y

-- Tinh Variance de  tinh muc do  tang gia, cua TNGT qua cac nam
select table1.Y as 'Date in Year 1', table2.Y as ' Date in Year 2', table1.NumOfAcc, table2.NumOfAcc,
	CAST((table2.NumOfAcc - table1.NumOfAcc) as float) / CAST(table1.NumOfAcc as float) as 'Variance (%)'
from (select Date as Y, COUNT(*) AS NumOfAcc
		from Accidents_NDS
		GROUP BY Date ) as table1,
	 (select Date as Y, COUNT(*) AS NumOfAcc 
		from Accidents_NDS
		GROUP BY Date ) as table2
where table1.Y < table2.Y
order by table1.Y, table2.Y

-- Thong ke so luong TNGT theo Mức Độ Nghiêm Trọng và Thời Điểm Trong Ngày
SELECT Accident_Severity, Session_in_Day, Date, COUNT(*) AS NumOfAcc_Sev_Sess 
FROM Accidents_NDS
GROUP BY Accident_Severity, Session_in_Day,Date
ORDER BY NumOfAcc_Sev_Sess  DESC

-- Thong ke so luong TNGT theo Mức Độ Nghiêm Trọng, Vùng (Urban_or_Rural_Area), và Kiểu Đường (Road Type)
SELECT Accident_Severity, Urban_or_Rural_Area, Road_Type, Date, COUNT(*) AS NumOfAcc_Sev_Area_RoadType
FROM Accidents_NDS
GROUP BY Accident_Severity, Urban_or_Rural_Area, Road_Type,Date
ORDER BY NumOfAcc_Sev_Area_RoadType  DESC

-- Thong ke so luong TNGT theo Mục Đích Hành Trình (Journey Purpose) và Loại Phương Tiện (Vehicle_Type)
SELECT Journey_Purpose_of_Driver, Vehicle_Type, COUNT(*) AS NumOfAcc_JourP_VehicleType
FROM Vehicles_NDS
GROUP BY Journey_Purpose_of_Driver, Vehicle_Type
ORDER BY NumOfAcc_JourP_VehicleType DESC

-- Thong ke so luong TNGT theo Mức Độ Nghiêm Trọng, Loại Phương Tiện (Vehicle_Type), Built-up Road
SELECT Accident_Severity, Vehicle_Type, Built_up_Road_Type, Date, COUNT(*) AS NumOfAcc_JourP_VehicleType
FROM Vehicles_NDS a join Accidents_NDS b on a.Accident_Index=b.Accident_Index
GROUP BY Accident_Severity, Vehicle_Type, Built_up_Road_Type, Date
ORDER BY NumOfAcc_JourP_VehicleType DESC


-----1.Thống kê số lượng nạn nhân theo Mức Độ Nghiêm Trọng (Fatal, Serious, Slight) ở các Địa phương (Local_Authority_(District)) trong tất cả các năm.
SELECT [Accident_Severity],[Local_Authority_District], Number_of_Casualties , COUNT(*) AS NumOfCas_Severity_Local_AllYear
FROM [Accidents_NDS] a join [Casualties_NDS] b on a.[Accident_Index]=b.[Accident_Index]
GROUP BY [Accident_Severity],[Local_Authority_District]
ORDER BY NumOfCas_Severity_Local_AllYear, Number_of_Casualties DESC

------2.Thống kê số lượng nạn nhân theo Mức Độ Nghiêm Trọng ở các Địa Phương (Local_Authority_(District)) theo các Quý trong từng năm.
SELECT [Accident_Severity],[Local_Authority_District] ,DATEPART(Quarter,Date) as Quarter, COUNT(*) AS NumOfAcc_Severity_Local_Quarter
FROM [Accidents_NDS] a join [Casualties_NDS] b on a.[Accident_Index]=b.[Accident_Index]
GROUP BY [Accident_Severity],[Local_Authority_District] , DATEPART(Quarter,Date)
ORDER BY NumOfAcc_Severity_Local_Quarter DESC

-----6.Thống kê số lượng nạn nhân theo Mức Độ Nghiêm Trọng, Loại Nạn Nhân (Casualty Type) và Độ Tuổi trong các năm, Độ Tuổi được định nghĩa như sau:
SELECT [Accident_Severity],[Casualty_Type],[Age_Group] ,DATEPART(YEAR,Date) as Year, COUNT(*) AS NumOfAcc_Severity_Casualty_Group
FROM [Accidents_NDS] a join [Casualties_NDS] b on a.[Accident_Index]=b.[Accident_Index]
GROUP BY [Accident_Severity],[Casualty_Type],[Age_Group] ,DATEPART(YEAR,Date)
ORDER BY NumOfAcc_Severity_Casualty_Group DESC

----3. Thống kê số lượng người tử vong theo Giới Tính, Loại Nạn Nhân (Casualty Type) và Nhóm Tuổi (Age_Band_of_Casualty) theo các năm.
SELECT [Sex_of_Casualty],[Casualty_Type],[Age_Band_of_Casualty] ,DATEPART(YEAR,Date) as Year, COUNT(*) AS NumOfDead
FROM [Accidents_NDS] a join [Casualties_NDS] b on a.[Accident_Index]=b.[Accident_Index]
where [Accident_Severity]=1
GROUP BY [Sex_of_Casualty],[Casualty_Type],[Age_Band_of_Casualty] ,DATEPART(YEAR,Date)
ORDER BY NumOfDead DESC