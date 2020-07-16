use Test
GO
select * from Employee
Go

-- DDL (create, drop, alter)
-- DML (insert, update, delete)

-- insert into table(...columns) values (...column values)  - вставляємо тільки визначений набір колонок
-- insert into table  values (...all column values)  - вставляємо всі колонки визначені структурою таблиці
insert into Employee(Name, Surname, Age, Position, Email) values(N'Аня', N'Богуцька', 25, 'Counter', 'ann@gmai.com'),
							(N'Олександр', N'Тимейчук', 30, N'Програміст', Null)
Go
insert into Employee values (N'Сергій', N'Паламарчук', '1997-5-5', 23 ,N'Архітектор', 25000,'ssss@gmail.com')
Go
delete from Employee  -- якщо деліт виконати без where - то видаляємо всі записи в таблиці, але не перезапускаємо ID
where Id = 12 Or Id = 13

Go
	truncate table Employee   -- очищення таблиці і перезапуск ID з 1
Go

Update Employee
Set DateofBirth = '1998-6-23'
Where DateofBirth is null
Go
-- Update - оновити таблицю Set - встанови поле в значення value   set column = value
Update Employee
Set Position = N'Архітектор',
 Age = 33
Where Position = 'Admin'
Go
-- Distinct - без повторень
-- Top - перших N рядочків
Select Distinct Top(2)  Position
From Employee
Order by Position Desc

/*
1) Select Position
	Distinct
	Order by
	Top
*/

Select Name, Age
From Employee
--Where Age >= 23 And Age <= 30
Where Age Between 24 And 30   -- діапазон (значення включаються (>= <=))

Select Name, Surname, Position
From Employee
--Where Position = 'Counter' Or Position = 'Admin'
Where Position In ('Counter', 'Admin')   -- входження в множину

Select * From Employee
Where Email is not null -- не пусті емейли

Select  * from Employee
Where Name Like N'[АаОо]%'

-- Like:  % - довільна к-сть символів
--        _  - один символ
--        [Variants (aAoO)]
--        %a    a%  a%o%a  (angora)
--        b%l_   (blablabla)