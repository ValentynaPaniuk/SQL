go
use Paniuk_Travel_Agency
go
--Показати інформацію про:
-- - всі актуальні тури
select *from Tur
select distinct T.TurName, T.StartDate, T.EndDate, T.Cost, CR.CountryName, TR.TransportName, T.MaxCountCustomer
from Tur T join TurCity TC on T.ID = TC.TurID
           join City C on C.ID = TC.CityID
		   join Transport TR on TR.ID = T.TransportID
		   join Country CR on C.CountryID = CR.ID
		   join TurCustomer TCR on T.ID = TCR.TurID
where CONVERT(varchar(10),(dateadd(dd, +2, getdate())),120) < T.StartDate

-- Неоплачені тури у форматі: назва туру - тривалість - к-сть бажаючих відвідати
select *from Tur
select *from TurCustomer

select T.TurName, DATEDIFF (day, T.StartDate, T.EndDate) as 'Days', count (TC.CustomerID) as 'Do not Paid'
from Tur T join TurCustomer TC on T.ID=TC.TurID
where TC.Paid=0
group by T.TurName, T.EndDate, T.StartDate

-- Показати всі тури, які контролює працівник Oleg Nechyporuk
select *from Employee
select *
from Tur T join TurEmployee TE on T.ID=TE.TourID
           join Employee E on E.ID=TE.EmployeeID
		   where E.FullName = 'Oleg Nechyporuk'

-- Показати інформацію про тури за минулий рік. Погрупувати по країні
select *from Tur

select *
from Tur T join TurCity TC on T.ID = TC.TurID
           join City C on TC.CityID = C.ID
		   join Country CR on C.CountryID = CR.ID
where Year(T.EndDate) = 2019
order by CR.CountryName

-- Показати інформацію у вигляді зведеної таблиці, яка міститиме дані про країни, міста, к-сть визначних місць
go
select *from City
select *from Place
select *from CityPlace
select *from Country

create table tblPivot(
        Name nvarchar(20), 
        Kyiv  nvarchar(20) , 
		Lviv  nvarchar(20), 
		Odessa  nvarchar(20), 
		Dnipro  nvarchar(20), 
		Lutsk  nvarchar(20), 
		Ternopil  nvarchar(20), 
		IvanoFrankivsk  nvarchar(20),
		Rome  nvarchar(20),
		Milan  nvarchar(20),
		Venecia  nvarchar(20),
		Florencia  nvarchar(20),
		Verona  nvarchar(20),
		Neapol  nvarchar(20),
		Bolonia  nvarchar(20),
		Paris  nvarchar(20),
		Marseille nvarchar(20),
		Lyon nvarchar(20),
		Toulouse nvarchar(20),
		Nice nvarchar(20),
		Straßburg nvarchar(20),
		Bordo nvarchar(20),
		London nvarchar(20),
		Manchester nvarchar(20),
		Birmingham nvarchar(20),
		Liverpool nvarchar(20),
		Cambridge nvarchar(20),
		Oxford nvarchar(20),
		Sheffield nvarchar(20),
		Tbilisi nvarchar(20),
		Batumi nvarchar(20),
		Kutaisi nvarchar(20),
		Poti nvarchar(20),
		Rustavi nvarchar(20),
		Ahalcha nvarchar(20),
		Telavi nvarchar(20),
		Warszawa nvarchar(20),
		Kraków nvarchar(20),
		Wrocław nvarchar(20),
		Gdańsk nvarchar(20), 
		Poznań nvarchar(20), 
		Łódź nvarchar(20),
		Katowice nvarchar(20)
		)
		


Update City
Set CityName = 'IvanoFrankivsk'
Where ID=7

truncate table tblPivot
drop table tblPivot
go
insert into tblPivot
select CountryName, Kyiv, Lviv, Odessa, Dnipro, Lutsk, Ternopil, IvanoFrankivsk, Rome, Milan, Venecia, Florencia, Verona, Neapol, Bolonia , Paris, Marseille , Lyon, Toulouse, Nice, Straßburg, Bordo, London, Manchester, Birmingham, Liverpool, Cambridge, Oxford, Sheffield, Tbilisi, Batumi, Kutaisi, Poti, Rustavi, Ahalcha, Telavi, Warszawa, Kraków, Wrocław, Gdańsk, Poznań, Łódź, Katowice  

