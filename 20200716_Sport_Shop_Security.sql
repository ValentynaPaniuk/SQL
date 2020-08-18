-- Sport Shop
-- Звіт про логіни, показує бази даних до яких кожен логін має доступ
sp_helplogins

use Paniuk_Sport_Shop
use master
--1.1 Повний доступ до БД  має директор і заступник
create login director --директор
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

--
create user director
for login director

exec sp_addsrvrolemember 'director', 'sysadmin'


create login deputydirector --замісник директора
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

create user deputydirector
for login deputydirector

exec sp_addsrvrolemember 'deputydirector', 'sysadmin'

------------------------------------------------------------
--1.2 Продавці мають доступ на читання/запис тільки до інформації про товар


create login  Nastia --продавець
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

create user Nastia
for login Nastia


create login  Maxym --продавець
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

create user Maxym
for login Maxym

create login  George  --продавець
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

create user George
for login George


create login Vera  --продавець
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master


create user Vera
for login Vera

create login  Rick  --продавець
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

create user Rick
for login Rick


-- Створили роль - група користувачів
create role Seller

-- Надали право на вибірку для ролі Seller і Product
grant select on Product to Seller
grant select on Employee to Seller

-- Додали користувачів в дану роль
exec sp_addrolemember 'Seller', 'Maxym'
exec sp_addrolemember 'Seller', 'George'
exec sp_addrolemember 'Seller', 'Vera'
exec sp_addrolemember 'Seller', 'Rick'
exec sp_addrolemember 'Seller', 'Nastia'



--шифруємо поля FirstName, LastName в таблиці Employee
alter table Employee 
alter column FirstName add masked with (function='default()')

alter table Employee 
alter column LastName add masked with (function='default()')

--Даємо дозвіл для ролі Seller бачити розшифровані дані
grant unmask to Seller


--Використайте механізм dynamic data masking для відображення змінених даних
--про ПІБ продавців користувача з логінами Максим, Георгій, Вєра, Рик
-- Забороняємо переглядати незамасковані дані тільки юзерів Максим, Георгій, Вєра, Рик
deny unmask to Maxym
deny unmask to George
deny unmask to Vera
deny unmask to Rick

-- Виконуємо команду від імені іншого користувача бази даних

execute as user='Maxym'
select * from Employee
revert

---------------------------------
--1.3 Бухгалтер має доступ лише до інформації Персонал

create login accountant --бухгалтер
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master


create user accountant
for login accountant


grant select on Employee
to accountant
----------------------------------------------------
----------------------------------------------------

--Music Collections
use Paniuk_MusicCollection
--1.1 Повний доступ має лише власник колекції
exec sp_addsrvrolemember 'paniuk', 'sysadmin' -- повний доступ до БД


--1.2 Є фіксована група користувачів, яка може отримувати інформацію із БД, без права змін
create login  Olga
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

create user Olga
for login Olga


create role Customer
exec sp_addrolemember 'db_datareader', 'Customer' -- дозволити лише перегляд БД без змін

exec sp_addrolemember 'Customer', 'Olga'

execute as user='Olga'
select * from Disk
revert

--1.3 Є група користувачів, яка має право отримувати інформацію тільк із таблиці Стилі
create login  Oleg
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

create user Oleg
for login Oleg


create role Customer_Style

exec sp_addrolemember 'Customer_Style', 'Oleg'

grant select on Style --дозволити отримувати інформацію тільк із таблиці Стилі
to Customer_Style



--error
execute as user='Oleg'
select * from Disk
revert
--good
execute as user='Oleg'
select * from Style
revert