go
create database Paniuk_Barbershop
go
use Paniuk_Barbershop
go

select *from Employee
create table Employee
(
ID int primary key identity,
FullName nvarchar(50) not null,
Gender nvarchar (30) not null,
Phone nvarchar(50) not null,
Email nvarchar(30) not null unique,
BirthDate date not null check(BirthDate>'01.01.1970'),
EmploymentDate date not null check(EmploymentDate>'01.01.1990'),
PositionID int foreign key references Position(ID)
)

insert into Employee values ('Olena Lys', 'female', '096-599-13-35', 'Lys@gmail.com', '1984-10-06', '2019-03-10', 1)
insert into Employee values ('Katya Lytvyniuk', 'female', '096-599-15-18', 'Lytvyniuk@gmail.com', '1990-11-16', '2018-02-10', 2)
insert into Employee values ('Oleg Kovalchuk', 'male', '096-655-15-18', 'Kovalchuk@gmail.com', '1988-06-10', '2020-02-10', 3)
insert into Employee values ('Kostia Popov', 'male', '096-655-15-18', 'Popov@gmail.com', '1986-07-10', '2014-02-10', 3)
insert into Employee values ('Yulia Ostapiuk', 'male', '096-625-14-18', 'Ostapiuk@gmail.com', '1998-08-10', '2020-12-10',2)


select *from Position
go
create table Position
(ID int primary key identity,
PositionName nvarchar(50) not null check(PositionName<>'')
)
insert into Position values ('Chip barber')
insert into Position values ('Signor Barber')
insert into Position values ('Junior barber')

go
select *from Service
create table Service
(ID int primary key identity,
 ServicesName nvarchar(50) not null check(ServicesName<>''),
 ServicesTime time not null check(ServicesTime>'00:00')
  )

insert into Service values ('Haircut', '00:30')
insert into Service values ('Laying', '01:00')
insert into Service values ('Hair highlighting', '03:00')
insert into Service values ('Shampoo', '00:10')
insert into Service values ('Shaving beard', '00:40')

select *from Feedback
create table Feedback
(
ID int primary key identity,
IDCustomer int foreign key references Customer(ID),
IDEmployee int foreign key references Employee(ID),
IDReview int foreign key references Reviews(ID),
Review nvarchar(50) not null
)

create table Reviews
(
 ID int primary key identity,
 Mark int not null check(Mark>=1 and Mark<=5),
 Review nvarchar(50) not null
)

insert into Reviews values (1, 'Very bad')
insert into Reviews values (2, 'Badly')
insert into Reviews values (4, 'Well')
insert into Reviews values (5, 'Perfectly')

go

--Расписание
create table Schedule
(
ID int primary key identity,
IDCustomer int foreign key references Customer(ID),
IDEmployee int foreign key references Employee(ID),
IDService int foreign key references Service(ID),
DateService date not null check(DateService>'01.01.1990'),

)

select *from Customer
select *from Employee
select *from Service

insert into Schedule values (1, 2, 1, '2020-03-18')
insert into Schedule values (1, 3, 2, '2020-04-17')
insert into Schedule values (1, 4, 3, '2020-01-13')
insert into Schedule values (2, 5, 4, '2019-10-03')
insert into Schedule values (2, 1, 5, '2020-02-08')
insert into Schedule values (3, 2, 1, '2020-01-08')
insert into Schedule values (3, 3, 2, '2020-03-06')


create table Customer
(
ID int primary key identity,
FullName nvarchar(30) not null,
Phone nvarchar(30) not null,
Email nvarchar(30) not null unique,

)

insert into Customer values ('Nastia Tokar', '066-152-17-30','Tokar@gmail.com')
insert into Customer values ('Alla Sulhuk', '096-114-10-35','Sulhuk@gmail.com')
insert into Customer values ('Iryna Petrenko', '099-115-10-38','Petrenko@gmail.com')

create table Archive
(
ID int primary key identity,
IDCustomer int foreign key references Customer(ID),
IDEmployee int foreign key references Employee(ID),
IDService int foreign key references Service(ID),
DateService date not null check(DateService>'01.01.1990'),
IDReviews int foreign key references Reviews(ID)

)

select *from Service
select *from Employee
select *from Position

create table EmployeeService
(
ID int primary key identity,
IDPosition int foreign key references Position(ID),
IDService int foreign key references Service(ID),
)
drop table EmployeeService

insert into EmployeeService values (3,4)
insert into EmployeeService values (3,1)
insert into EmployeeService values (2,1)
insert into EmployeeService values (2,2)
insert into EmployeeService values (2,3)
insert into EmployeeService values (2,4)
insert into EmployeeService values (1,1)
insert into EmployeeService values (1,2)
insert into EmployeeService values (1,3)
insert into EmployeeService values (1,4)
insert into EmployeeService values (1,5)


