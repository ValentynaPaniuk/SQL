-- Sport Shop
-- ��� ��� �����, ������ ���� ����� �� ���� ����� ���� �� ������
sp_helplogins

use Paniuk_Sport_Shop
use master
--1.1 ������ ������ �� ��  �� �������� � ���������
create login director --��������
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

--
create user director
for login director

exec sp_addsrvrolemember 'director', 'sysadmin'


create login deputydirector --������� ���������
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

create user deputydirector
for login deputydirector

exec sp_addsrvrolemember 'deputydirector', 'sysadmin'

------------------------------------------------------------
--1.2 �������� ����� ������ �� �������/����� ����� �� ���������� ��� �����


create login  Nastia --���������
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

create user Nastia
for login Nastia


create login  Maxym --���������
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

create user Maxym
for login Maxym

create login  George  --���������
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

create user George
for login George


create login Vera  --���������
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master


create user Vera
for login Vera

create login  Rick  --���������
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

create user Rick
for login Rick


-- �������� ���� - ����� ������������
create role Seller

-- ������ ����� �� ������ ��� ��� Seller � Product
grant select on Product to Seller
grant select on Employee to Seller

-- ������ ������������ � ���� ����
exec sp_addrolemember 'Seller', 'Maxym'
exec sp_addrolemember 'Seller', 'George'
exec sp_addrolemember 'Seller', 'Vera'
exec sp_addrolemember 'Seller', 'Rick'
exec sp_addrolemember 'Seller', 'Nastia'



--������� ���� FirstName, LastName � ������� Employee
alter table Employee 
alter column FirstName add masked with (function='default()')

alter table Employee 
alter column LastName add masked with (function='default()')

--���� ����� ��� ��� Seller ������ ����������� ���
grant unmask to Seller


--������������ ������� dynamic data masking ��� ����������� ������� �����
--��� ϲ� ��������� ����������� � ������� ������, ������, º��, ���
-- ����������� ����������� ������������ ��� ����� ����� ������, ������, º��, ���
deny unmask to Maxym
deny unmask to George
deny unmask to Vera
deny unmask to Rick

-- �������� ������� �� ���� ������ ����������� ���� �����

execute as user='Maxym'
select * from Employee
revert

---------------------------------
--1.3 ��������� �� ������ ���� �� ���������� ��������

create login accountant --���������
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
--1.1 ������ ������ �� ���� ������� ��������
exec sp_addsrvrolemember 'paniuk', 'sysadmin' -- ������ ������ �� ��


--1.2 � ��������� ����� ������������, ��� ���� ���������� ���������� �� ��, ��� ����� ���
create login  Olga
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

create user Olga
for login Olga


create role Customer
exec sp_addrolemember 'db_datareader', 'Customer' -- ��������� ���� �������� �� ��� ���

exec sp_addrolemember 'Customer', 'Olga'

execute as user='Olga'
select * from Disk
revert

--1.3 � ����� ������������, ��� �� ����� ���������� ���������� ���� �� ������� ����
create login  Oleg
with password ='Qwerty-1'
must_change,
check_expiration = ON,
default_database = master

create user Oleg
for login Oleg


create role Customer_Style

exec sp_addrolemember 'Customer_Style', 'Oleg'

grant select on Style --��������� ���������� ���������� ���� �� ������� ����
to Customer_Style



--error
execute as user='Oleg'
select * from Disk
revert
--good
execute as user='Oleg'
select * from Style
revert