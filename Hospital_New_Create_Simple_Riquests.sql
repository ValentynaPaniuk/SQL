use [master];
go

if db_id('Hospital') is not null
begin
	drop database [Hospital];
end
go

create database [Hospital];
go

use [Paniuk_Hospital_New];
go

create table [Departments]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N'')
);
go

create table [Doctors]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Premium] money not null check ([Premium] >= 0.0) default 0.0,
	[Salary] money not null check ([Salary] > 0.0),
	[Surname] nvarchar(max) not null check ([Surname] <> N'')
);
go

create table [DoctorsSpecializations]
(
	[Id] int not null identity(1, 1) primary key,
	[DoctorId] int not null,
	[SpecializationId] int not null
);
go

create table [Donations]
(
	[Id] int not null identity(1, 1) primary key,
	[Amount] money not null check ([Amount] > 0.0),
	[Date] date not null check ([Date] <= getdate()) default getdate(),
	[DepartmentId] int not null,
	[SponsorId] int not null
);
go

create table [Specializations]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N'')
);
go


create table [Sponsors]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N'')
);
go

create table [Vacations]
(
	[Id] int not null identity(1, 1) primary key,
	[EndDate] date not null,
	[StartDate] date not null,
	[DoctorId] int not null,
	check ([StartDate] < [EndDate])
);
go

create table [Wards]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(20) not null unique check([Name] <> N''),
	[DepartmentId] int not null
);
go

alter table [Donations]
add foreign key ([DepartmentId]) references [Departments]([Id]);
go


alter table [Donations]
add foreign key ([SponsorId]) references [Sponsors]([Id]);
go

alter table [DoctorsSpecializations]
add foreign key ([DoctorId]) references [Doctors]([Id]);
go

alter table [DoctorsSpecializations]
add foreign key (SpecializationId) references [Specializations]([Id]);
go

alter table [Vacations]
add foreign key ([DoctorId]) references [Doctors]([Id]);
go


alter table Examinations
add DoctorID int foreign key references Doctors(ID)

alter table Donations
add DoctorID int foreign key references Doctors(ID)

update Examinations
set DoctorID = 4
where DayOfWeek=2
go

update Examinations
set DoctorID = 5
where DayOfWeek=4
go

update Examinations
set DoctorID = 6
where DayOfWeek=1
go


update Examinations
set DepartmentID = 7
where DayOfWeek=2
go

update Examinations
set DepartmentID = 9
where DayOfWeek=1
go


update Examinations
set DepartmentID = 12
where DayOfWeek=4
go

update Examinations
set DateOfExaminations = '2020-01-01'
where ID=1
go

update Examinations
set DateOfExaminations = '2019-05-08'
where ID=2
go

update Examinations
set DateOfExaminations = '2020-04-13'
where ID=3
go


update Examinations
set WardID = 12
where DayOfWeek=2
go

update Examinations
set WardID = 17
where DayOfWeek=4
go

update Examinations
set WardID = 13
where DayOfWeek=1
go

update Examinations
set DiseaseID = 1
where ID=5
go



update Donations
set DoctorID = 4
where ID=1
go

update Donations
set DoctorID = 6
where ID = 2

update Donations
set DoctorID = 5
where ID = 3

update Donations
set DoctorID = 4
where ID=5
go

update Donations
set DoctorID = 6
where ID=4
go

update Departments
set DoctorID = 4
where ID = 7

update Departments
set DoctorID = 6
where ID = 9

update Departments
set DoctorID = 5
where ID = 12

update Departments
set DoctorID = 7
where ID = 13

update Diseases
set SpecializationID = 2
where ID = 2

update Diseases
set SpecializationID = 3
where ID = 3

update Diseases
set SpecializationID = 1
where ID = 1


update Diseases
set DepartmentID = 7
where ID = 2

update Diseases
set DepartmentID = 9
where ID = 1

update Diseases
set DepartmentID = 13
where ID = 3


alter table Examinations
add DepartmentID int foreign key references Departments(ID)

alter table Examinations
add WardID int foreign key references Wards(ID)


-- У випадку коли треба створити поле і зробити зовнішнім ключем
alter table Wards
add DepartmentId int foreign key references Departments(ID) 
go

alter table Departments
add DoctorID int foreign key references Doctors(ID)
go

alter table Diseases
add SpecializationID int foreign key references Specializations(ID)

alter table Diseases
add DepartmentId int foreign key references Departments(ID) 
go

alter table Examinations add DateOfExaminations date not null check(DateOfExaminations<>'') default('2020-03-18')

alter Table Examinations 
add DiseaseID int foreign key references Diseases(ID)


Insert into [Specializations] values('Cosmetology'), ('Surgery'), ('Therapist');
Insert into [Sponsors] values('Ivan Petrovych'), ('Olga Pavlivna'), ('Kyryl Ivanovych');

insert into Vacations values ('2020-01-18', '2020-01-01',4)
insert into Vacations values ('2020-02-27', '2020-02-12',5)
insert into Vacations values ('2020-03-18', '2020-03-10',6)

insert into DoctorsSpecializations values (4,1)
insert into DoctorsSpecializations values (5,2)
insert into DoctorsSpecializations values (6,3)


