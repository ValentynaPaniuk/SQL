use Shop

select *from Category
select *from Customers
select *from Employees
select *from OrderDetails
select *from Orders
select *from Products
select *from Shippers
select *from Suppliers

--1. вибрати дані про постачальників з країн Italy, Spain, France (скористатися оператором IN)
select *from Suppliers

select * 
from Suppliers S
where S.Country in ('Italy', 'Spain', 'France')

--2. вивести країни постачальників БЕЗ повторів(скористатися SELECT DISTINCT ....)
select *from Suppliers

select distinct S.Country
from Suppliers S

--3. збільшити ціни товарів на 10% , що постачаютьcя певним постачальником (Nike)
select *from Products
select *from Suppliers

select P.Price*1.1
from Products P, Suppliers SP
where P.SupplierID = Sp.ID and SP.SupplierName='Nike'

--4. вибрати замовлення, які зроблені у певному місяці (10)
select *from Orders

select *
from Orders O
where MONTH(O.OrderDate) = 10

--5. вивести працівників, молодших від 30 років
select *from Employees

select E.FirstName+' '+E.LastName as 'Full Name', DATEDIFF(year, E.BirthDate,  getdate()) as 'Age'
from Employees E
where DATEDIFF(year, BirthDate,  getdate()) < 30

--6. вивести імена клієнтів, які починаються на деякі букви (наприклад, A B або  С, скористатися Like '[ABC]%' )
select *from Customers

select C.CustomerName
from Customers C
where C.CustomerName like'[AaBbCb]%'


--7. вивести назви продуктів , впорядковані за зростанням
select *from Products

select P.ProductName
from Products P
group by P.ProductName

--8.  Вивести кількість категорій товарів
select *from Products

select distinct COUNT(P.CategoryID) as "Count Category"
from Products P

--9.  Знайти число товарів у категорії "Кондитерські вироби"(Confections)
select *from Category
select *from Products


select COUNT(P.ProductName) as 'Count products from Category CONFECTIONS'
from Products P, Category C
where P.CategoryID = C.ID and C.CategoryName = 'Confections'

--10. Знати назви товарів з категорії "Напої"(Beverages)
select *from Category
select *from Products

select P.ProductName, C.CategoryName
from Products P, Category C
where P.CategoryID = C.ID and C.CategoryName = 'Drinks'


--11. Знайти середню ціну, максимальну та мінімальну ціни товарів у певній категорії
select *from Category
select *from Products

select avg(P.Price) as 'Avarage price (Drinks)', min(P.Price) as 'Min Price', max(P.Price) as 'Max Price'
from Products P, Category C
where P.CategoryID = C.ID and C.CategoryName = 'Drinks'

--12. Знайти середній вік працівників
select *from Employees

select AVG(DATEDIFF(year, E.BirthDate,  getdate())) as 'Avarage age Employee'
from Employees E

--13. Знайти товари(назва, ціна, упаковка), які постачаються з певної країни (Італії чи ін.)
select *from Products
select *from Suppliers

select P.ProductName as 'ProductName', P.Price as 'Price', P.Unit as 'Unit', S.Country
from Products P, Suppliers S
where P.SupplierID = S.ID and S.Country = 'USA'

--14. Вивести назви товарів, імена(назви) клієнтів та назви постачальників товарів
select *from Orders
select *from Customers
select *from Suppliers
select *from Products
select *from OrderDetails

select P.ProductName as 'Product Name', C.CustomerName as 'Customer Name', S.SupplierName as 'SupplierName'
from Orders O, Customers C, Suppliers S, Products P, OrderDetails OD
where P.ID=OD.ProductID and C.ID = O.CustomerID and S.ID = P.SupplierID and O.ID = Od.OrderID


--15. Вивести назви постачальників морських продуктів(Seafood)
select *from Suppliers
select *from Products
select *from Category

