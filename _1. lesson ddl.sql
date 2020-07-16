--use Test  -- використай БД Email
---- F5 Email


--SELECT Name as [Ім'я], Surname as 'Прізвище', Age as [Вік]
--FROM Employee

--SELECT [Name] + ' ' + Surname as [Full Name]
--FROM Employee

--Select *
--From Employee
--Order by Salary Desc

--Select Name, Surname, Age, Salary
--From Employee
--Where Salary >= 30000  -- > < >= <= <>   !=  !> !<  =  And Or
--Order by Age Asc   -- Asc - по зростанню, значення по замовчуванню. Desc - по спаданню

--Select Name, Surname, Age, Salary, Position
--From Employee
--Where Salary >30000 And Age = 20

---- I'm comment

--use master
--Drop database Test

-- Drop, Create, Alter... Email
-- DDL - Data Defination Language

--Create database Test

use Test
-- check - перевірка даних при вставці
create table Employee(
	Id int primary key identity,
	Name nvarchar(20) not null default('empty'),
	Surname nvarchar(30) not null,
	DateofBirth date check(DateofBirth < getdate()),
	Age int,
	Position nvarchar(30) not null,
	Salary money check(Salary > 0) default(4500),
	Email nvarchar(30) unique,
--	Check (Email <> '')
);
-- Додати обмеження на Email
alter table Employee
add check(Email <> '')

-- Видаляю обмеження (констреінт) Check
alter table Employee
Drop Constraint CK__Employee__Email__3B75D760

alter table Employee
add constraint CHK_EmployeeEmail check(Email <> '')

insert into Employee values ('ivan', 'Korobov', '1997-5-13', year(getdate()) - 1997,'Admin', 15000, 'ivan2@ukr.net'),
							('Olia', 'Ivanyshyna', '2000-7-12', year(getdate())- 2000, 'Designer', 18000, 'olia2@ukr.net'),
							('Olia', 'Ivanyshyna', '2000-7-12', year(getdate())- 2000, 'Designer', 18000, 'olia@gmail.com');

select * from Employee;

delete from Employee
where Id = 2;

delete from Employee
where Age = 22 And Name = 'Olia' --Email Like '%ukr.net'