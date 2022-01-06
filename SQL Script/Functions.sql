use UCA_NDS
go

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

