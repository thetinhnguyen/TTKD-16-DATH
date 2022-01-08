use UCA_NDS
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
SELECT [Date], Session_in_Day, Accident_Severity, Built_up_Road_Type, Urban_or_Rural_Area, Location_NK, Road_Type_NK, Journey_Purpose_NK, Vehicle_Type_NK, COUNT(*) AS NumOfAcc
FROM ((((Accidents_NDS a  left join Vehicles_NDS v on v.Accident_Index=a.Accident_Index)
join Location_NDS lo on a.Location_ID = lo.Location_Id) 
join Road_Type_NDS rt on a.Road_Type = rt.Road_Type_ID)
join Vehicle_Type_NDS vt on v.Vehicle_Type = vt.Vehicle_Type_ID) 
join Journey_Purpose_NDS jp on v.Journey_Purpose_of_Driver = jp.Journey_Purpose_ID
GROUP BY [Date], Session_in_Day, Accident_Severity, Built_up_Road_Type, Urban_or_Rural_Area, Location_NK, rt.Road_Type_NK, Journey_Purpose_NK, Vehicle_Type_NK
ORDER BY  NumOfAcc DESC

-- Query Du lieu de nap bang Fact Casualties
SELECT [Date], l_a.Local_Authority_District_NK, l.Location_NK, Casualty_Severity, Age_of_Casualty, s_p.Sex_of_Person_NK, c_t.Casualty_Type_NK , COUNT(*) AS NumOfCas
FROM ((((Casualties_NDS c join Accidents_NDS a on c.Accident_Index=a.Accident_Index)
join [Local_Authority_District_NDS] l_a on a.Local_Authority_District=l_a.Local_Authority_District_Id) 
join [Location_NDS] l on a.Location_ID=l.Location_Id) 
join [Casualty_Type_NDS] c_t on c.Casualty_Type=c_t.Casualty_Type_ID) 
join [Sex_of_Person_NDS] s_p on c.Sex_of_Casualty=s_p.Sex_of_Person_ID
GROUP BY [Date], l_a.Local_Authority_District_NK, l.Location_NK, Casualty_Severity, Age_of_Casualty, s_p.Sex_of_Person_NK, c_t.Casualty_Type_NK
ORDER BY  NumOfCas DESC

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

select table1.Y as 'Date 1', table2.Y as ' Date 2', table1.NumOfAcc, table2.NumOfAcc
from (select Date as Y, COUNT(*) AS NumOfAcc
		from Accidents_NDS
		GROUP BY Date ) as table1,
	 (select Date as Y, COUNT(*) AS NumOfAcc 
		from Accidents_NDS
		GROUP BY Date ) as table2
where table1.Y < table2.Y
order by table1.Y, table2.Y

