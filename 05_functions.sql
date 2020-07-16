-- user defined functions (UDF)
-- 1) scalar --> 0-... parameters, always return single value
-- 2) inline-table ----> returns table
-- 3) multistatement table   ----> return table

select square(4)   -- ������������(���������) �������� �������  -- ������ ��� ����-���� ������ ������� �� � ���� �������� ��� ����������� ���������
select getdate()

create database SampleDb
go
use SampleDb
go
create table Department(
	Id int identity primary key,
	Name nvarchar(20) not null
)
go
create table Employee (
	Id int identity primary key,
	Name nvarchar(20) not null,
	DepartmentId int foreign key references Department(Id),
	DateOfBirth datetime not null,
	Gender nvarchar(10),
	Salary money not null
)
go

insert into Department values('IT'), ('Sales'), ('Management')
go
insert into Employee values 
								('Bill', 1, '2000-12-12', 'male', 2000),
								('Sam', 1, '1995-12-12', 'male', 5000),
								('Peter', 3, '1989-12-12', 'male', 10000),
								('Alex', 1, '1992-12-12', 'male', 7000),
								('Ira', 1, '1999-12-12', 'female', 6789)
								
go

create proc sp_showEmployee
@gender nvarchar(10)
as
begin
	select E.Name, E.Salary, D.Name as Department
	from Employee E join Department D on E.DepartmentId = D.Id
	where E.Gender = @gender
end

go

exec sp_showEmployee 'male'

go

-- scalar function
create function fn_calcAge(@DOB date)
returns int
as	
	begin
		declare @age int
		set @age = DATEDIFF(year, @DOB, getdate());
		return @age
	end

go

create proc sp_calcAge
@DOB date
as	
	begin
		declare @age int
		set @age = DATEDIFF(year, @DOB, getdate());
		return @age
	end

go
-- ������ �������� �������: [owner name].[function_name]
select dbo.fn_calcAge('2000-12-12')  -- ��������������
go
select E.Name, E.Salary, D.Name as Dep, dbo.fn_calcAge(E.DateOfBirth) as Age
from Employee E join Department D on E.DepartmentId = D.Id
where dbo.fn_calcAge(E.DateOfBirth) > 25

/*
    create function fn_name([@param type, ...])
	returns return_type
	as
		begin
			operators....
			return return_type
		end
	*/
	go


-- inline table-valued function:
-- 1) returns table
-- 2) ��� ������� �� ����������� � begin end
-- 3) ��������� �������, �� ����������� ����������� ���������� select
-- 4) ����� ��������������� � join
alter function fn_showEmployee(@gender nvarchar(10))
returns table
as
	return (select E.Name, E.Salary, D.Name as Department, E.Gender
			from Employee E join Department D on E.DepartmentId = D.Id
			where E.Gender = @gender)
go
select *
from fn_showEmployee('male')

go
create function fn_shortDate(@gender nvarchar(10))
returns table
as 
	return (select Name, Salary, DepartmentId, cast(DateOfBirth as date) as DOB 
			from Employee
			where Gender = @gender)

			go

select * from fn_shortDate('female')

update fn_showEmployee('female')
set Name = 'Olena'

select E.Name, D.Name
from fn_shortDate('female') E join Department D on E.DepartmentId = D.Id

go
---------
--- multistatement table-valued functions
create function fn_mstv_GetEmp()
returns @Table table(Name nvarchar(20), DepName nvarchar(20), Age int)
as
	begin
			insert into @Table
			select E.Name, D.Name as Dep, dbo.fn_calcAge(E.DateOfBirth)
			from Employee E join Department D On E.DepartmentId = D.Id
		return 
	end

select * from fn_mstv_GetEmp()