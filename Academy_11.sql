use [master];
go

-- Paniuk_Academy_New ; 
if db_id('Paniuk_Academy_New') is not null
begin
	drop database [Academy];
end
go

create database [Paniuk_Academy_New];
go

use [Paniuk_Academy_New];
go

create table [Curators]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Surname] nvarchar(max) not null check ([Surname] <> N'')
);
go

insert into [Curators] values ('Anna', 'Semeniuk')
insert into [Curators] values ('Kateryna', 'Kovalchuk')
insert into [Curators] values ('Ivan', 'Kotovec')

create table [Departments]
(
	[Id] int not null identity(1, 1) primary key,
	[Financing] money not null check ([Financing] >= 0.0) default 0.0,
	[Name] nvarchar(100) not null unique check ([Name] <> N''),
	[FacultyId] int not null
);
go

insert into Departments values (50000, 'Department 1', 1)
insert into Departments values (50000, 'Department 2', 2)
insert into Departments values (50000, 'Department 3', 3)


create table [Faculties]
(
	[Id] int not null identity(1, 1) primary key,
	[Financing] money not null check ([Financing] >= 0.0) default 0.0,
	[Name] nvarchar(100) not null unique check ([Name] <> N'')
);
go

insert into Faculties values (15000, 'Faculty of Management')
insert into Faculties values (55000, 'Faculty of Mathematics and Informatics')
insert into Faculties values (20000, 'Faculty of Philology')

create table [Groups]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N''),
	[Year] int not null check ([Year] between 1 and 5),
	[DepartmentId] int not null
);
go

insert into Groups values ('Management-2', 2, 1)
insert into Groups values ('Management-4', 4, 1)
insert into Groups values ('Mathematic-5', 5, 2)
insert into Groups values ('Philology-3', 3, 3)
insert into Groups values ('Philology-2', 2, 3)

create table [GroupsCurators]
(
	[Id] int not null identity(1, 1) primary key,
	[CuratorId] int not null,
	[GroupId] int not null
);
go

insert into [GroupsCurators] values (1,8)
insert into [GroupsCurators] values (2,9)
insert into [GroupsCurators] values (3,10)

create table [GroupsLectures]
(
	[Id] int not null identity(1, 1) primary key,
	[GroupId] int not null,
	[LectureId] int not null
);
go

insert into [GroupsLectures] values (8, 1)
insert into [GroupsLectures] values (9, 2)
insert into [GroupsLectures] values (10, 3)
insert into [GroupsLectures] values (8, 2)



create table [Lectures]
(
	[Id] int not null identity(1, 1) primary key,
	[LectureRoom] nvarchar(max) not null check ([LectureRoom] <> N''),
	[SubjectId] int not null,
	[TeacherId] int not null
);
go

insert into [Lectures] values ('Room 1', 1, 1)
insert into [Lectures] values ('Room 2', 2, 2)
insert into [Lectures] values ('Room 3', 3, 3)

create table [Subjects]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N'')
);
go

insert into [Subjects] values ('History')
insert into [Subjects] values ('Ukrainian language')
insert into [Subjects] values ('English')




create table [Teachers]
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Salary] money not null check ([Salary] > 0.0),
	[Surname] nvarchar(max) not null check ([Surname] <> N'')
);
go

insert into [Teachers] values ('Anna', 25000, 'Semenovych')
insert into [Teachers] values ('Olga', 28000, 'Andriychuk')
insert into [Teachers] values ('Kostiantyn', 23000, 'Petrenko')


alter table [Departments]
add foreign key ([FacultyId]) references [Faculties]([Id]);
go

alter table [Groups]
add foreign key ([DepartmentId]) references [Departments]([Id]);
go

alter table [GroupsCurators]
add foreign key ([CuratorId]) references [Curators]([Id]);
go

alter table [GroupsCurators]
add foreign key ([GroupId]) references [Groups]([Id]);
go

alter table [GroupsLectures]
add foreign key ([GroupId]) references [Groups]([Id]);
go

alter table [GroupsLectures]
add foreign key ([LectureId]) references [Lectures]([Id]);
go

