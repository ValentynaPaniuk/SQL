select * from TeachersGroups
select * from Teacher


update TeachersGroups
set IdTeacher=3 
where IdTeacher is Null

delete from Teacher
where Id = 3

create table Student(
	Id int identity primary key,
	Name nvarchar(20),
	Surname nvarchar(30),
	IdGroup int foreign key references Groups(Id)
);
Go
create table Achievement (
	Id int identity primary key,
	IdStudent int foreign key references Student(Id),
	IdSubject int foreign key references Subject(Id),
	Mark int check (Mark between 1 and 12)
)
Go
select * from Groups
select * from Subject
insert into Student values('Katia', 'Marchuk', 1),
						('Ann', 'Zabuzhko', 1),
						('Roma', 'Zaluzhnyi', 2),
						('Serhii', 'Denyshchuk', 3),
						('Anatoliy', 'Popchuk', 3),
						('Viktor', 'Palamarchuk', 6),
						('Valia', 'Paniuk', 6)

insert into Achievement values (1, 1, Null),
								(1, 2, 6),
								(1, 3, 10),
								(2, 1, 10),
								(2, 2, Null),
								(2, 3, 8),
								(3, 1, 6),
								(3, 2, 12),
								(3, 3, Null)

select * from Achievement
select * from Student

insert into Student (Name, Surname, IdGroup) 
select Surname, Name, IdGroup from Student
where Name Like '[Vv]%'

-- Агрегуючі функції: Count(column_name), Avg(column_name), Min(column_name), Max(column_name), Sum(column_name)

-- Знайти к-сть студентів, в яких імена розпочинаються на літеру V
select count(*) 'Count Students'
from Student
where Name like '[Vv]%'

-- Знайти к-сть студ. які навчаються в групі Pr123
select count(S.Id) [Stud in Pr123]
from Student S, Groups G
where S.IdGroup = G.Id And G.Name='Pr123'

insert into Achievement values (1, 4, Null)

-- 
-- Порахувати к-сть студентів, в яких є нездані предмети (NUll у таблиці Achievement)
select count(distinct A.IdStudent)
from Achievement A, Student S
where A.IdStudent = S.Id And A.Mark is Null

-- 
-- avg ignore null
select avg(Mark) as avg_mark
from Achievement

-- знайти середню оцінку студента 1 (Катя Марчук)
select avg(Mark)  Avg_Mark
From Achievement A
where A.IdStudent = 1

-- середня оцінка з предмету С#
select avg(Mark) 'Avg C#'
From Achievement A, Subject S
Where A.IdSubject=S.Id And S.Name='C#'


-- Максимальна оцінка з предмету DP
select max(Mark) 'Max DP'
From Achievement A, Subject S
Where A.IdSubject=S.Id And S.Name='DP'

-- min mark in Group A123
select min(Mark) as MinMark
from Achievement A, Groups G, Student S
where S.IdGroup = G.Id And A.IdStudent = S.Id And G.Name = 'Pr123'

-- Наймолодший вчитель та найстарший
select max(DATEDIFF(year, BirthDate,  getdate())) as 'Найстарший', min(DATEDIFF(year, BirthDate,  getdate())) as 'Наймолодший'
From Teacher

select Sum(Mark) as SumaMark
From Achievement

-- Вибрати к-сть студентів в кожній групі
select G.Name, G.Id_Department, count(S.Id)
From Student S, Groups G
where S.IdGroup = G.Id
Group by G.Name, G.Id_Department
