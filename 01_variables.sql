--CRUD   Create Read Update Delete
-- 

use University
Go
DECLARE @name nvarchar(20)
SET @name = 'Nina'
Print @name

declare @number int
set @number = 123
select @number 'Number', @name 'Name'
--Print 'Number = ' +  cast(@number as nvarchar)
--Print 'Number = ' + convert(nvarchar, @number)

-- зм≥нн≥ табличного типу. « такою таблицею працюЇмо €к ≥з звичайною, але вона ≥снуЇ лише в межах пакету
--declare @tempTable table (Name Nvarchar(30), Mark int)

--insert into @tempTable select Name, avg(Mark) as Mark
--from Student S join Achievement A on S.Id = A.IdStudent
--group by Name

----select * from @tempTable
----order by Mark
---- надрукувати середню оц≥нку вс≥х студент≥в 
--declare @mark float
--select @mark = avg(Mark)
--from @tempTable

--Print 'Avg mark: ' + cast(@mark as nvarchar)

create table ##tempTable (
	Id int primary key identity,
	Name Nvarchar(30),
	Mark int
)


insert into ##tempTable select Name, avg(Mark) as Mark
from Student S join Achievement A on S.Id = A.IdStudent
group by Name

--select * from @tempTable
--order by Mark
-- надрукувати середню оц≥нку вс≥х студент≥в 

-- # - локальна тимчасова таблиц€
-- ## - глобальна тимчасова таблиц€
declare @mark float
select @mark = avg(Mark)
from ##tempTable

Print 'Avg mark: ' + cast(@mark as nvarchar)
Go
--Print @name -  --error

select *
from ##tempTable

-- пох≥дна таблиц€
-- ≥снуЇ т≥льки дл€ першого з'Їднанн€
--with AvgMarks(Name, Mark) as (
--	select Name, avg(Mark) as Mark
--	from Student S join Achievement A on S.Id = A.IdStudent
--	group by Name
--)

--select * from AvgMarks
--select * from AvgMarks
--------------------------------------------------------------------------------

declare @tempTable table (Id int, Name Nvarchar(30), Mark int)

insert into @tempTable select S.Id, Name, avg(Mark) as Mark
from Student S join Achievement A on S.Id = A.IdStudent
group by Name, S.Id

select * from @tempTable
order by Mark

declare @mark float
select @mark = avg(Mark)
from @tempTable

if @mark < 6
	begin
		Print 'In block scope'
		Print cast(@mark as nvarchar) + ' is less than 7'
	end
else
  begin
  -- якщо оц≥нка >= 6 - то онови студенту з Id = 6 оц≥нку на 12
	Print cast(@mark as nvarchar) + ' is greater or equal than 6'
	update @tempTable
	set Mark = 12
	where Id = @mark
	end
select * from @tempTable

declare @num int
set @num = 10
while @num > 0
	begin	
	set @num = @num - 1
	if @num + 1 = 5
			continue
		Print @num + 1
	if @num + 1 = 3
		break

	end

	-- view