--2.1 Повернути ПІБ всіх працівиків салону
go
create procedure sp_ShowEmployees
as 
	begin
		select E.FullName, P.PositionName
		from Employee E join Position P on E.PositionID = P.ID
	end
go

exec sp_ShowEmployees
--2.2 Повернути ПІБ працівників, що займають посаду "Signor Barber"
go
create procedure sp_ShowSignorBarber
as 
	begin
		select E.FullName, P.PositionName as 'Signor Barber'
		from Employee E join Position P on E.PositionID = P.ID
		where P.PositionName = 'Signor Barber'
	end
go

exec sp_ShowSignorBarber

--2.3 Повернути інформацію про всіх перукарів, які надають послугу "Бриття бороди"
go
create procedure sp_ShowEmployee_ServiceShavingBeard
as 
	begin
		select E.FullName, S.ServicesName
		from Position P join Employee E on P.ID = E.PositionID	
		                join EmployeeService ES on P.ID = ES.IDPosition
						join Service S on ES.IDService = E.ID
						where S.ServicesName = 'Shaving beard'
	end
go

exec sp_ShowEmployee_ServiceShavingBeard

--2.4 Повернути інформацію про всіх перукарів, які надають конкретну послугу. Послуга в параметрі
go
create function fn_showEmployee(@service nvarchar(30))
returns table
as
	return (select E.FullName, S.ServicesName
		from Position P join Employee E on P.ID = E.PositionID	
		                join EmployeeService ES on P.ID = ES.IDPosition
						join Service S on ES.IDService = E.ID
						where S.ServicesName = @service)
go

select *
from fn_showEmployee('Shaving beard')

go

--2.5 Повернути інформацію про перукарів, які працюють більше вказаної кількoсті років. Кількість років в параметрах
select *from Employee
go
create function fn_showEmployeeYears(@year int)
returns table
as
	return (select E.FullName, E.PositionID
		from Position P join Employee E on P.ID = E.PositionID	
		 where DATEDIFF(year, E.EmploymentDate, getdate()) >=@year  )            
go


select *
from fn_showEmployeeYears(5)

--2.6 Повернути кількість "Signor Barber" і кількість "Junior"
-- Only Signor *************************************************
go
create function fn_CountEmployee()
returns table
as
   return (select count(E.ID) as 'Signor Barber'
          from Employee E join Position P on E.PositionID = P.ID
          where P.PositionName = 'Signor Barber')
go

select *
from fn_CountEmployee()

--Only Junior *************************************************
go
create function fn_CountEmployeeJunior()
returns table
as
   return (select count(E.ID) as 'Junior barber'
          from Employee E join Position P on E.PositionID = P.ID
          where P.PositionName = 'Junior barber')
go

select *
from fn_CountEmployeeJunior()

-- Signer + Unior
select *
from fn_CountEmployeeJunior(), fn_CountEmployee()


--2.7 Повернути інформацію про постійних клієнтів. Критерій постійного клієнта - був в салоні певну кількість разів. Кількість разів в параметрах
go
create function fn_Regular_Customer (@count int)
returns table
as

   return (select C.FullName as 'Customer'
          from Customer C join Schedule S on C.ID = S.IDCustomer 
		  group by C.FullName
          having count (C.ID) >= @count)
		  
go

select *from Customer
select * from fn_Regular_Customer(3)
--2.8 Заборонити можливість видалення інформації про "Chip barber", якщо не доданий другий Chip barber
go
create trigger onDeleteEmployee
on Employee
for delete
as
begin
	declare @count int
	select @count = COUNT(E.ID) 
	from Employee E 
	join Position P on E.PositionID = P.ID
	where P.PositionName = 'Chip barber'
	if @count <= 1
	    begin
		rollback transaction
		print 'Deletion is prohibited'
		end
	else
		print 'Operation delete completed successfully'
end

select *from Employee
select *from Position

delete from Employee
where ID=13

--2.9 Заборонити додавати барберів молодший 21 року
go
create trigger onInsertEmployee
on Employee
for insert
as
begin
	declare @age int
	select @age = DATEDIFF(year, I.BirthDate, getdate()) from inserted I
	if @age < 21
	    begin
		rollback transaction
		print 'The Employee is under 21 years old'
		end
	else
		print 'Operation delete completed successfully'
end

insert into Employee values ('Ivan Homych', 'male', '0362-255-13-10', 'Homych@gmail.com', '2000-07-01', '2016-01-10', 3)

go