-- Create Function
--1.1. що повертає текст "Hello, name". Ім'я задається в параметрі
go
create function fn_ShowText(@name nvarchar(20))
returns nvarchar(20)
begin
declare @new_name nvarchar(20)
set @new_name = @name
return @name
end
go

declare @res  nvarchar(20)
exec @res = fn_ShowText 'Valia'
print 'Hello, '+ @res


go
CREATE FUNCTION fn_hello_name(@name nvarchar(10))
returns nvarchar(100)
as
  begin
    return 'Hello' + ' ' + @name
  end
go

select dbo.fn_hello_name('Bill')

--1.2. Повертає інформацію про кількість хвилин
go
create function fn_ShowMinute()
returns nvarchar(20)
begin
declare @res nvarchar(20)
 set @res = DATEPART (MINUTE, GetDate())
 return @res
end
go

declare @res  nvarchar(20)
exec @res = fn_ShowMinute
print 'Minute = >' + @res

--1.3. Повертає інформацію про рік
go
create function fn_ShowYear()
returns nvarchar(20)
begin
  declare @res nvarchar(20)
  set @res = DATEPART (YEAR, GetDate())
  return @res
end
go

declare @res  nvarchar(20)
exec @res = fn_ShowYear
print 'Year => ' + @res

--1.4. Повертає інформацію про парний чи не парний рік
go
create function fn_OddOrEvenYear(@year int)
returns nvarchar(10)
as
begin
	if(@year % 2 = 0)
		return 'ODD'
	return 'EVEN'
end
go

select dbo.fn_OddOrEvenYear(year(getdate()))

--1.5. Функція приймає число і повертає "Yes", якщо воно просте і "No" якщо не просте
go
create function fn_SimpleDigitOrNotSimple (@digit INT)
returns nvarchar(20)
as
  begin
    declare @counter INT = 0
    declare @i INT = 1
    while(@i != @digit)
      begin
        if(@digit % @i = 0)
            set @counter = @counter + 1 
        set @i = @i + 1
      end

    if(@counter < 2)
      return 'Simple'
    else 
      return 'Not simple'

    return ''
  end
go

select dbo.fn_SimpleDigitOrNotSimple(4)

--1.6. Приймає в параметрах 5 чисел. Повертає суму мінімального і максимального з цих чисел
go
alter function fn_ReturnMinAndMax(@first INT, @second INT, @third INT, @fourth INT, @fifth INT)
returns @table table (SumMinMax INT)
as
begin
	declare @tempTable table ([Value] INT)
	insert into @tempTable values (@first), (@second), (@third), (@fourth), (@fifth)

	insert into  @table select MIN(Value)+MAX(Value) from @tempTable
	
	return

end
go

select * from dbo.fn_ReturnMinAndMax(2, 20, 31, 2, 4)

--1.7. Повертає всі парні і непарні числа в переданому діапазоні 
go
alter function fn_ShowDiapason(@from INT, @to INT, @mode BIT)
returns @table table (Number INT)
as
begin
	declare @iterator int = @from

	if(@mode = 1)
		begin
			while (@iterator <= @to)
				begin
					if(@iterator % 2 = @mode)
						insert into @table values(@iterator)
					set @iterator = @iterator + 1
				end
		end
	else
		begin
			while (@iterator <= @to)
				begin
					if(@iterator % 2 = @mode)
					begin
						insert into @table values(@iterator)
					end
					set @iterator = @iterator + 1
				end
		end

	return
end
go

Select * FROM dbo.fn_ShowDiapason(5, 101, 0)





use Paniuk_Sport_Shop
select *from Category
select *from Customer
select *from Employee
select *from Product
select *from Sale
select *from Supplier

--2.1. Повертає мінімальну продаж конкретного продавця. Прізвище продавця передається в параметрах
go
alter function fn_ShowMinimumSellersSale(@nameEmployee nvarchar(20))
returns table
as
 return (select Min  (S.Unit* S.Price) as 'Sale'
         from Sale S join Employee E on S.EmployeeID = E.ID
		 where E.FirstName=@nameEmployee)
go

select *
from fn_ShowMinimumSellersSale('Lesia')

--2.2. Мінімальну покупку конкретного покупця. Прізвище покупця передається в параметрах
go
alter function fn_ShowMinimumCustomerSale(@nameCustomer nvarchar(20))
returns table
as
 return (select min (S.Unit * S.Price) as 'Sale'
         from Sale S join Customer C on S.CustomerID = C.ID
		 where C.FirstName=@nameCustomer)
