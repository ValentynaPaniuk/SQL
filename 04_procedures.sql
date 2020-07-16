-- stored procedures
select * from Student
select * from Groups
select * from Achievement

go
-- alter
-- drop
create procedure sp_ShowStudents
as 
	begin
		select S.Name, S.Surname, G.Name as GroupName
		from Student S join Groups G on S.IdGroup = G.Id
	end
go

-- варіанти запуску процедур
exec sp_ShowStudents
--execute sp_ShowStudents
--sp_ShowStudents
-------------

-- select * from dbo.sp_ShowStudents -- error

go
-- Процедура, що поверне кількість студентів в кожній групі
create procedure sp_CountStudentsInGroup
as
begin
	select G.Name, Count(S.Id)as [Count]
	from Groups G join Student S on G.Id = S.IdGroup
	Group by G.Name
end


exec sp_CountStudentsInGroup
go
alter procedure sp_ListStudents
@name nvarchar(10) = 'Pr123' -- вхідний параметр
as
begin
	select S.Name, S.Surname, G.Name as Groups
	from Groups G join Student S on G.Id = S.IdGroup
	Where G.Name = @name
end
go
drop procedure sp_CountStudents

go
declare @name nvarchar(10) = 'A123'
exec sp_ListStudents @name

exec sp_ListStudents 

go
-- Процедура, яка повертає к-сть студентів у певній групі
create proc sp_CountStudents
@name nvarchar(10)   -- вхідний параметр (назва групи)
as
begin
-- проміжна змінна, щоб зберегти кількість студентів
	declare @count int
	select @count = Count(*)
	from Student S join Groups G on S.IdGroup = G.Id
	where G.Name = @name
	-- повертаємо кількість 
	return @count
end

-- створити змінну для результату
declare @res int
-- виклик процедури, яка повертає значення
exec @res = sp_CountStudents 'Pr123'
-- друкуємо результат, який повернувся з проц.
Print 'result = ' +  str(@res)

--
go
create proc sp_CountStudTest
@name nvarchar(10)   -- вхідний параметр (назва групи)
as
begin
-- проміжна змінна, щоб зберегти кількість студентів
	return
			select Count(*)
			from Student S join Groups G on S.IdGroup = G.Id
			where G.Name = @name
end

declare @res int
exec @res = sp_CountStudents 'Pr123'
Print 'result = ' +  str(@res)


-----
go
create proc sp_countStudOutput
@name nvarchar(10),
@countStud int output
as
begin
	select @countStud = Count(*)
	from Student S join Groups G on S.IdGroup = G.Id
	where G.Name = @name
end

go
declare @res int
exec sp_countStudOutput 'A123', @res output 
Print str(@res) + ' students in group'