From (select distinct CR.CountryName, C.CityName, PlaceID
    from Country CR join City C On CR.ID = C.CountryID
	              join CityPlace CP on CP.CityID = C.ID
) as SourceTable
-- Трансформуємо рядочки в колонки 
Pivot (
count(PlaceID)
For CityName
IN ( Kyiv, Lviv, Odessa, Dnipro, Lutsk, Ternopil, IvanoFrankivsk, Rome, Milan, Venecia, Florencia, Verona, Neapol, Bolonia , Paris, Marseille , Lyon, Toulouse, Nice, Straßburg, Bordo, London, Manchester,	Birmingham, Liverpool, Cambridge, Oxford, Sheffield, Tbilisi, Batumi, Kutaisi, Poti, Rustavi, Ahalcha, Telavi, Warszawa, Kraków, Wrocław, Gdańsk, Poznań, Łódź, Katowice  
)
    -- агрегуюча функція
    -- For для якого поля
    -- In ( множина можливих значень, які варто зробити колонками)
) as PivotTable  -- обов'язково має бути аліас, бо ззовні не доступимось до полів
group by  CountryName, Kyiv, Lviv, Odessa, Dnipro, Lutsk, Ternopil, IvanoFrankivsk, Rome, Milan, Venecia, Florencia, Verona, Neapol, Bolonia , Paris, Marseille , Lyon, Toulouse, Nice, Straßburg, Bordo, London, Manchester, Birmingham, Liverpool, Cambridge, Oxford, Sheffield, Tbilisi, Batumi, Kutaisi, Poti, Rustavi, Ahalcha, Telavi, Warszawa, Kraków, Wrocław, Gdańsk, Poznań, Łódź, Katowice  
go

-- Тури, які стартують в указаному діапазоні дат (дата як параметр)
go
alter function fn_showTurFromTo(@dateStart nvarchar(30), @dateEnd nvarchar(30))
returns table
as
	return (select T.TurName, T.StartDate
		from Tur T join TurCity TC on T.ID = TC.TurID	
		                join City C on TC.CityID = C.ID
						join Country CR on CR.ID = C.CountryID
						where T.StartDate between @dateStart and @dateEnd)
go

select *
from fn_showTurFromTo('2020-08-01', '2020-08-31')



-- Інформація про тури, які відвідають вказану країну (країна як параметр)

go
create function fn_showTur(@country nvarchar(30))
returns table
as
	return (select T.TurName
		from Tur T join TurCity TC on T.ID = TC.TurID	
		                join City C on TC.CityID = C.ID
						join Country CR on CR.ID = C.CountryID
						where CR.CountryName = @country)
go

select *
from fn_showTur('Ukraine')

--- Показати найпопулярнішу туристичну країну (із найбільшої кількості турів з урахуванням архівних)
select *from Tur
select *from TurCity
select *from TurCustomer

update Tur
Set TurName = 'Poland'
where ID = 7

go

select *from Tur

select top(1) CR.CountryName, count (T.ID) as 'MaxCountTur'
from Tur T join TurCity TC on T.ID = TC.TurID
           join City C on C.ID = TC.CityID
           join Country CR on CR.ID = C.CountryID
group by CR.CountryName
order by MaxCountTur desc

go

--- Показати найпопулярніший актуальний тур (по максимальній кількості куплених туристичних путівок)
go
select top(1) T.TurName, count (T.ID) as 'MaxCountTur'
from Tur T join TurCustomer TC on T.ID = TC.TurID
group by T.TurName
order by MaxCountTur desc

go
--- Показати найпопулярніший архівний тур (по максимальній кількості куплених туристичних путівок)
select top(1) T.TurName, count (T.ID) as 'MaxCountTur'
from Tur T join TurCustomer TC on T.ID = TC.TurID
           join Archive A on A.TurID=T.ID
group by T.TurName
order by MaxCountTur desc

