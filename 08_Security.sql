use University
​
select * from sysobjects
order by crdate desc
​
select * from sys.objects
​
select * from sys.columns
​
select * from sys.indexes
​
select * from sys.tables
​
-- створити логін для входу
create login ivan
with password = 'Qwerty-1'
must_change,
check_expiration = ON,
default_database = master
​
​
create login [itstep\test]
from windows
​
-- Звіт про логіни, показує бази даних до яких кожен логін має доступ
sp_helplogins
​
grant connect to guest
​
create user now
for login now
​
grant select on Student
to now
​
exec sp_addsrvrolemember 'now', 'sysadmin'
​
