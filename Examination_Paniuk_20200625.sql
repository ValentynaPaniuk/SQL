use Shop

select *from Category
select *from Customers
select *from Employees
select *from OrderDetails
select *from Orders
select *from Products
select *from Shippers
select *from Suppliers

--1. ������� ��� ��� ������������� � ���� Italy, Spain, France (������������ ���������� IN)
select *from Suppliers

select * 
from Suppliers S
where S.Country in ('Italy', 'Spain', 'France')

--2. ������� ����� ������������� ��� �������(������������ SELECT DISTINCT ....)
select *from Suppliers

select distinct S.Country
from Suppliers S

--3. �������� ���� ������ �� 10% , �� ����������c� ������ �������������� (Nike)
select *from Products
select *from Suppliers

select P.Price*1.1
from Products P, Suppliers SP
where P.SupplierID = Sp.ID and SP.SupplierName='Nike'

--4. ������� ����������, �� ������� � ������� ����� (10)
select *from Orders

select *
from Orders O
where MONTH(O.OrderDate) = 10

--5. ������� ����������, �������� �� 30 ����
select *from Employees

select E.FirstName+' '+E.LastName as 'Full Name', DATEDIFF(year, E.BirthDate,  getdate()) as 'Age'
from Employees E
where DATEDIFF(year, BirthDate,  getdate()) < 30

--6. ������� ����� �볺���, �� ����������� �� ���� ����� (���������, A B ���  �, ������������ Like '[ABC]%' )
select *from Customers

select C.CustomerName
from Customers C
where C.CustomerName like'[AaBbCb]%'


--7. ������� ����� �������� , ����������� �� ����������
select *from Products

select P.ProductName
from Products P
group by P.ProductName

--8.  ������� ������� �������� ������
select *from Products

select distinct COUNT(P.CategoryID) as "Count Category"
from Products P

--9.  ������ ����� ������ � ������� "����������� ������"(Confections)
select *from Category
select *from Products


select COUNT(P.ProductName) as 'Count products from Category CONFECTIONS'
from Products P, Category C
where P.CategoryID = C.ID and C.CategoryName = 'Confections'

--10. ����� ����� ������ � ������� "����"(Beverages)
select *from Category
select *from Products

select P.ProductName, C.CategoryName
from Products P, Category C
where P.CategoryID = C.ID and C.CategoryName = 'Drinks'


--11. ������ ������� ����, ����������� �� �������� ���� ������ � ����� �������
select *from Category
select *from Products

select avg(P.Price) as 'Avarage price (Drinks)', min(P.Price) as 'Min Price', max(P.Price) as 'Max Price'
from Products P, Category C
where P.CategoryID = C.ID and C.CategoryName = 'Drinks'

--12. ������ ������� �� ����������
select *from Employees

select AVG(DATEDIFF(year, E.BirthDate,  getdate())) as 'Avarage age Employee'
from Employees E

--13. ������ ������(�����, ����, ��������), �� ������������ � ����� ����� (���볿 �� ��.)
select *from Products
select *from Suppliers

select P.ProductName as 'ProductName', P.Price as 'Price', P.Unit as 'Unit', S.Country
from Products P, Suppliers S
where P.SupplierID = S.ID and S.Country = 'USA'

--14. ������� ����� ������, �����(�����) �볺��� �� ����� ������������� ������
select *from Orders
select *from Customers
select *from Suppliers
select *from Products
select *from OrderDetails

select P.ProductName as 'Product Name', C.CustomerName as 'Customer Name', S.SupplierName as 'SupplierName'
from Orders O, Customers C, Suppliers S, Products P, OrderDetails OD
where P.ID=OD.ProductID and C.ID = O.CustomerID and S.ID = P.SupplierID and O.ID = Od.OrderID


--15. ������� ����� ������������� �������� ��������(Seafood)
select *from Suppliers
select *from Products
select *from Category

select S.SupplierName as 'Supplier Name', P.ProductName as 'Product Name'
from Suppliers S, Products P, Category C
where P.CategoryID = C.ID and P.SupplierID = S.ID and C.CategoryName = 'Seafood'

--16. !!!!!!!!!������ ������ ��������� ������� ������ ���������(� ���� ��������� ����� ����������, ��������� 'Speedy Express' )
select *from OrderDetails
select *from Orders
select *from Products
select *from Shippers

select COUNT(S.ID) as 'Count Shipper 4'
from Shippers S, OrderDetails OD, Orders O
where S.ID = O.ShipperId and O.ID = Od.OrderID and S.ShipperName='Shipper4'


