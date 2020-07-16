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
with rollup  -- ������� ������������ ����� (�������� ������� �� avg ������ ��� ����� �����)
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
-- ������������ ������� � ������� 
Pivot (
sum(SalesAmmount)
For Country
IN ( Egypt , Colombia, Canada,China,France,Ukraine,Slovenia)
    -- ��������� �������
    -- For ��� ����� ����
    -- In ( ������� �������� �������, �� ����� ������� ���������)
) as PivotTable  -- ����'������ �� ���� ����, �� ����� �� ����������� �� ����
group by  Name, Egypt , Colombia, Canada,China,France,Ukraine,Slovenia
?
select * from tblPivot
?
-- ������� � �������
select Name, Country, SalesAmmount
from tblPivot
Unpivot(
    SalesAmmount
    for Country in (Egypt , Colombia, Canada,China,France,Ukraine,Slovenia)
) as unpivotTable
?
select Employee.Name, Country, sum(SalesAmmount) Suma, AVG(SalesAmmount) AVG
From Sales join Employee on Sales.EmployeeId = Employee.Id
group by cube(Employee.Name, Country) --  ������� ������������ ����� (�������� ������� �� avg �� ��� ������ ��� ����� ����� �� ���������� (�� �� ������� � group by)
Collapse



