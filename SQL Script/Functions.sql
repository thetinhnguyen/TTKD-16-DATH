use UCA_STAGE
go
create or alter FUNCTION dbo.get_type_time(@dateTime datetime)
returns int
as
begin
	declare @hour int = CAST(DATEPART(HOUR, @dateTime) AS int);
	declare @type int = 4;
	if @hour >= 5 and @hour < 12
		set @type = 1;
	else if @hour >= 12 and @hour < 17
		set @type = 2;
	else if @hour >= 17 and @hour < 21
		set @type = 3;

	return @type;
end