go

select *
from fn_ShowMinimumCustomerSale('Sergiy')

select *from Customer
select *from Sale

--2.3. Повертає загальну суму продажу за конкретну дату. Дата предається в параметрах
go
alter function fn_AllSalesByOneDay (@date date)
returns money
as
begin
    return (select sum (S.Price*S.Unit) as 'Summa'
            from Sale S
		    where S.DatePurchase = @date)
end
go

select *from Sale
SELECT dbo.fn_AllSalesByOneDay('2020-05-20')

--2.4. Повертає дату, коли загальна сума продаж за конкретний день була максимальна
go
alter function fn_ShowMaxSales()
returns @table table (date date, sum money)
as
begin
	insert into @table
	                 select DatePurchase, sum from (select S.DatePurchase, Sum(S.Price*S.Unit) as SUM 
	                               from Sale S
							       group by DatePurchase) as SourseTable
	                               where sum = (select max(sum) 
								                from (select sum(S.Price*S.Unit) as sum 
												      from Sale S
													  group by DatePurchase) as SourseTable)
	return
end
go

SELECT * FROM dbo.fn_ShowMaxSales()

--2.5. Повертає інформацію про всі продажі конкретного товару. Назва товару передається в параметрах
go
create function fn_ShowInfoAboutProduct(@productName nvarchar(100))
returns @table table(ProductName nvarchar(50), Unit int, Price money, Customer nvarchar(30), Employee nvarchar(30)  )
as
begin
	insert into @table
	select P.ProductName as [Product name], S.Unit, S.Price, C.FirstName+' '+C.LastName, E.FirstName+' '+E.LastName
	from Sale S join Product P ON S.ProductID = P.ID
			    join Employee E ON S.EmployeeID = E.ID
				join Customer C ON S.CustomerID = C.ID
	where P.ProductName = @productName
	return
end
go
select *from Product
select * from dbo.fn_ShowInfoAboutProduct('Sneakers')

--2.6. Повертає інформацію про всіх продавців однофамільців
go
create function fn_ReturnSimilarSurname()
returns @table table (FirstName nvarchar(100), LastName nvarchar(100), Position nvarchar(100), EmploymentDate date, Gender nvarchar(10), Salary money)
as
begin
	insert into @table
	select E.FirstName, E.LastName, E.Position, E.EmploymentDate, E.Gender, E.Salary
	from Employee E
	where LastName in (select E.LastName 
	                   from Employee E
					   group by E.LastName
					   having count(E.LastName) > 1)
	return
end
go

select *from Employee
insert into Employee values ('Liza', 'Petrenko', 'Seller', '2018-03-08', 'woman', 30000)

select * from dbo.fn_ReturnSimilarSurname()
--2.7. Повертає інформацію про всіх покупців однофамільців
go
create function fn_ReturnSimilarSurnameCustomer()
returns @table table (FirstName nvarchar(30), LastName nvarchar(30), Email nvarchar(30), Gender nvarchar(10),Discount INT, Newsletter bit)
as
begin
	insert into @table
	select C.FirstName, C.LastName, C.Email, C.Gender, C.Discount, C.Newsletter
	from Customer C
	where C.LastName in (select C.LastName 
	                     from Customer C
					     group by C.LastName
					     having count(C.LastName) > 1)
	return
end
go

select * from dbo.fn_ReturnSimilarSurnameCustomer()
--2.8. Повертає інформацію про всіх покупців і продавців однофамільцях
go
create function fn_ReturnSimilarSurnameEmployeeAndCustomers()
returns @table table (FirstName nvarchar(100), LastName nvarchar(100))
as
begin

	insert into @table
	select E.FirstName, E.LastName
	from Employee E
	where E.LastName in (select E.LastName 
	                     from Employee E
					     group by E.LastName
					     having COUNT(E.LastName) > 1)
	
	insert into @table
	select C.FirstName, C.LastName
	from Customer C
	where C.LastName in (select C.LastName
	                     from Customer C
				         group by C.LastName
					     having count(C.LastName) > 1)

	insert into  @table
	select C.FirstName, C.LastName
	from Customer C
	where C.LastName in (select E.LastName 
	                     from Employee E
					     group by E.LastName
					)
	return
end
go

select * from dbo.fn_ReturnSimilarSurnameEmployeeAndCustomers()