select S.SupplierName as 'Supplier Name', P.ProductName as 'Product Name'
from Suppliers S, Products P, Category C
where P.CategoryID = C.ID and P.SupplierID = S.ID and C.CategoryName = 'Seafood'

--16. !!!!!!!!!Знайти скільки замовлень виконав певний перевізник(в умові вказувати назву перевізника, наприклад 'Speedy Express' )
select *from OrderDetails
select *from Orders
select *from Products
select *from Shippers

select COUNT(S.ID) as 'Count Shipper 4'
from Shippers S, OrderDetails OD, Orders O
where S.ID = O.ShipperId and O.ID = Od.OrderID and S.ShipperName='Shipper4'


--17. Вивести дані про замовлення (номер замовлення, назва клієнта, ім'я працівника, назва перевізника) за певний місяць певного року
select *from Orders
select *from Customers
select *from Shippers

select O.ID as 'ID Order', C.CustomerName as 'Customer Name', S.ShipperName as 'Shipper Name'
from Orders O, Customers C, Shippers S
where O.CustomerID = C.ID and O.ShipperId = S.ID and  MONTH(O.OrderDate) = 10 and YEAR(O.OrderDate) = 2003

--18. Вивести дані про виконані замовлення певного клієнта  (номер замовлення, назва клієнта, ім'я працівника, назва перевізника)
select *from Orders
select *from Customers
select *from Shippers
select *from Employees

select O.ID as 'ID Order', C.CustomerName as 'Customer Name', E.FirstName + ' '+ E.LastName as 'Employee' ,S.ShipperName as 'Shipper Name'
from Orders O, Customers C, Shippers S, Employees E
where O.CustomerID = C.ID and O.EployeeID = E.ID and O.ShipperId = S.ID and C.CustomerName = 'Lee'

--19. Вивести кількість замовлень певного клієнта( в умові вказувати назву клієнта)
select *from Orders
select *from Customers
select *from Shippers

select COUNT(O.ID) as 'Count Orders by Lee'
from Orders O, Customers C, Shippers S
where O.CustomerID = C.ID and O.ShipperId = S.ID and C.CustomerName = 'Anton'

--20. Знайти загальне число товарів замовлених певним клієнтом(в умові вказувати назву клієнта, наприклад 'Romero y tomillo'), тобто сумувати по полю quantity 
select *from Products
select *from Customers
select *from OrderDetails
select *from Orders

select sum(OD.Quantity) as 'Quantity products (Lee)'
from Products P, Customers C, Orders O, OrderDetails OD
where P.ID = OD.ProductID and C.ID=O.CustomerID and O.ID=OD.OrderID and C.CustomerName = 'Lee'

--21. Знайти загальну грошову  суму, на яку  замовив товарів  певний клієнт(в умові вказувати назву клієнта, наприклад 'Romero y tomillo')
select *from Products
select *from Customers
select *from OrderDetails
select *from Orders

select sum(OD.Quantity * P.Price) as 'Quantity products (Lee)'
from Products P, Customers C, Orders O, OrderDetails OD
where P.ID = OD.ProductID and C.ID=O.CustomerID and O.ID=OD.OrderID and C.CustomerName = 'Lee'

--22. Вивести кількість замовлень по кожному клієнту(показувати імена клієнтів)
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


--23. Вивести кількість замовлень по кожному клієнту, здійснені після вказаної дати
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


--24. Вивести кількість замовлень по кожному року(або місяцю, якщо дати в межах одного року)
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


--25. Вивести кількість замовлень по кожному клієнту, що здійснив більше 5 замовлень
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


--26. Вивести кількість товарів по кожному замовленню(sum)
select *from OrderDetails

select OD.OrderID as 'Order ID', sum(OD.Quantity) as 'Quantity'
from OrderDetails OD
group by OD.OrderID

--27. Знайти кількість товарів, які постачаються з кожної країни
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


--28. Вивести вартість (ціна продукту * кількість продукту) по кожному замовленню(sum)
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