--17. ������� ��� ��� ���������� (����� ����������, ����� �볺���, ��'� ����������, ����� ����������) �� ������ ����� ������� ����
select *from Orders
select *from Customers
select *from Shippers

select O.ID as 'ID Order', C.CustomerName as 'Customer Name', S.ShipperName as 'Shipper Name'
from Orders O, Customers C, Shippers S
where O.CustomerID = C.ID and O.ShipperId = S.ID and  MONTH(O.OrderDate) = 10 and YEAR(O.OrderDate) = 2003

--18. ������� ��� ��� ������� ���������� ������� �볺���  (����� ����������, ����� �볺���, ��'� ����������, ����� ����������)
select *from Orders
select *from Customers
select *from Shippers
select *from Employees

select O.ID as 'ID Order', C.CustomerName as 'Customer Name', E.FirstName + ' '+ E.LastName as 'Employee' ,S.ShipperName as 'Shipper Name'
from Orders O, Customers C, Shippers S, Employees E
where O.CustomerID = C.ID and O.EployeeID = E.ID and O.ShipperId = S.ID and C.CustomerName = 'Lee'

--19. ������� ������� ��������� ������� �볺���( � ���� ��������� ����� �볺���)
select *from Orders
select *from Customers
select *from Shippers

select COUNT(O.ID) as 'Count Orders by Lee'
from Orders O, Customers C, Shippers S
where O.CustomerID = C.ID and O.ShipperId = S.ID and C.CustomerName = 'Anton'

--20. ������ �������� ����� ������ ���������� ������ �볺����(� ���� ��������� ����� �볺���, ��������� 'Romero y tomillo'), ����� �������� �� ���� quantity 
select *from Products
select *from Customers
select *from OrderDetails
select *from Orders

select sum(OD.Quantity) as 'Quantity products (Lee)'
from Products P, Customers C, Orders O, OrderDetails OD
where P.ID = OD.ProductID and C.ID=O.CustomerID and O.ID=OD.OrderID and C.CustomerName = 'Lee'

--21. ������ �������� �������  ����, �� ���  ������� ������  ������ �볺��(� ���� ��������� ����� �볺���, ��������� 'Romero y tomillo')
select *from Products
select *from Customers
select *from OrderDetails
select *from Orders

select sum(OD.Quantity * P.Price) as 'Quantity products (Lee)'
from Products P, Customers C, Orders O, OrderDetails OD
where P.ID = OD.ProductID and C.ID=O.CustomerID and O.ID=OD.OrderID and C.CustomerName = 'Lee'

--22. ������� ������� ��������� �� ������� �볺���(���������� ����� �볺���)
select *from Products
select *from Customers
select *from OrderDetails
select *from Orders

--variant 1
select C.CustomerName, COUNT(*) as 'Quantity'
from Customers C, Orders O, OrderDetails OD
where C.ID=O.ID and O.ID=OD.OrderID
group by C.CustomerName

--variant 2
select C.CustomerName, COUNT(*) as 'Quantity'
from Customers C join Orders O on C.ID=O.ID join OrderDetails OD on O.ID=OD.OrderID
group by C.CustomerName


--23. ������� ������� ��������� �� ������� �볺���, ������� ���� ������� ����
select *from Products
select *from Customers
select *from OrderDetails
select *from Orders

--variant 1
select C.CustomerName, O.OrderDate, COUNT(*) as 'Quantity'
from Customers C, Orders O, OrderDetails OD
where C.ID=O.ID and O.ID=OD.OrderID
group by C.CustomerName, O.OrderDate
having O.OrderDate>'2009-03-05'

--variant 2
select C.CustomerName, O.OrderDate, COUNT(*) as 'Quantity'
from Customers C join Orders O on C.ID=O.ID join OrderDetails OD on O.ID=OD.OrderID
group by C.CustomerName, O.OrderDate
having O.OrderDate>'2009-03-05'


--24. ������� ������� ��������� �� ������� ����(��� �����, ���� ���� � ����� ������ ����)
select *from Products
select *from Customers
select *from OrderDetails
select *from Orders

--variant 1
select YEAR(O.OrderDate) as 'Year', COUNT(*) as 'Quantity'
from Orders O, OrderDetails OD
where O.ID=OD.OrderID
group by O.OrderDate

--variant 2
select YEAR(O.OrderDate) as 'Year', COUNT(*) as 'Quantity'
from Orders O join OrderDetails OD on O.ID=OD.OrderID
group by O.OrderDate


--25. ������� ������� ��������� �� ������� �볺���, �� ������� ����� 5 ���������
select *from Products
select *from Customers
select *from OrderDetails
select *from Orders

--variant 1
select C.CustomerName, COUNT(*) as 'Quantity'
from Customers C, Orders O, OrderDetails OD
where C.ID=O.ID and O.ID=OD.OrderID
group by C.CustomerName
having COUNT(*)>5

--variant 2
select C.CustomerName, COUNT(*) as 'Quantity'
from Customers C join Orders O on C.ID=O.ID join OrderDetails OD on O.ID=OD.OrderID
group by C.CustomerName
having COUNT(*)>5


--26. ������� ������� ������ �� ������� ����������(sum)
select *from OrderDetails

select OD.OrderID as 'Order ID', sum(OD.Quantity) as 'Quantity'
from OrderDetails OD
group by OD.OrderID

--27. ������ ������� ������, �� ������������ � ����� �����
select *from Products
select *from OrderDetails
select *from Suppliers

--variant 1
select S.Country as 'Country', sum(OD.Quantity) as 'Quentity'
from Products P, OrderDetails OD, Suppliers S
where P.ID = OD.ProductID and S.ID=P.SupplierID
group by S.Country

--variant 2
select S.Country as 'Country', sum(OD.Quantity) as 'Quentity'
from Products P join OrderDetails OD on P.ID = OD.ProductID join Suppliers S on S.ID=P.SupplierID
group by S.Country


--28. ������� ������� (���� �������� * ������� ��������) �� ������� ����������(sum)
select *from Products
select *from OrderDetails

--variant 1
select P.ProductName, P.Price*OD.Quantity as 'Cost'
from Products P, OrderDetails OD
where P.ID = OD.ID
group by P.ProductName, P.Price*OD.Quantity

--variant 2
select P.ProductName, P.Price*OD.Quantity as 'Cost'
from Products P join OrderDetails OD
on P.ID = OD.ID
group by P.ProductName, P.Price*OD.Quantity