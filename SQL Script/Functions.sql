use UCA_NDS
go

-- Ham xac dinh thoi diem trong ngay
create or alter FUNCTION dbo.getSession_in_Day(@Time time)
returns nvarchar(255)
as
begin
	declare @hour int = CAST(DATEPART(HOUR, @Time) AS int);
	declare @type nvarchar(255) = 'Night';
	if @hour >= 5 and @hour < 12
		set @type = 'Morning';
	else if @hour >= 12 and @hour < 17
		set @type = 'Afternoon';
	else if @hour >= 17 and @hour < 21
		set @type = 'Evening';

	return @type;
end

-- TAO FUNCTION GOP NGAY-THANG-NAM DE TAO KHOA
--CREATE FUNCTION f_Hour_Day_Month_Year
--(@day TINYINT,@month TINYINT,@year INTEGER)
--RETURNS Date
--AS
--BEGIN

--RETURN DATEADD(day, @day -1, DateAdd(month, @month -1, DateAdd(Year, @year-1900, 0)))
--END

-- Thong ke so luong TNGT theo Mức Độ Nghiêm Trọng và Thời Điểm Trong Ngày trong các năm

SELECT Accident_Severity, Session_in_Day,DATEPART(YEAR,Date) as Year, COUNT(*) AS NumOfAcc_Sev_Sess 
FROM Accidents_NDS
GROUP BY Accident_Severity, Session_in_Day,DATEPART(YEAR,Date)
ORDER BY NumOfAcc_Sev_Sess  DESC

-- Thong ke so luong TNGT theo Mức Độ Nghiêm Trọng, Vùng (Urban_or_Rural_Area), và Kiểu Đường (Road Type) trong các năm
SELECT Accident_Severity, Urban_or_Rural_Area, Road_Type, DATEPART(YEAR,Date) as Year, COUNT(*) AS NumOfAcc_Sev_Area_RoadType
FROM Accidents_NDS
GROUP BY Accident_Severity, Urban_or_Rural_Area, Road_Type,DATEPART(YEAR,Date)
ORDER BY NumOfAcc_Sev_Area_RoadType  DESC

-- Thong ke so luong TNGT theo Mục Đích Hành Trình (Journey Purpose) và Loại Phương Tiện (Vehicle_Type) trong các năm
SELECT Journey_Purpose_of_Driver, Vehicle_Type, COUNT(*) AS NumOfAcc_JourP_VehicleType
FROM Vehicles_NDS
GROUP BY Journey_Purpose_of_Driver, Vehicle_Type
ORDER BY NumOfAcc_JourP_VehicleType DESC

-- Thong ke so luong TNGT theo Mức Độ Nghiêm Trọng, Loại Phương Tiện (Vehicle_Type), Built-up Road trong các năm
SELECT Accident_Severity, Vehicle_Type, Built_up_Road_Type,  DATEPART(YEAR,Date) as Year, COUNT(*) AS NumOfAcc_JourP_VehicleType
FROM Vehicles_NDS a join Accidents_NDS b on a.Accident_Index=b.Accident_Index
GROUP BY Accident_Severity, Vehicle_Type, Built_up_Road_Type,  DATEPART(YEAR,Date)
ORDER BY NumOfAcc_JourP_VehicleType DESC