insert into Donations values (1000, '2019-01-01', 1, 7)
insert into Donations values (1500, '2020-02-02', 2, 9)
insert into Donations values (2000, '2020-03-03', 3, 12)
insert into Donations values (3000, '2020-04-04', 1, 13)
insert into Donations values (5000, '2020-04-04', 1, 7)

insert into Examinations values (6, '16:00', 'Ddd', '13:00', 6, 13, 18)


insert into Wards values (2, 2, 'One_7', 7)
insert into Wards values (2, 2, 'Two_7', 7)
insert into Wards values (3, 1, 'One_9', 9)
insert into Wards values (3, 1, 'Two_9', 9)
insert into Wards values (1, 3, 'One_12', 12)
insert into Wards values (1, 3, 'Two_12', 12)
insert into Wards values (4, 4, 'One_13', 13)
insert into Wards values (4, 4, 'Two_13', 13)

insert into Doctors values ('Kolya', '0975991335', 40000, 'Kovalchuk', 0 )

----Витираємо вміст таблиць
--truncate table Departments
--truncate table Deseases
--truncate table Doctors
--truncate table DoctorsSpecializations
--truncate table Donations
--truncate table Examinations
--truncate table Specializations
--truncate table Sponsors
--truncate table Vacations
--truncate table Wards



Select *from Departments
Select *from Diseases
Select *from Doctors
Select *from DoctorsSpecializations
Select *from Donations
Select *from Examinations
Select *from Specializations
Select *from Sponsors
Select *from Vacations
Select *from Wards

delete from Specializations
where ID=4

--1. Повне ім'я лікарів і їх спеціалізація
select D.Name+' '+D.Surname as FullName, S.Name as Specializations
from Doctors D, Specializations S, DoctorsSpecializations DS
where D.ID=DS.DoctorID and DS.SpecializationID = S.ID

--2. Вивести прізвища і ЗП(сума ставки + премії) лікарів, які не находяться у відпустці
select D.Surname as Surname, D.Salary+D.Premium as 'ZP+Premium'
from Doctors D, Vacations V 
where GETDATE()>V.EndDate and D.ID=V.DoctorID

--3. Вивести назви палат, що не знаходяться в відділенні "Pediatric Department"
select W.Name as 'Name Ward'
from Wards W
Where W.DepartmentId <> 9

--4. Вивести назви відділень без повторів, які спонсоруються компанією "Ivan Petrovych"
select distinct D.Name as 'Name Department'
from Departments D, Sponsors S, Donations Dn
where D.ID = Dn.DepartmentID and Dn.SponsorsID = S.ID and S.Name='Ivan Petrovych'

--5. Вивести всі пожертви за останній місяць увигляді: відділення, спонсор, сума, дата пожертвування
select Dp.Name as 'Name Department', S.Name as 'Sponsor', D.Amount as 'Amount', D.Date as 'Date'
from Sponsors S, Donations D, Departments Dp
where D.DepartmentID=Dp.ID and S.ID=D.SponsorsID and D.Date between '2020-01-01' and '2020-06-30'

--6. Вивести прізвища лікарів з вказанням відділень, в яких вони проводять обстеження. Необхідно враховувати огляд лише в робочі дні.
select D.Surname as 'Surname', Dp.Name as 'Name Department'
from Doctors D, Departments Dp, Examinations E
where D.ID=E.DoctorID and Dp.ID = E.DepartmentID and DayOfWeek between 1 and 5

--7. Вивести назви палат і корпуси відділень, в яких проводиь огляд лікар Iryna Petrova
select W.Name as 'Name Ward', Dp.Name as 'Name Department', D.Name as 'Doctor Name'
from Wards W, Departments DP, Examinations E, Doctors D
where W.ID=E.WardID and DP.ID=E.DepartmentID and D.ID=E.DoctorID and D.Name = 'Iryna' and D.Surname='Petrova'

--8. Вивести назви відділень, які отримали пожертви в розмірі більше 2000, з вказанням їх лікарів
select Dp.Name as "Name Department", D.Name as 'Doctor Name', Dn.Amount as 'Amount'
from Departments Dp, Donations Dn, Doctors D
where Dp.ID = Dn.DepartmentID and D.ID =Dn.DoctorID and Dn.Amount>2000

--9. Вивести назви відділень, в яких є лікарі, що не отримують надбавки
select Dp.Name as 'Name Department', D.Name+' '+D.Surname as FullName
from Departments Dp, Doctors D
where Dp.DoctorID = D.ID and D.Premium=0;

--10. Вивести назви спеціалізацій, які використовуються для лікування хвороб з ступінню важкості вище 3
select Sp.Name as "Specialization", D.Name as 'Name Disease'
from Specializations Sp, Diseases D
where Sp.ID = D.SpecializationID and D.Severity=3

--11. Вивести назви відділень і хвороб, обстеження по яких вони проводили за останні 6 місяців
select Dp.Name as 'Department Name', D.Name as 'Name Disease'
from Departments Dp, Diseases D, Examinations E
where Dp.ID = E.DepartmentID and D.ID=E.DiseaseID and  DateOfExaminations between '2020-01-01' and '2020-06-01'

--12. Вивести назви відділень і палат, в яких проводилися обстеження по заразним захворюванням
select Dp.Name as 'Department Name', W.Name as 'Name Ward'
from Departments Dp, Wards W, Examinations E
where Dp.ID = E.DepartmentID and W.ID = E.WardID and E.DiseaseID = 3
