create database Paniuk_Sport_Shop

use Paniuk_Sport_Shop

create table Category
(ID int primary key identity,
 CategoryName nvarchar(50) not null check(CategoryName<>'') 
)

insert into Category values ('Clothes')
insert into Category values ('Footwear')
insert into Category values ('Inventory for games')
insert into Category values ('Simulators')
insert into Category values ('Boxing equipment')

create table Supplier
(ID int primary key identity,
SupplierName nvarchar(50) not null check(SupplierName<>'')
)

insert into Supplier values ('Adidas')
insert into Supplier values ('Nike')
insert into Supplier values ('Asics')
insert into Supplier values ('Reebok')
insert into Supplier values ('Puma')
insert into Supplier values ('New Balance')
insert into Supplier values ('Deha')


--1.1 Product
create table Product
(ID int primary key identity,
ProductName nvarchar(50) not null check(ProductName<>'') unique,
CategoryID int foreign key references Category(ID),
Quantity int check (Quantity >=0),
Cost money not null check (Cost>0),
SupplierID int foreign key references Supplier(ID),
Price money not null check (Price<>''),
)

insert into Product values ('Sneakers', 2, 10, 3500, 1, 4300)
insert into Product values ('Tracksuit', 1, 12, 800, 2, 1400)
insert into Product values ('Racetrack', 4, 3, 6000, 4, 8000)
insert into Product values ('Ball',3, 25, 50, 4, 100)

select *from Product
update Product
set Quantity = 50
where ProductName='Tracksuit'

--1.3 Employee
create table Employee
(
ID int primary key identity,
FirstName nvarchar(30) not null,
LastName nvarchar(30) not null,
Position nvarchar(30) not null,
EmploymentDate date not null check(EmploymentDate>'01.01.1990'),
Gender nvarchar (30) not null,
Salary money not null check(Salary>=0),
)

insert into Employee values ('Anna', 'Petrenko', 'Seller', '2018-06-05', 'woman', 25000)
insert into Employee values ('Lesia', 'Kovalchuk', 'Seller', '2014-01-08', 'woman', 27000)
insert into Employee values ('Andry', 'Rudyi', 'Seller', '2013-08-08', 'man', 27000)


--1.4 Customer
create table Customer
(
ID int primary key identity,
FirstName nvarchar(30) not null,
LastName nvarchar(30) not null,
Email nvarchar(30) not null unique,
Gender nvarchar (30) not null,
Discount int not null check (Discount>=0),
Newsletter bit not null
)

insert into Customer values ('Luidmyla', 'Makarenko', 'Makarenko@gmail.com', 'woman', 10, 1)
insert into Customer values ('Olga', 'Pylypenko', 'Pylypenko@gmail.com', 'woman', 10, 1)
insert into Customer values ('Sergiy', 'Ostapchuk', 'Ostapchuk@gmail.com', 'man', 20, 1)



go
create table Sale
(
ID int primary key identity,
ProductID int foreign key references Product(ID),
Unit int not null  check(Unit >0),
Price money not null check(Price>0),
DatePurchase date not null check(DatePurchase<>''),
CustomerID int foreign key references Customer(ID),
EmployeeID int foreign key references Employee(ID),
)
go

truncate table Sale
drop table Sale


insert into Sale values (1, 1, 4300, '2020-03-18', 1, 1)
insert into Sale values (2, 2, 1400, '2020-05-20', 3, 2)
insert into Sale values (1, 2, 4300, '2020-05-20', 6, 2)
insert into Sale values (3, 3, 8000, '2020-04-05', 3, 3)

select *from Category
select *from Customer
select *from Employee
select *from Product
select *from Sale
select *from Supplier

delete from Product
where ID=9

--1. При продажі товару заносити інформацію про продаж в таблицю "Історія".
-- Використовується для дубляжу інформації про всі продажі
create table History 
(
    ID int primary key identity,
    ProductID int not null,
    Unit int not null,
    Price money not null check(Price>0), 
  	DatePurchase date not null,
	CustomerID int not null,
	EmployeeID int not null, 
    CreateAt datetime not null default GETDATE(),
);

drop table History

