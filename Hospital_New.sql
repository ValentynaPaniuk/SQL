use master
Create database Paniuk_Hospital_New
use Paniuk_Hospital_New


create table Departments
(ID int primary key identity,
 Building int not null check (Building>1 and Building<5),
 Financing money not null check(Financing>=0) default(0),
 Name nvarchar(100) not null check(Name<>'') unique,
);

alter table Departments add Floor int not null check (Floor>=1)



drop table Departments

create table Diseases(
ID int primary key identity,
Name nvarchar(100) not null check(Name<>'') unique,
Severity int not null check(Severity>=1) default(1)

);

drop table Diseases

create table Doctors
(
ID int primary key identity,
Name nvarchar(max) not null check(Name<>''),
Phone char(10),
Salary money not null check(Salary>0),
Surname nvarchar(max) not null check(Surname<>''),
);

alter table Doctors add Premium money not null check (Premium>=0) default(0)

--drop table Doctors - видалити таблицю

create table Examinations
(
ID int primary key identity,  -- identity - тоді не треба додавати вручну
DayOfWeek int not null check(DayOfWeek>=1 and DayOfWeek<=7),
EndTime time not null,
Name nvarchar(100) not null check(Name<>'') unique,
StartTime time not null check(StartTime>='8:00' and StartTime<='18:00'),
check(EndTime>StartTime)
);

drop table Examinations

Insert into Examinations values ( 2, '17:00', 'Aaa', '12:00'),
                                ( 1, '12:00', 'Bbb', '11:00'),
							    ( 4, '18:00', 'Ccc', '14:00')

create table Wards(
ID int primary key identity,  -- identity - тоді не треба додавати вручну
Building int not null check (Building>1 and Building<5),
Floor int not null check (Floor>=1),
Name nvarchar(20) not null check(Name<>'') unique,
);

