use [master];
go



create database [Hospital_20200623];
go

use [Hospital_20200623];
go

create table [Departments]
(
	[Id] int not null identity(1, 1) primary key,
	[Building] int not null check ([Building] between 1 and 5),
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

create table [DoctorsExaminations]
(
	[Id] int not null identity(1, 1) primary key,
	[EndTime] time not null,
	[StartTime] time not null check ([StartTime] between '08:00' and '18:00'),
	[DoctorId] int not null,
	[ExaminationId] int not null,
	[WardId] int not null,
	check ([StartTime] < [EndTime])
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

create table [Examinations]
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

create table [Wards]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(20) not null unique check ([Name] <> N''),
	[Places] int not null check ([Places] >= 1),
	[DepartmentId] int not null
);
go

alter table [DoctorsExaminations]
add foreign key ([DoctorId]) references [Doctors]([Id]);
go

alter table [DoctorsExaminations]
add foreign key ([ExaminationId]) references [Examinations]([Id]);
go

alter table [DoctorsExaminations]
add foreign key ([WardId]) references [Wards]([Id]);
go

alter table [Donations]
add foreign key ([DepartmentId]) references [Departments]([Id]);
go

alter table [Donations]
add foreign key ([SponsorId]) references [Sponsors]([Id]);
go

alter table [Wards]
add foreign key ([DepartmentId]) references [Departments]([Id]);
go

insert into [Departments] values (1, 'Department 1')
insert into [Departments] values (2, 'Department 2')
insert into [Departments] values (3, 'Department 3')
insert into [Departments] values (4, 'Department 4')
insert into [Departments] values (2, 'Department 5')
insert into [Departments] values (1, 'Department 6')
insert into [Departments] values (3, 'Department 7')

insert into [Doctors] values ('Olga', 2000, 15000, 'Lys')
insert into [Doctors] values ('Ivan', 1000, 16000, 'Popov')
insert into [Doctors] values ('Alla', 3000, 20000, 'Sulhuk')
insert into [Doctors] values ('Nik', 0, 10000, 'Tomson')

insert into Examinations values ('Aaaaa')
insert into Examinations values ('Bbbbb')
insert into Examinations values ('Cccccc')
insert into Examinations values ('Dddddd')


insert into Wards values ('One Ward Dep 1', 5, 1)
insert into Wards values ('Two Ward Dep 1', 15, 1)
insert into Wards values ('One Ward Dep 2', 5, 2)
insert into Wards values ('Two Ward Dep 2', 20, 2)
insert into Wards values ('One Ward Dep 3', 5, 3)
insert into Wards values ('Two Ward Dep 3', 20, 3)
insert into Wards values ('One Ward Dep 4', 50, 4)
insert into Wards values ('Two Ward Dep 4', 50, 4)



insert into [DoctorsExaminations] values ('15:00', '13:00', 1, 2, 8)
insert into [DoctorsExaminations] values ('13:00', '11:00', 1, 2, 2)
insert into [DoctorsExaminations] values ('14:00', '10:00', 2, 2, 3)
insert into [DoctorsExaminations] values ('12:00', '08:00', 2, 2, 4)
insert into [DoctorsExaminations] values ('12:00', '08:00', 3, 2, 5)
insert into [DoctorsExaminations] values ('10:00', '08:00', 3, 2, 6)
insert into [DoctorsExaminations] values ('10:00', '08:00', 2, 4, 4)
insert into [DoctorsExaminations] values ('11:00', '08:00', 4, 3, 7)
insert into [DoctorsExaminations] values ('15:00', '08:00', 4, 3, 8)


Insert into [Sponsors] values('Ivan Petrovych'), ('Olga Pavlivna'), ('Kyryl Ivanovych') 
Insert into Sponsors values ('Leonid Kravchuk');

insert into Donations values (1000, '2019-01-01', 1, 1)
insert into Donations values (1500, '2020-02-02', 2, 2)
insert into Donations values (2000, '2020-03-03', 3, 3)
insert into Donations values (3000, '2020-04-04', 4, 2)
insert into Donations values (5000, '2020-04-04', 1, 3)



select *from Departments
select *from Doctors
select *from DoctorsExaminations
select *from Donations
select *from Examinations
select *from Wards

--20200623 Підзапити
--1. Вивести назви відділень, що находяться в тому ж корпусі, що і відділення 'Department 2'
select *from Departments
select Dp.Name as 'Name Department'
from Departments Dp
where Dp.Building =(select Dp.Building 
                    from Departments Dp 
					where Dp.Name='Department 2' )

--2. Вивести назви відділень, що находяться в тому ж корпусі, що і відділення 'Department 1' і 'Department 3'
select *from Departments
select Dp.Name as 'Name Department'
from Departments Dp
--variant 1
--where Dp.Building = any(select Dp.Building 
--                    from Departments Dp 
--					where (Dp.Name='Department 1' or Dp.Name='Department 3'))

--variant 2
where Dp.Building in (select Dp.Building 
from Departments Dp 
where (Dp.Name='Department 1' or Dp.Name='Department 3'))

--3. Вивести назви відділень, що отримали менше всього пожертв
select *from Departments
select *from Donations
select Dp.Name as 'Name Department'
from Departments Dp, Donations D
where Dp.Id=D.DepartmentId and D.Amount = (select min(D.Amount) 
                                           from Donations D)


--4. Вивести прізвища лікарів, ставка яких більше ніж у лікаря 'Olga Lys'
select *from Doctors
select D.Surname as 'Doctor Surname', D.Salary as 'Salary'
from Doctors D
where D.Salary > (select D.Salary 
                  from Doctors D 
				  where D.Name='Olga' and D.Surname='Lys')

--5. Вивести назву палат, вмісткість яких більше ніж середня місткість в палатах відділення 'Department 3'
select *from Wards
select *from Departments
select W.Name as 'Ward Name'
from Wards W
where W.Places > (select avg(W.Places) 
                  from Wards W, Departments Dp 
				  where Dp.Name = 'Department 3')

--6. Вивести повні імена лікарів, ЗП (ЗП+Премія) перевищують більш ніж на 100 ЗП лікаря 'Olga Lys'
select *from Doctors
select D.Name+' '+D.Surname as "Full Name", D.Salary+D.Premium as 'Summa'
from Doctors D
where D.Salary+D.Premium-100 > (select D.Salary+D.Premium 
                            from Doctors D 
							where D.Name='Olga' and D.Surname='Lys')


--7. Вивести назву відділень, в яких проводить огляд лікар 'Ivan Popov'
select *from Departments
select *from Doctors
select *from DoctorsExaminations
select *from Wards

select distinct Dp.Name as 'Name Department'
from Departments Dp
where Dp.Name in (select Dp.Name 
               from Departments Dp, Doctors D, Wards W, DoctorsExaminations DE
			   where Dp.Id = W.DepartmentId and D.Id=DE.DoctorId and W.Id=De.WardId and D.Name = 'Ivan' and D.Surname='Popov')

--8. Вивести імена спонсорів, які не робили пожертви в відділення 'Department 1' і 'Department 3'
select *from Departments
select *from Donations
select *from Sponsors
select distinct S.Name as 'Sponsor'
from Sponsors S
where exists (select * 
                  from Donations Dn, Departments Dp 
				  where S.Id = Dn.SponsorId and Dp.Id=Dn.DepartmentId and Dp.Name != 'Department 1' and Dp.Name !='Department 3')


--9. Вивести прізвища лікарів, що проводять огляд в період з 8 до 12:00
select *from DoctorsExaminations
select D.Surname as 'Doctor Surname'
from Doctors D, DoctorsExaminations DE
where D.Id = DE.DoctorId and DE.StartTime = '08:00' and DE.EndTime = '12:00'