alter table [Lectures]
add foreign key ([SubjectId]) references [Subjects]([Id]);
go

alter table [Lectures]
add foreign key ([TeacherId]) references [Teachers]([Id]);
go

ALTER DATABASE Academy MODIFY NAME = Paniuk_Academy_New ;

-- 1. Вивести всі можливі пари рядків викладач, група
select T.Name, G.Name  
from Teachers T, Groups G, Lectures L, GroupsLectures GL
where T.Id = L.TeacherId and G.Id = GL.GroupId and L.Id = GL.LectureId

-- 2. Вивести назви факультетів, фонд фінансування кафедр яких перевищує фонд фінансування факультету
select F.Name as 'Faculty Name'
from Faculties F, Departments D
where F.Id = D.FacultyId and F.Financing>D.Financing

-- 3. Вивести прізвища кураторів груп і назви груп, які вони курують
select C.Surname as 'Curator Name', G.Name as 'Group Name'
from Curators C, Groups G, GroupsCurators GC
where C.Id = GC.CuratorId and G.Id=GC.GroupId

-- 4. Вивести імена і прізвища викладчів, які читають лекції в групі В-107
select T.Name+' '+T.Surname as 'Teacher full Name', G.Name as 'Group Name'
from Teachers T, Groups G,GroupsLectures GL, Lectures L
where T.Id = L.TeacherId and G.Id = GL.GroupId and L.Id = GL.LectureId and G.Name = 'Mathematic-5'

-- 5. Вивести прізвища викладачів і назви факультетів на яких вони читають лекції
select T.Surname as 'Teacher Surname', F.Name as 'Faculty Name'
from Teachers T, Faculties F, Groups G, Lectures L, GroupsLectures GL, Departments D
where T.Id = L.TeacherId and L.Id = GL.LectureId and G.Id = GL.GroupId and D.Id = G.DepartmentId and D.FacultyId = F.Id

-- 6. Вивести назви кафедр і назви груп, які до них відносяться
select D.Name as 'Department Name', G.Name as 'Group Name' 
from Departments D, Groups G
where D.Id = G.DepartmentId
order by D.Name

-- 7. Вивести назви дисциплін, який читає викладач "ПІБ"
select S.Name as 'Subject Name (Olga Andriychuk)'
from Subjects S, Teachers T, Lectures L
where S.Id = L.SubjectId and T.Id = L.TeacherId and T.Name='Olga'

-- 8. Вивести назви кафедр на яких читається дисципліна "Math"
select D.Name as 'Department Name (Subject History)'
from Departments D, Subjects S, Lectures L, GroupsLectures GL, Groups G
where S.Id = L.SubjectId and L.Id = GL.LectureId and G.Id = GL.GroupId and D.Id = G.DepartmentId and S.Name ='History'

-- 9. Вивести назви груп, які відносяться до факультету "Management"
select G.Name as 'Group Name'
from Groups G, Faculties F, Departments D
where G.DepartmentId = D.Id and F.Id = D.FacultyId and F.Name='Faculty of Management'

--10. Вивести назви груп 5-го курсу, а токож назви факультетів до яких вони відносяться
select G.Name as 'Group Name', F.Name as 'Faculty Name'
from Groups G, Faculties F, Departments D
where G.DepartmentId = D.Id and F.Id = D.FacultyId and G.Year=5

--11. Вивести повні імена викладачів і лекції, які вони читають (назва дисципліни і група) при чому
--відібрати тільки ті лекції, які читають в аудиторіїї "Room 2"
select T.Name+' '+T.Surname as 'Teacher full Name', S.Name as 'Subject Name', G.Name AS 'Group Name' 
from Teachers T, Subjects S, Groups G, Lectures L, GroupsLectures GL
where T.Id = L.TeacherId and S.Id = L.SubjectId and L.Id = GL.LectureId and G.Id = GL.GroupId and L.LectureRoom = 'Room 2'


select *from Curators
select *from Departments
select *from Faculties
select *from Groups
select *from GroupsCurators
select *from GroupsLectures
select *from Lectures
select *from Subjects
select *from Teachers