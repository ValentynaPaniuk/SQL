use Paniuk_Travel_Agency
-- Звіт про логіни, показує бази даних до яких кожен логін має доступ
sp_helplogins
--Продумайте систему безопасности. Обязательные требования к ней:
--■ Пользователь с полным доступом ко всей информации (директор турагентства)
go
create login director_TA_Paniuk --директор
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master
go
--
create user director_TA_Paniuk
for login director_TA_Paniuk
--даємо права адміна на сервер
exec sp_addsrvrolemember 'director_TA_Paniuk', 'sysadmin'

--даємо права адміна на БД
create role Director
exec sp_addrolemember 'Director', 'director_TA_Paniuk'
exec sp_addrolemember 'db_owner', 'Director' 


--■ Пользователи с доступом на чтение информации о странах и турах
--Створити роль
create role Customer
--створити users для БД
create user Nastia for login Nastia
create user Maxym  for login Maxym
create user George for login George
create user Vera   for login Vera
create user Rick   for login Rick
--Додати доступ на перегляд
grant select on Country to Customer
grant select on Tur to Customer
grant select on TurCity to Customer
grant select on CityHotel to Customer
grant select on CityPlace to Customer
grant select on Place to Customer
grant select on City to Customer


-- Додали користувачів в дану роль
exec sp_addrolemember 'Customer', 'Maxym'
exec sp_addrolemember 'Customer', 'George'
exec sp_addrolemember 'Customer', 'Vera'
exec sp_addrolemember 'Customer', 'Rick'
exec sp_addrolemember 'Customer', 'Nastia'

execute as user='Maxym'
select * from Country
revert

--■ Пользователь с правом резервного копирования и восстановления данных
create role Employee
create user accountant for login accountant
exec sp_addrolemember 'Employee', 'accountant'

exec sp_addrolemember 'db_backupoperator', 'Employee' -- дозволити робити backup БД

--■ Пользователь с правом создания и удаления пользователей 
exec sp_addrolemember 'db_securityadmin', 'Employee' 
-- Эта роль предоставляет право управлять разрешениями, владельцами, и ролями - но только для тех логинов, которым уже был предоставлен доступ к базе данных. 
exec sp_addrolemember 'db_securityadmin', 'Employee'

--■ Другие пользователи.
create role Other
exec sp_addrolemember 'db_datareader', 'Other'
create user denyshchuk for login denyshchuk
exec sp_addrolemember 'Other', 'denyshchuk'
