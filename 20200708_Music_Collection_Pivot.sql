use Paniuk_MusicCollection

select *from Disk
select *from Style
select *from Singer
select *from Publisher
select *from Song
select *from DiskSong


Update Disk
Set StyleID = 4
Where SingerID=3

Update Disk
Set Review = 'Dance'
Where StyleID=4

--1.1 Відобразити інформацію про виконавців і стилях його муз.альбомів.
-- Результат має містити наступні стовпчики: Виконавець, Назва стилю 
-- (Кількість стовпчиків залежить від кількості стилів)
-- В стовпчику Виконавець мають бути імена виконавців
-- В стовпчику Стилів в якості значення має бути кількість альбомів виконавця в тому чи іншому стилі
-- Якщо альбому такого стилю немає - Null
go

create table tblPivot(
        Name nvarchar(20), 
        Chamber  nvarchar(20) , Classical  nvarchar(20), Dance  nvarchar(20), Jazz  nvarchar(20), Pop  nvarchar(20)
)


insert into tblPivot
select SingerName, Chamber, Classical, Dance, Jazz, Pop
From (select S.SingerName, StyleName, StyleID
    from Singer S join Disk D On S.ID = D.SingerID
	              join Style St on D.StyleID = St.ID
) as SourceTable
-- Трансформуємо рядочки в колонки 
Pivot (
count(StyleID)
For StyleName
IN ( Chamber, Classical, Dance, Jazz, Pop)
    -- агрегуюча функція
    -- For для якого поля
    -- In ( множина можливих значень, які варто зробити колонками)
) as PivotTable  -- обов'язково має бути аліас, бо ззовні не доступимось до полів
group by  SingerName, Chamber, Classical, Dance, Jazz, Pop

go

select * from tblPivot

--1.2 відобразити інформацію про видавців і стилях виданих муз.альбомів
-- Результат має мітити наступні стовпчики: Стиль, Назва видавця 
--(кількість стовпчиків залежить від кількості видавців)
-- В стовпчику Стиль мають бути назви стилів
-- В стовпчиках видавців в якості значень мають бути кількість альбомів видавця в 
-- тому чи іншому стилі, якщо альбомів якогось стилю немає - Null


select *from Disk
select *from Style
select *from Singer
select *from Publisher
select *from Song
select *from DiskSong
go


Update Publisher
Set PublisherName = 'NashFormat'
Where ID=1

create table tblPivotPublisher(
        Name nvarchar(20), 
        NashFormat  nvarchar(20) , Ranok  nvarchar(20), Osnova  nvarchar(20)
)

go
insert into tblPivotPublisher
select StyleName, NashFormat, Ranok, Osnova
From (select St.StyleName, PublisherName, StyleID
    from Publisher P join Disk D On P.ID = D.PublisherID
	              join Style St on D.StyleID = St.ID
) as SourceTable
-- Трансформуємо рядочки в колонки 
Pivot (
count(StyleID)
For PublisherName
IN ( NashFormat, Ranok, Osnova)
    -- агрегуюча функція
    -- For для якого поля
    -- In ( множина можливих значень, які варто зробити колонками)
) as PivotTable  -- обов'язково має бути аліас, бо ззовні не доступимось до полів
group by StyleName,  NashFormat, Ranok, Osnova

go

select * from tblPivotPublisher
select *from Disk
select *from Style


--Unpivot
--2.1 Відобразити інформацію про виконавця і стилі його муз.альбомів. 
-- Результат має містити такі стовпці: Виконавець, Стиль, Кількість альбомів
-- В стовпці Виконавець мають бути назви виконавців
-- В стовпці Стиль - назви стилів
-- В стовпці Кількість - кількість альбомів виконавця в конкретному стилі
go
select Name, Style, StyleID
from tblPivot
Unpivot(
    StyleID
    for Style in (Chamber, Classical, Dance, Jazz, Pop)
        )   as unpivotTable

select S.SingerName, St.StyleName, count(StyleID) count
from Singer S join Disk D On S.ID = D.SingerID
	          join Style St on D.StyleID = St.ID
