use master
go
drop database University
go

create database University
go
use University
Go


--create table Teachers(
--	Id int identity primary key,
--	FullName nvarchar(40) not null,
--	BirthDate date not null,
--	Department nvarchar(40) not null,
--	Phone varchar(15) not null,
--	[Group] nvarchar(10) not null,
--	Subject nvarchar(30) not null
--)
--go
--insert into Teachers (FullName, BirthDate, Department, Phone, [Group], Subject) values ('Estrellita Lamburn', '1/9/1984', 'Human Resources', '332-533-4692', N'ПУ924', 'C#');
--insert into Teachers (FullName, BirthDate, Department, Phone, [Group], Subject) values ('Penni Wildman', '1/3/1984', 'Support', '820-789-8026', N'ПУ824', 'C++');
--insert into Teachers (FullName, BirthDate, Department, Phone, [Group], Subject) values ('Calli Heindl', '8/13/1998', 'Marketing', '136-805-7593', N'ПУ924', 'DP');
--insert into Teachers (FullName, BirthDate, Department, Phone, [Group], Subject) values ('Pamella McGee', '2/9/1991', 'Product Management', '734-585-8195',  N'ПУ824', 'Math');
--insert into Teachers (FullName, BirthDate, Department, Phone, [Group], Subject) values ('Ham Wedderburn', '11/20/1974', 'Training', '982-642-3563', N'ПУ924', 'C++');
--insert into Teachers (FullName, BirthDate, Department, Phone, [Group], Subject) values ('Tonnie Mowsdale', '8/25/1986', 'Legal', '810-619-5969', N'ПУ924', 'Math');
--insert into Teachers (FullName, BirthDate, Department, Phone, [Group], Subject) values ('Hamlin Bonner', '1/6/1985', 'Support', '705-439-8203',  N'ПУ824', 'C#');
--insert into Teachers (FullName, BirthDate, Department, Phone, [Group], Subject) values ('Rex Lillee', '1/2/1982', 'Engineering', '869-848-8316',  N'ПУ824', 'DP');
--insert into Teachers (FullName, BirthDate, Department, Phone, [Group], Subject) values ('Bucky Dwyer', '8/27/1982', 'Services', '315-447-4737', N'ПУ924', 'TD');
--insert into Teachers (FullName, BirthDate, Department, Phone, [Group], Subject) values ('Elie Halden', '3/17/2000', 'Support', '597-190-9859',  N'ПУ724', 'TD');
--go

--select * from Teachers


create table Department(
	Id int identity primary key,
	Name nvarchar(30) not null unique,
	Phone nvarchar(15) not null unique
);
go
create table Groups(
	Id int identity primary key,
	Name nvarchar(10) not null unique,
	Id_Department int foreign key references Department(Id)
);
go
create table Teacher(
	Id int identity primary key,
	Name nvarchar(20) not null,
	Surname nvarchar(40) not null,
	BirthDate date not null check (BirthDate < getdate()),
	Id_Department int foreign key references Department(Id)
);

go
create table Subject(
	Id int identity primary key,
	Name nvarchar(30) not null unique,
	Id_Department int foreign key references Department(Id)
);
go
create table TeachersGroups(
	Id int identity primary key,
	IdTeacher int foreign key references Teacher(Id),
	IdGroup int foreign key references Groups(Id),
	IdSubject int foreign key references Subject(Id)
);
go

insert into Department values('Software Development', '123-456'),('Design', '789-012'),('Admin', '345-678')
go
insert into Groups values ('Pr123', 1),('Pr456', 1), ('Pr980', 1), ('D123', 2),('D456', 2), ('A123', 3)
go

insert into Teacher values ('Iryna', 'Mertsalova', '1992-11-14', 1),('Andrii', 'Trofimchuk', '1984-10-21', 3),
							('Valentyna', 'Benkalovych', '1991-10-12', 1), ('Igor', 'Pylypchuk', '1989-6-12', 2)
go
insert into Subject values ('C++', 1), ('C#', 1), ('DP', 1), ('Photoshop', 2), ('Illustrator', 2), ('security', 3), ('Network', 3)
go
insert into TeachersGroups values (1, 1, 1), (1, 2, 1), (2, 6, 7), (2, 1, 2), (4, 5, 4)
go
select* from Department
select * from Groups
select * from Teacher
select * from Subject
select * from TeachersGroups

-- Вибрати всі групи і назви кафедр, на яких вони розміщені
select G.Name as 'Group Name', D.Name as 'Department', Phone
from Groups G, Department D
where Id_Department = D.Id

-- Вибрати всіх викладачів, які працюють на кафедрі Розробки Програмного забезп.
select T.Name + ' ' + T.Surname as FullName, D.Name as Department
From Teacher T, Department D
Where  D.Name = 'Software Development' and T.Id_Department = D.Id

-- Вибрати всі предмети, які читають на кафедрі РПЗ і Адмінки
select S.Name as SubjectName, D.Name as Department
from Subject S, Department D
Where S.Id_Department = D.Id And D.Id in (1, 3)

-- Вивести всі дані, про вчителів, предмети та групи в яких вони викладають
select T.Name + ' ' + T.Surname as FullName, G.Name as Groups, S.Name as Subject 
From Teacher T, Subject S, Groups G, TeachersGroups TG
where TG.IdGroup = G.Id And TG.IdSubject = S.Id and TG.IdTeacher = T.Id

-- Вивести всі назви предметів і назви кафедр на яких викладає Андрій Трофімчук :)

Select T.Name + ' ' + T.Surname as FullName, S.Name as Subject, D.Name as Department
From Teacher T, Department D, Subject S, TeachersGroups TG
where TG.IdSubject = S.Id and TG.IdTeacher = T.Id and T.Id = 2  and S.Id_Department = D.Id

/*
-- якщо поле ID_Department існує, але не є зовнішнім ключем
alter table Teacher
add Foreign key(Id_Department) References Department(Id)

-- у видку, коли треба створити поле і зробити зовнішнім ключем
alter table Teacher
add Id_Subject int foreign key references Subject(Id)

*/