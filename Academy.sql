Create database Paniuk_Academy

use Paniuk_Academy

create table Groups(
ID int primary key identity,  -- identity - тоді не треба додавати вручну
Name nvarchar(10) not null check(Name<>'') unique,
Rating int not null check (Rating>=0 and Rating<=5),
Year int not null check (Year>=1 and Year<=5)
);

Insert into Groups values ( 'Valia', 3, 2),
                          ( 'Petro',5, 1),
						  ( 'Ira', 4, 2)


create table Departments
(ID int primary key identity,
 Financing money not null check(Financing>=0) default(0),
 Name nvarchar(100) not null check(Name<>'') unique,
);

Insert into Departments values ( 100000, 'Managment'),
                               ( 50000, 'Filology'),
						       ( 300000, 'Mathematic')



create table Faculties
( ID int primary key identity,
Name nvarchar(100) not null check(Name<>'') unique,
);

Insert into Faculties values ( 'Managment Faculty'),
                             ('Filology Faculty'),
						      ('Mathematic Faculty')


create table Teachers
(
ID int primary key identity,
EmploymentDate date not null check(EmploymentDate>'01.01.1990'),
Name nvarchar(max) not null check(Name<>''),
Premium money not null check(Premium>=0) default(0),
Salary money not null check(Salary>=0),
Surname nvarchar(max) not null check(Surname<>''),
);

Insert into Teachers values ( '01.12.1998', 'Igor Petrovych', 2000, 25000, 'Kondratuik' ),
                             ( '01.12.2000', 'Ivan Olecksiyovych', 2500, 27000, 'Pozniakovskiy' ),
						     ( '01.12.2003', 'Iryna Evhenivna', 2800, 28000, 'Ruda' )



select *from Departments
select *from Faculties
select *from Groups
select *from Teachers

--


use Paniuk_Academy