group by cube(S.SingerName, St.StyleName) --  створює надагрегуючі рядки (підсумкові рядочки по avg та сумі продаж для кожної країни та працівника (те що вказано в group by)
Collapse
go

--2.2 Відобразити інформацію про видавців і  стилях їх муз.альбомів
--Результат має містити такі стовпці: Видавець, Стиль, Кількість альбомів
-- В стовпці Видавець мають бути назви видавців
-- В стовпці Стиль - назви стилів
-- В стовпці Кількість - кількість альбомів виконавця в конкретному стилі

go
select Name, PublisherName, StyleID
from tblPivotPublisher
Unpivot(
    StyleID
    for PublisherName in (NashFormat, Ranok, Osnova)
        )   as unpivotTable

select P.PublisherName, St.StyleName, count(StyleID) count
from Publisher P join Disk D On P.ID = D.PublisherID
	              join Style St on D.StyleID = St.ID
group by cube(P.PublisherName,  St.StyleName) --  створює надагрегуючі рядки (підсумкові рядочки по avg та сумі продаж для кожної країни та працівника (те що вказано в group by)
Collapse
go


--Sport Shop
--2.1 Відобразити інформацію про виробників і видах товару
-- Результат має містити наступні стовпці: Виробник, Вид товару
--(кількість стовпців залежить від кількості виду товару)
-- В стовпці Виробник - назва виробника
-- В стовпці вид товару в якості значень має бути кількість видів товару в наявності цього конкретного виробника
-- Якщо товару немає - Null
go
use Paniuk_Sport_Shop
select *from Product

create table tblPivotProduct(
        Name nvarchar(20), 
        Sneakers  nvarchar(20) , Tracksuit  nvarchar(20), Racetrack  nvarchar(20), Ball  nvarchar(20)
)



insert into tblPivotProduct
select SupplierName, Sneakers, Tracksuit, Racetrack, Ball
From (select S.SupplierName, ProductName,Quantity
    from Supplier S join Product P on S.ID = P.SupplierID 
	             
) as SourceTable
-- Трансформуємо рядочки в колонки 
Pivot (
sum(Quantity)
For ProductName
IN ( Sneakers, Tracksuit, Racetrack, Ball)
    -- агрегуюча функція
    -- For для якого поля
    -- In ( множина можливих значень, які варто зробити колонками)
) as PivotTable  -- обов'язково має бути аліас, бо ззовні не доступимось до полів
group by  SupplierName, Sneakers, Tracksuit, Racetrack, Ball

select * from tblPivotProduct
select *from Sale

select *from Product
select *from Supplier

truncate table tblPivotProduct



--unpivot
go
select Name, SupplierName, Quantity
from tblPivotProduct
Unpivot(
    Quantity
    for SupplierName in (Sneakers, Tracksuit, Racetrack, Ball)
        )   as unpivotTable

select S.SupplierName, ProductName, sum(Quantity) Guantity
From Product P join Supplier S on P.SupplierID = S.ID
group by cube(S.SupplierName, ProductName) --  створює надагрегуючі рядки (підсумкові рядочки по avg та сумі продаж для кожної країни та працівника (те що вказано в group by)


go
--2.2 Відобразити інформацію про виробника і види товару
-- Результат має містити наступні стовпці: Вид товару, Виробник
-- В стовпці Вид товару - назва товару
-- В стовпці Виробник - в якості значень має бути кількість видів товару в наявності цього конкретного виробника
-- Якщо товару немає - Null


select *from Supplier

Update Supplier
Set SupplierName = 'NewBalance'
Where ID=6

create table tblPivotSupplier(
        Name nvarchar(20), 
        Adidas  nvarchar(20) , Nike  nvarchar(20), Asics  nvarchar(20), Reebok  nvarchar(20), Puma  nvarchar(20), NewBalance  nvarchar(20), Deha  nvarchar(20)
)

insert into tblPivotSupplier
select ProductName, Adidas, Nike, Asics, Reebok, Puma, NewBalance, Deha
From (select S.SupplierName, ProductName,Quantity
    from Supplier S join Product P on S.ID = P.SupplierID 
	             
) as SourceTable
-- Трансформуємо рядочки в колонки 
Pivot (
sum(Quantity)
For SupplierName
IN ( Adidas, Nike, Asics, Reebok, Puma, NewBalance, Deha)
    -- агрегуюча функція
    -- For для якого поля
    -- In ( множина можливих значень, які варто зробити колонками)
) as PivotTable  -- обов'язково має бути аліас, бо ззовні не доступимось до полів
group by  ProductName, Adidas, Nike, Asics, Reebok, Puma, NewBalance, Deha

select * from tblPivotSupplier