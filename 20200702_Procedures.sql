
use Paniuk_Sport_Shop
--1.1 Процедура, що виводить "Hello, world"
go
create proc sp_PrintText
as
begin
	Print 'Hello, world'
end

exec sp_PrintText
go
--1.2 Повертає інформацію про час
go
alter proc sp_PrintTime
@res2 nvarchar(8) output
as
begin
  SELECT   @res2=  CONVERT (nvarchar(8), GETDATE(), 108)  
end
go

declare @res1 nvarchar(8)
exec sp_PrintTime @res1 out
Print 'Time =>' + ' '+ @res1



--1.3 Повертає інформацію про дату 
go
alter proc sp_PrintDate
@res2 nvarchar(8) output
as
begin
   SELECT @res2 = CONVERT (date, GETDATE());
end


declare @res1 nvarchar(8)
exec sp_PrintDate @res1 out
Print 'Date =>'+' '+ @res1
go

--1.4 Приймає три числа і повертає їх суму
go
create proc sp_Summa
@x int, @y int, @z int,
@summa int output
as
begin
  select @summa = @x+@y+@z 
end
go

declare @res int
exec sp_Summa 5,8,3, @res output 
Print 'Summa ='+ str(@res)

--1.5 Приймає три числа і повертає cереднє арифметичне
go
alter proc sp_Average
@x int, @y int, @z int,
@avg int output
as
begin
  select @avg = (@x+@y+@z)/3 
end
go

declare @res int
exec sp_Average 5,8,3, @res output 
Print 'Average ='+ str(@res)

--1.6 Приймає три числа і повертає максимальне
go
alter proc sp_Max
@x int, @y int, @z int,
@max int output
as
begin
  SELECT @max =  MAX(max)
  FROM (VALUES (@x),(@y),(@z)) AS value(max);
  end
go

declare @res int
exec sp_Max 5,8,3, @res output 
Print 'Max ='+ CONVERT (nvarchar(max), @res)

--1.7 Приймає три числа і повертає мінімальне
go
alter proc sp_Min
@x int, @y int, @z int,
@min int output
as
begin
  SELECT @min= MIN(min)
  FROM (VALUES (@x),(@y),(@z)) AS value(min);
  end
go

declare @res int
exec sp_Min 5,8,3, @res output 
Print 'Min ='+ CONVERT (nvarchar(max), @res)

--1.8 Приймає число і символ. Повертає лінію довжиною з число, що складається з символів
go
alter proc sp_Line
@x int, @y char
as
begin
    declare @line nvarchar(max) =''
    declare @i int = 0
	while @i < @x
	begin
		set @line = @line + @y
		set @i=@i+1
	end
	Print @line
end
go

exec sp_Line 5,'@'


--1.9 Приймає число і повертає факторіа 3! = 1*2*3
go
alter proc sp_Factorial
@x int, 
@y int output
as
begin
 declare @i int = 1
     set @y=1
	while @i <= @x
	begin
		set @y=@y*@i
		set @i=@i+1
	end
end

declare @factorial int
exec sp_Factorial 5, @factorial output
print 'Factorial => ' + CONVERT (nvarchar(max), @factorial)

go
--1.10 Приймає два числа. Другий параметр - це ступінь. Повертає число піднесене до степеня
go
alter proc sp_Degree
@x int, @degree int,
@res int output
as
begin
    declare @i int = 0
	while @i < @degree
	begin
		if (@i=0)
			begin
			set @res = @x
			end
		 else
			begin
			set @res = @res*@x
			end
        set @i = @i+1
	end
 end


declare @degree int
exec sp_Degree 2, 3, @degree output
print 'Degree =>'  + CONVERT (nvarchar(max), @degree)
go

--Для БД "Продажі"
--2.1 Інформацію про всіх продавців
go
create proc sp_ShowAllEmploees
as
begin
	select *from Employee
end

exec sp_ShowAllEmploees
go
--2.2 Інформація про всіх покупців
go
create proc sp_ShowAllCustomers
as
begin
	select *from Customer
end

exec sp_ShowAllCustomers
go

--2.3 Інформація про продажі
go
alter proc sp_ShowAllSales
as
begin
	select S.ID, P.ProductName, S.Unit, S.DatePurchase, C.FirstName + ' '+C.LastName as 'Customer', E.FirstName+' '+E.LastName as 'Employee' 
	from Sale S
	join Product P on S.ProductID = P.ID
	join Employee E on S.EmployeeID = E.ID
	join Customer C on S.CustomerID = C.ID
end

exec sp_ShowAllSales
go

select *from Sale
--2.4 Інформація про всі продажі в конкретний день. Дата передається в якості параметра
go
create proc sp_ShowSalesInOneDay
@date date
as
begin
	select S.ID, P.ProductName, S.Unit, S.DatePurchase, C.FirstName + ' '+C.LastName as 'Customer', E.FirstName+' '+E.LastName as 'Employee' 
	from Sale S
	join Product P on S.ProductID = P.ID
	join Employee E on S.EmployeeID = E.ID
	join Customer C on S.CustomerID = C.ID
	where S.DatePurchase = @date
end

exec sp_ShowSalesInOneDay '2016-02-05'

select *from Sale
go



--2.5 Інформація про всі продажі в певний період. Дата початку і кінця передається в параметрах
go
create proc sp_ShowSalesForPeriod
@dateStart date, @dateEnd date
as
begin
	select S.ID, P.ProductName, S.Unit, S.DatePurchase, C.FirstName + ' '+C.LastName as 'Customer', E.FirstName+' '+E.LastName as 'Employee' 
	from Sale S
	join Product P on S.ProductID = P.ID
	join Employee E on S.EmployeeID = E.ID
	join Customer C on S.CustomerID = C.ID
	where S.DatePurchase between @dateStart and @dateEnd
end

exec sp_ShowSalesForPeriod '2020-03-19', '2020-05-01'
select *from Sale
go

--2.6 Інформація про продажі певного продавця. ПІБ продавця передаєься в якості параметра
go
alter proc sp_ShowSalesOneSeller
@fullName nvarchar(50)
as
begin
	select S.ID, E.FirstName+' '+E.LastName as 'Employee', P.ProductName, S.Unit, S.DatePurchase, C.FirstName + ' '+C.LastName as 'Customer'
	from Sale S
	join Product P on S.ProductID = P.ID
	join Employee E on S.EmployeeID = E.ID
	join Customer C on S.CustomerID = C.ID
	where E.FirstName +' '+E.LastName =@fullName
end

exec sp_ShowSalesOneSeller 'Andry Rudyi'
select *from Sale
go

--2.7 Середньоарифметична ціна продажу в конкретний рік. Рік передається в якості параметра
go
create proc sp_AverageSellingPriceOneYear
@year int
as
begin
	select avg(Price) as 'AVG'
	from Sale S
	where Year(S.DatePurchase)=@year
end
go

exec sp_AverageSellingPriceOneYear 2020
select *from Sale

