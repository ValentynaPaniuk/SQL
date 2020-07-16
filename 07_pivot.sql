create table Sales (Id int primary key identity,
                    EmployeeId int foreign key references Employee(Id),
                    Country nvarchar(20),
                    SalesAmmount money)
                    go
?
select * from Employee
select * from Sales
?
truncate table Sales
?
select Employee.Name, Country, avg(SalesAmmount) Suma
From Sales join Employee on Sales.EmployeeId = Employee.Id
group by Employee.Name, Country
with rollup  -- створює надагрегуючі рядки (підсумкові рядочки по avg продаж для кожної країни)
?
create table tblPivot(
        Name nvarchar(20), 
        Egypt  nvarchar(20) , Colombia  nvarchar(20), Canada  nvarchar(20),China  nvarchar(20),France  nvarchar(20),Ukraine  nvarchar(20),Slovenia  nvarchar(20)
)
?
insert into tblPivot
select Name, Egypt , Colombia, Canada,China,France,Ukraine,Slovenia
From (select E.Name, Country, SalesAmmount
    from Sales S join Employee E On S.EmployeeId = E.Id
) as SourceTable
-- Трансформуємо рядочки в колонки 
Pivot (
sum(SalesAmmount)
For Country
IN ( Egypt , Colombia, Canada,China,France,Ukraine,Slovenia)
    -- агрегуюча функція
    -- For для якого поля
    -- In ( множина можливих значень, які варто зробити колонками)
) as PivotTable  -- обов'язково має бути аліас, бо ззовні не доступимось до полів
group by  Name, Egypt , Colombia, Canada,China,France,Ukraine,Slovenia
?
select * from tblPivot
?
-- колонки в рядочки
select Name, Country, SalesAmmount
from tblPivot
Unpivot(
    SalesAmmount
    for Country in (Egypt , Colombia, Canada,China,France,Ukraine,Slovenia)
) as unpivotTable
?
select Employee.Name, Country, sum(SalesAmmount) Suma, AVG(SalesAmmount) AVG
From Sales join Employee on Sales.EmployeeId = Employee.Id
group by cube(Employee.Name, Country) --  створює надагрегуючі рядки (підсумкові рядочки по avg та сумі продаж для кожної країни та працівника (те що вказано в group by)
Collapse



