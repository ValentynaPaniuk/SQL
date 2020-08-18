
---------------------------------------------------------
-----------------------   Trigger -----------------------
---------------------------------------------------------
go
use Paniuk_Travel_Agency
go
--1. При удалении прошедших туров необходимо переносить их в архив туров
go
create table ArchiveTure 
(
ID int primary key identity,
TurName nvarchar(50) not null,
Cost money not null, 
StartDate date not null ,
EndDate date not null ,
TransportID int not null,
);
go
truncate table ArchiveTure

go
create trigger onDeleteTur
on Tur
for delete
as
insert into ArchiveTure (TurName, Cost, StartDate, EndDate, TransportID)
select TurName, Cost, StartDate, EndDate, TransportID
from deleted
go

select *from Tur
select *from ArchiveTure

delete from Tur
Where StartDate = '2020-06-06'
go

go

--2. При вставке нового клиента нужно проверять, нет ли его уже в базе данных.
--Если такой клиент есть, генерировать ошибку с описанием возникшей проблемы
go
create trigger onInsertCustomer
on Customer 
instead of insert
as
if exists(select * from Customer, inserted where inserted.FullName = Customer.FullName
											 and inserted.Phone = Customer.Phone
                                             and inserted.Email = Customer.Email)
	begin
		print 'Such a user already exists in the database'
		rollback tran
	end
else insert into Customer 
					select FullName, Phone, Email
					from inserted
go
select * from Customer
insert into Customer values ('Alla Sulzhuk','098-222-26-20', 'sulzhuk@gmail.com')
go

--3. При добавлении нового туриста в тур проверять не достигнуто ли уже максимальное количество. 
--Если максимальное количество достигнуто, генерировать ошибку с информацией о возникшей проблеме

use Paniuk_Travel_Agency
go
alter trigger onInsertTurCustomer
on TurCustomer
instead of insert
as
 -- кількість рядків, що були 
begin
  --if not exists(select *
  --              from inserted
  --              having count(inserted.CustomerID)>all(select Tur.MaxCountCustomer
  --                                                    from TurCustomer,Tur
  --                                                    where Tur.ID= TurCustomer.TurID))
  --  begin
  --    rollback tran
  --    print 'The number of tourists in the group has been exceeded'
  --  end

  -- Кількість що додаю
  declare @countinsert int
  select @countinsert = count(inserted.CustomerID)
                  from inserted
				  Print @countinsert
declare @id int = (select TurID from inserted)
print @id
--Кількість, що вже є в турі
declare @count int
select @count = count(TC.CustomerID)
from TurCustomer TC join Tur T on TC.TurID=T.ID 
Where TC.TurID = @id
Print @count

if @countinsert+@count > any(select T.MaxCountCustomer
                          from Tur T, TurCustomer TC
						  where T.ID=TC.TurID and TC.TurID = @id)
						  begin
							  rollback tran
							  print 'The number of tourists in the group has been exceeded'
						  end



	else
	insert into TurCustomer select I.TurID, I.CustomerID, I.Paid from inserted I
end

select *from Tur
select *from Customer
select *from TurCustomer
insert into TurCustomer values (9,1,1)
insert into TurCustomer values (9,2,1)
insert into TurCustomer values (9,3,1)
insert into TurCustomer values (9,4,1)
insert into TurCustomer values (9,5,1)
insert into TurCustomer values (9,6,1)
insert into TurCustomer values (9,7,1)
insert into TurCustomer values (9,8,1)
insert into TurCustomer values (9,9,1)
insert into TurCustomer values (9,10,1)
insert into TurCustomer values (9,11,1)

insert into TurCustomer values (4,11,1)


---------------------------------------------------------
-----------------------   Security ----------------------
---------------------------------------------------------

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
