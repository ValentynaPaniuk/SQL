use SampleDb
​
select Gender, Salary from Employee
where Gender='Female' and Salary > 5000 and Salary < 10000
​
exec sp_helpindex Employee
​
-- Індекси - використовують для пошуку даних запитами по таблиці.
-- Пришвидшують пошук
​
 -- Clustered index:
 -- Визначають фізичний порядок даних в таблиці 
 -- один кластеризований індекс на таблицю
​
 drop index Employee.[PK__Employee__3214EC071E7AA885]   -- error
-- Якщо немає індексів, пошук відбувається за доп. повного табличного сканування table scan
 
-- некластеризований індекс (аналог - книга, що має зміст та пошук по термінах)
-- дані зберігаються в одному місці, індекси - в іншому, але мають вказівники на місце збереження даних
create  nonclustered index IX_Employee_Salary
on Employee (Salary Asc)  
​
create  nonclustered index IX_Employee
on Employee (Gender Asc, Salary Desc)  -- composite index
​
 set showplan_all off
​
 drop index Employee.IX_Employee
​
 -- Primary key неявно створює кластеризований індекс, а Unique constraint - некластеризований індекс.
​
-- Недоліки некласт. індексів:
-- 1) insert\delete\update - стають повільніші
-- 2) додатковий дисковий простір
Collapse