go
alter trigger onInsertSale
on Sale
after insert
as
insert into History (ProductID, Unit, Price, DatePurchase, CustomerID, EmployeeID)
select ProductID, Unit, Price, DatePurchase, CustomerID, EmployeeID
from inserted

select *from Product
select *from Sale
insert into Sale values (1, 1, 4300, '2016-02-05', 3, 1)
insert into Sale values (1, 48, 4300, '2018-02-05', 3, 1)
select *from History

go



--2. !!!!!!!!!!!!!! Якщо після продажі товару не лишилося жодної одиниці, необхідно перенести інформацію
--про товар в таблицю "Архів"
create table Archive 
(
    ID int primary key identity,
    ProductID int not null,
	
);

truncate table Archive

go

alter trigger onUpdateProductQuantity
on Sale
for insert
as
declare @x INT, @y INT, @z int
IF @@ROWCOUNT=1
--в таблицу Сделка добавляется запись о поставке товара
BEGIN
--количество проданного товара должно быть не меньше, чем его остаток из таблицы Product
if not exists(select *
              from inserted I
              where -I.Unit <=ALL( select P.Quantity
                                   from Product P, Sale S
                                   where P.ID = S.ProductID)
			  )
    begin
       rollback tran
         print 'Товара нет '
		 
     end

begin
    select @z =P.Quantity 
	from Product P

	if @z<=0
	begin
		insert into  Archive (ProductID)
		select ID
        from Product
	end
end

	

--если запись о товаре уже была в таблице Product, то определяется код и количество товара издобавленной в таблицу Sale записи
  begin
    select @y=I.ProductID, @x=I.Unit
    from Sale S, inserted I
    where S.ProductID=i.ProductID
--и производится изменения количества товара в таблице Product
         update Product
         set Quantity=Quantity-@x
         where ID=@y
    end
end



go

insert into Sale values (12, 50, 700, '2020-02-05', 3, 1)
select *from Archive
select *from Product
select *from Sale
select *from Customer


select *from Product
update Product
set Quantity = 50
where ProductName='Ball'

go



--3. Не дозволяти реєстрацію вже існуючого клієнта. Перевіряти ПІБ і email
go
alter trigger onInsertCustomer
on Customer 
instead of insert
as
if exists(select * from Customer, inserted where inserted.LastName = Customer.LastName
                                             and inserted.FirstName = Customer.FirstName
												 and inserted.Email = Customer.Email)
	begin
		print 'Such a user already exists in the database'
		rollback tran
	end
else insert into Customer 
					select FirstName, LastName, Email, Gender, Discount, Newsletter from inserted
go
select * from Customer
insert into Customer values ('Luidmylart', 'Makarenrkot', 'Makarernko2t22@gmail.com', 'woman', 15, 0)
go

--4. Заборонити видалення існуючих клієнтів
alter trigger onDeleteCustomer
on Customer
for Delete
as
begin
	declare @id int
	select @id = ID from deleted
	if @id != 0
	   begin
		rollback transaction
		print 'You cannot delete an existing client'
        end
end
	
delete from Customer
where FirstName = 'Olga'

go

--5. Заборонити видалення співробітників, прийнятих після 2015 року
go
create trigger onDeleteEmployee
on Employee
for Delete
as
begin
	declare @date date
	select @date = EmploymentDate from deleted
	if year(@date) > 2015
	        begin
	 		rollback transaction
			print 'You cannot delete employees hired after 2015'
			end
	else
		print 'Operation delete completed successfully'
end

delete from Employee
Where EmploymentDate = '2018-06-05'
go


--6. !!!!!!!!!!!!!!!! При новій покупці товару перевіряти загальну суму покупки клієнта. 
--Якщо сума перевищила 50000 - встановлюємо знижку 15%


--7. Заборонити добавляти товар конкретної фірми
go
create trigger onInsertProduct
on Product
for insert
as
	begin
	    declare @id int
		select @id = SupplierID from inserted
		if @id = 6
			begin
				Print 'You cant add into product supplier New Balance'
				rollback
			end
	end

insert into Product values ('Booties', 2, 5, 800, 6, 1400)
go




--8. !!!!!!!!!!!!!!! При продажу перевіряти кількість товарів на залишку.
-- Якщо лишилася одна одиниця, необхідно внести інформацію про цей товар в таблицю "Остання одиниця"

