alter table Employee
add Phone varchar(12)
insert into Employee values ('Eddie', 'Eddie',23, '12/30/2019', ' tbrockelsby0@prweb.com', 26411.80,'Junior Executive','870-817-3420');
insert into Employee values ('Jacob', 'Eddie',33, '12/15/2019', 'sboullin1@un.org', 26780.20,'Help Desk Technician','581-622-4307' );
insert into Employee values ('Devan','Eddie',22, '8/10/2019', 'btaberner2@independent.co.uk', 5033.76 ,'Office Assistant III', '911-124-6457');
insert into Employee values ('Sandra', 'Eddie',30, '2/7/2020', 'ibromont3@tamu.edu', 23888.22,'Developer I','520-144-1955');
insert into Employee values ('Zacharia', 'Eddie',27, '7/5/2020', 'smattes4@geocities.com', 10398.26,'Financial Advisor','615-640-5495');
insert into Employee values ('Ruby', 'Eddie', 35,'11/16/2019', 'vgluyas5@wikimedia.org', 17377.60, 'Mechanical Systems','104-774-0858');
insert into Employee values ('Bernete','Eddie', 34,'6/27/2020', 'shosburn6@google.ru', 2304.23, 'Operator','918-188-7093');
insert into Employee values ('Kelci', 'Eddie', 29,'6/18/2020', 'bdwelley7@tinypic.com', 26317.43,'Paralegal','381-197-8077');
insert into Employee values ('Allys', 'Eddie', 28,'8/27/2019', 'oivison8@columbia.edu', 18581.24, 'Statistician I','627-591-0178');
insert into Employee values ('Wandie', 'Eddie', 36,'8/25/2019', 'kbyrom9@elpais.com',2364.08,'Junior Executive','283-337-3693');
select * from Employee
order by Salary Desc
exec sp_helplogins 'now'
create user now
exec sp_addrolemember 'db_datareader', 'now'
-- 
-- Виконуємо команду від імені іншого користувача бази даних
--
execute as user='now'
select * from Employee
order by Salary Desc
revert   -- повернутись до попереднього користувача (dbo)
--
-- default()
-- email()  -- axxxxxxx@xxx.com
-- random(start, end) -- 
-- partial(prefix, padding, suffix)
------
alter table Employee 
alter column Position add masked with (function='default()')
alter table Employee 
alter column Email add masked with (function='email()')
alter table Employee 
alter column Salary add masked with (function='random(999, 2000)')
alter table Employee 
alter column Phone add masked with (function='partial(0, "xxx-xx-xxx", 2)')
------
create user zaryshniuk
exec sp_addrolemember 'db_datareader', 'zaryshniuk'
------
execute as user='zaryshniuk'
select * from Employee
revert
------
-- Створили роль - група користувачів
create role Manager
-- Надали право на вибірку для ролі Менеджер
grant select on Employee to Manager
-- Додали користувачів в дану роль
exec sp_addrolemember 'Manager', 'zaryshniuk'
exec sp_addrolemember 'Manager', 'now'
--право переглядати незамасковані дані
--grant unmask
-- grant - дозволити
grant unmask to Manager
-- deny - заборонити переглядати незамасковані дані тільки юзеру Заришнюк
deny unmask to zaryshniuk
-- revoke - скинути права
revoke unmask to zaryshniuk
select T.name, M.name as columnName, masking_function 
                from sys.tables T Join
                     sys.masked_columns M On T.object_id = M.object_id
execute as user='zaryshniuk'
    update Employee
    Set Age = 18
    where Id = 11
revert
grant update on OBJECT::Employee to now
grant update(Age, Salary) on OBJECT::Employee to zaryshniuk
-- control = alter any mask, unmask
create user koziar
grant control on Employee to koziar
grant take  ownership on Employee to koziar
exec sp_addrolemember  'db_securityadmin','koziar'
--CREATE TABLE [Employee](
--  [ID] [int] IDENTITY(1,1) NOT NULL,
--  [Name] [nvarchar](20) NOT NULL,
--  [Surname] [nvarchar](30) NOT NULL,
--  [Age] [int] NULL,
--  [DateOfBirth] [date] NOT NULL,
--  [Email] [nchar](40) MASKED WITH (FUNCTION = 'email()') NULL,
--  [Salary] [money] MASKED WITH (FUNCTION = 'random(999, 2000)') NOT NULL,
--  [Position] [nvarchar](20) MASKED WITH (FUNCTION = 'default()') NOT NULL,
--  [Phone] [varchar](12) MASKED WITH (FUNCTION = 'partial(0, "xxx-xx-xxx", 2)') NULL,
--) 
--GO
