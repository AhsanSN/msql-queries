/**
-- 1.
select Rand()

--2.
select floor(Rand()*100)

--3.
select abs(floor(Rand()*25 - Rand()*75))

--4.
select cast(abs(Rand()*100 - Rand()*99990)as int)/10.0

--4. for even step size
select 2*(cast(abs(Rand()*100 - Rand()*99990) as int)/10.0)

--5.
select rand(100)
declare @index int
set @index = 1
while @index <=500
	begin
		print(dateadd(day, (cast(abs(Rand()*729) as int)) , '1 january 2018'))
		set @index = @index + 1
	end

	**/
--6.

select rand(100)
declare @index int
set @index = 1
while @index <=500
	begin
		print dateadd(millisecond, cast(abs(Rand()*9999) as int) , dateadd(second,  cast(abs(Rand()*2.592e+6) as int), '1 november 2018 00:00:00.000'))
		set @index = @index + 1
	end


