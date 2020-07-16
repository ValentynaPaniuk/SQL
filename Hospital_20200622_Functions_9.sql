use [master];
go


create database [Paniuk_Hospital_2020_06_22];
go

use [Paniuk_Hospital_2020_06_22];
go

create table [Departments]
(
	[Id] int not null identity(1, 1) primary key,
	Building nvarchar(100) not null unique check ([Building] <> N''),
	[Name] nvarchar(100) not null unique check ([Name] <> N'')
);
go

insert into [Departments] values (1, 'Department 1')
insert into [Departments] values (2, 'Department 2')
insert into [Departments] values (3, 'Department 3')
insert into [Departments] values (4, 'Department 4')

alter table Departments
add DoctorID int foreign key references Doctors(ID)
go

update Departments
set DoctorID = 4
where ID = 1

update Departments
set DoctorID = 3
where ID = 2

update Departments
set DoctorID = 2
where ID = 3

update Departments
set DoctorID = 1
where ID = 4


create table [Doctors]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Premium] money not null check ([Premium] >= 0.0) default 0.0,
	[Salary] money not null check ([Salary] > 0.0),
	[Surname] nvarchar(max) not null check ([Surname] <> N'')
);
go

insert into [Doctors] values ('Olga', 2000, 15000, 'Lys')
insert into [Doctors] values ('Ivan', 1000, 16000, 'Popov')
insert into [Doctors] values ('Alla', 3000, 20000, 'Sulhuk')
insert into [Doctors] values ('Nik', 0, 10000, 'Tomson')



create table Examinations
(
ID int primary key identity,  -- identity - ��� �� ����� �������� ������
Name nvarchar(100) not null check(Name<>'') unique

);
insert into Examinations values ('Aaaaa')
insert into Examinations values ('Bbbbb')
insert into Examinations values ('Cccccc')
insert into Examinations values ('Dddddd')


create table [Wards]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(20) not null unique check([Name] <> N''),
	Place int not null check (Place>0), 
	[DepartmentId] int not null foreign key references Departments(Id),
	
);
go

insert into Wards values ('One Ward Dep 1', 5, 1)
insert into Wards values ('Two Ward Dep 1', 15, 1)
insert into Wards values ('One Ward Dep 2', 5, 2)
insert into Wards values ('Two Ward Dep 2', 20, 2)
insert into Wards values ('One Ward Dep 3', 5, 3)
insert into Wards values ('Two Ward Dep 3', 20, 3)
insert into Wards values ('One Ward Dep 4', 50, 4)
insert into Wards values ('Two Ward Dep 4', 50, 4)





create table [DoctorsExaminations]
(
	[Id] int not null identity(1, 1) primary key,
	[EndTime] time not null,
	[StartTime] time not null,
	[DoctorId] int not null foreign key references Doctors(Id),
	[ExaminationId] int not null foreign key references Examinations(Id),
	WardsID int not null foreign key references Wards(Id),
	
);
go

drop table [DoctorsExaminations]

insert into [DoctorsExaminations] values ('15:00', '13:00', 1, 2, 8)
insert into [DoctorsExaminations] values ('13:00', '11:00', 1, 2, 9)
insert into [DoctorsExaminations] values ('14:00', '10:00', 2, 2, 10)
insert into [DoctorsExaminations] values ('12:00', '08:00', 2, 2, 11)
insert into [DoctorsExaminations] values ('12:00', '08:00', 3, 2, 12)
insert into [DoctorsExaminations] values ('10:00', '08:00', 3, 2, 13)
insert into [DoctorsExaminations] values ('10:00', '08:00', 2, 4, 13)
insert into [DoctorsExaminations] values ('11:00', '08:00', 4, 3, 13)
insert into [DoctorsExaminations] values ('15:00', '08:00', 4, 3, 13)



alter table [DoctorsExaminations]
add DepartmentID int foreign key references Departments(ID)
go


update [DoctorsExaminations]
set DepartmentID = 3
where DoctorId=2



--1. ������� ������� �����, ���� ���� ����� 10
select count(W.ID) as "Count Wards"
from Wards W
where W.Place>10

--2. ������� ����� ������� � ������� ����� � ������� � ���
select Dp.Building as 'Name Building', count(W.ID) as 'Count Wards'
from Departments Dp, Wards W
where Dp.Id = W.DepartmentId
group by Dp.Building

--3. ������� ����� ������� � ������� ����� � ������� � ���
select Dp.Name as 'Department Name', count (W.ID) as 'Count Wards'
from Departments Dp, Wards W
where Dp.Id = W.DepartmentId
group by Dp.Name

--4. ������� ����� ������� � ������� �������� ����� � ������� � ���
select Dp.Name as 'Department Name', sum (D.Salary+D.Premium) as "Summa"
from Departments Dp, Doctors D
where D.Id = Dp.DoctorID
group by Dp.Name

---- 5. ������� ����� �������, � ���� ��������� ����� 3 � ����� �����
select Dp.Name as 'Department Name', count (Dx.DoctorId) as 'Count Doctors'
from Departments Dp, Doctors D, [DoctorsExaminations] Dx
where Dp.Id = Dx.DepartmentID and D.Id = Dx.DoctorId
group by Dp.Name
having count (Dx.DoctorId)>=3


--6. ������� ������� ����� � �� ������� �� (������+�����)
select count(D.Id), sum (D.Salary+D.Premium) as "Summa"
from Doctors D

--7. ������� ������� �� (����+�����) �����
select avg(D.Salary+D.Premium) as "Avarage Salary"
from Doctors D

--8.������� ����� ����� � ��������� �������
select W.Name as 'Name Ward with min places', min(W.Place) as 'Min places' 
from Wards W
where W.Place = (select min(W.Place)
                 from Wards W)
group by W.Name


--9.������� � ���� �� ������� 1,2,3 ��� 4 ������� ������� ���� � ������� �������� 100.
--��� ����� ��������� ����� ������ � ������� ���� ����� 10

select Dp.Name as 'Department Name', sum(W.Place) as 'Summa Place'
from Departments Dp, Wards W
where Dp.Id=W.DepartmentId and W.Place>=10 -- and sum(Place) = 100
group by Dp.Name
having sum(W.Place)>=100