--- Показати найнепопулярніший актуальний тур (щодо мінімальної кількості куплених туристичних путівок)
go
select top(1) T.TurName, count (T.ID) as 'MaxCountTur'
from Tur T join TurCustomer TC on T.ID = TC.TurID
group by T.TurName
order by MaxCountTur

--- Показати для конкретного туриста по ПІБ список всіх його турів. ПІБ туриста передається як параметр
go
alter function fn_ShowCustomerTurs(@nameCustomer nvarchar(20))
returns table
as
 return (select distinct T.TurName as 'Turs'
         from Tur T join TurCustomer TC on T.ID = TC.TurID
		            join Customer C on TC.CustomerID = C.ID
					where C.FullName=@nameCustomer)
go

select *from Customer

select *
from dbo.fn_ShowCustomerTurs('Kateryna Koval')

--- Перевірити для конкретного туриста по ПІБ знаходиться він зараз у турі. ПІБ туриста передається як параметр
go
alter function fn_ShowCustomer(@nameCustomer nvarchar(20))
returns nvarchar(20)
as
begin
      declare @res nvarchar(20) 
      if exists (select *
	            from Customer C join TurCustomer TC on C.ID = TC.CustomerID
				                join Tur T on TC.TurID = T.ID
				where C.FullName = @nameCustomer and T.StartDate<=GETDATE() and T.EndDate>=Getdate())
				begin
				    set @res ='In tur'
				end
				
	  else
				begin
				    set @res = 'In home'
				end
return @res
end
go


select * from TurCustomer

declare @res  nvarchar(20)
select @res = dbo.fn_ShowCustomer('Kateryna Koval')
print @res


--- Відобразити інформацію про те, де знаходиться конкретний турист по ПІБ. Якщо турист не в турі згенерувати помилку з описом виниклої проблеми. ПІБ туриста передається як параметр

--- Відобразити інформацію про найактивнішого туриста (за кількістю придбаних турів)

--- Відобразити інформацію по всіх турах зазначеного способу пересування. Спосіб пересування передається як параметр

--- Відобразити інформацію про найпопулярніші готелі серед туристів (за кількістю туристів)


--- Показати середню вартість визначних місць конкретного туру (назва туру передається в параметри)
go
alter function fn_AvgCostPlace(@nameTur nvarchar(20))
returns money
as
begin
    return (select avg(P.CostPlace) as 'Avg'
            from Place P join CityPlace CP on P.ID =CP.PlaceID
			             join City C on CP.CityID = C.ID
						 join TurCity TC on TC.CityID = C.ID
						 join Tur T on T.ID = TC.TurID
		    where T.TurName = @nameTur)
end
go

select *from Place
--Не можу додати назву стовпчика
SELECT dbo.fn_AvgCostPlace('Kyiv')



--index
--Clustered
exec sp_helpindex City
exec sp_helpindex CityHotel
exec sp_helpindex CityPlace
exec sp_helpindex Country
exec sp_helpindex Customer
exec sp_helpindex Employee
exec sp_helpindex Hotel
exec sp_helpindex Place
exec sp_helpindex Position
exec sp_helpindex Transport
exec sp_helpindex Tur
exec sp_helpindex TurCity
exec sp_helpindex TurCustomer
exec sp_helpindex TurEmployee

select *from Tur
--NONCLUSTERED
go
CREATE NONCLUSTERED INDEX IX_Tur_Cost
    ON dbo.Tur (Cost Desc);   
go

go
CREATE NONCLUSTERED INDEX IX_Hotel_Details
    ON Hotel (HotelName Asc, Active Desc);   
go

go
CREATE NONCLUSTERED INDEX IX_Tur_Transport
    ON Tur (TurName Asc, TransportID Desc);   
go

--найдорожчій товар в кожній категорії
select P.ProductName, C.CategoryName
from Category C join Product P on C.ID = P.CategoryID
                join Product_Price PP on P.ID =PP.ProductID 
				where P.Price = 
				               	(select Max(PP.Price)
			                 	 from Product_Price PP join Product P on PP.ProductID = P.Price
			                 	                       join Category C on C.ID = P.CategoryID)
			                 
