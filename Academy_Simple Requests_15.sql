use Paniuk_Academy

drop table Teachers

create table Teachers
(
ID int primary key identity,
EmploymentDate date not null check(EmploymentDate>'01.01.1990'),
IsAssistant bit not null default(0),
IsProfessor bit not null default(0),
Name nvarchar(max) not null check(Name<>''),
Position nvarchar(max) not null check(Position<>''),
Premium money not null check(Premium>=0) default(0),
Salary money not null check(Salary>=0),
Surname nvarchar(max) not null check(Surname<>''),
);

Insert into Teachers values ( '01.12.1998', 0,1,'Igor Petrovych', 'Professor', 2000, 25000, 'Kondratuik' ),
                             ( '01.12.2000', 1, 0,'Ivan Olecksiyovych','Assistant', 2500, 27000, 'Pozniakovskiy' ),
						     ( '01.12.2003', 0,1, 'Iryna Evhenivna','Professor' ,2800, 28000, 'Ruda' )

							 
Insert into Groups values ( 'MO-2', 4, 3),
                          ( 'FL-3',5, 4),
						  ( 'Math-1', 4,5)

select *from Departments
select *from Faculties
select *from Groups
select *from Teachers

truncate table Groups

--1. Вивести таблицю кафедр, але розмістити її в оберненому порядку
select *from Departments
select D.Name as 'Department Name'
from Departments D
order by D.Name Desc

--2. Вивести назви груп і рейтинг, використовуючи в якості назва "Group Name" і "Group Rating" відповідно
select *from Groups
select G.Name as 'Group Name', G.Rating as 'Group Rating'
from Groups G

--3. Вивести для викладачів їх прізвище, % ставки по відношенню до надбавки і відношення ставки по відношенню до ЗП(сумма ставки і надбавка)
select *from Teachers
select T.Surname as 'Teacher Surname', (T.Salary/T.Premium)*100 as 'S/P*100, %', (T.Salary/(T.Salary+T.Premium))*100 as 'S/(S+P)*100, %'
from Teachers T

--4. !!!!!!!!!!!!!!!! Вивести таблицю факультетів в вигляді одного поля в наступному форматі:
 -- "The dean of faculty [faculty] is [dean]"

--5. Вивести прізвища викладачів, що є професорами і ставка яких перевищує 1050
select *from Teachers
select T.Surname as 'Teacher Surname'
from Teachers T
where T.IsProfessor=1 and T.Salary>1050

--6. Вивести назву кафедр, фонд фінансування яких менше 11000 і більше 25000
select *from Departments
select D.Name as 'Department Name'
from Departments D
where D.Financing<11000 or D.Financing>25000

--7. Вивести назви факультетів крім факультету 'Managment'
select *from Departments
select D.NAme as 'Department Name'
from Departments D
where D.Name != 'Managment'

--8. Вивести прізвища і посади викладачів, що не є професорами
select *from Teachers
select T.Name+' '+T.Surname as 'Full Name'
from Teachers T
where T.IsProfessor = 0

--9. Вивести прізвища, посади, ставки і надбавки асистентів, у яких надбавка в діапазоні від 2100 до 2600
select *from Teachers
select T.Surname as 'Surname', T.Salary as 'Salary', T.Premium as 'Premium'
from Teachers T
where T.Premium between 2100 and 2600

--10. Вивести фамілії і ставки асистентів
select *from Teachers
select T.Name+' '+T.Surname as 'Full Name'
from Teachers T
where T.IsAssistant = 1

--11. Вивести прізвища і посади викладачів, які були прийняті на роботу 12.01.2000
select *from Teachers
select T.Name+' '+T.Surname as 'Full Name', T.Position as 'Position'
from Teachers T
where T.EmploymentDate='2000-01-12'

--12. Вивести назви кафедр, які в алфавітному порядку розміщуються до кафедри "Management"
-- Стовпчик, де будуть виводитися дані назвати 'NameOfDepartment'
select *from Departments
select D.Name as 'NameOfDepartment'
from Departments D
where D.Name like '[Aa]%' or D.Name  not like '[Mm]%'
order by D.Name

 
--13. Вивести прізвища асистентів, що мають ЗП(ЗП+надбавка) не більше 29500
select *from Teachers
select T.Name+' '+T.Surname as 'Full Name', T.Position as 'Position'
from Teachers T
where T.Salary+T.Premium>=29500 and T.IsAssistant=1

--14. Вивести назви груп 5-го курсу, що мають рейтинг в діапазоні від 2 до 4
select *from Groups
select G.Name as 'Group Name', G.Rating as 'Group Rating'
from Groups G
where G.Rating between 2 and 4 and G.Year=5

--15. Вивести фамілії асистентів зі ставками більше 26000 або назбавкою менше 2000
select *from Teachers
select T.Surname as 'Teacher Surname'
from Teachers T
where T.IsAssistant=1 and (T.Salary>26000 or T.Premium>2000)



