use Test
GO
select * from Employee
Go

-- DDL (create, drop, alter)
-- DML (insert, update, delete)

-- insert into table(...columns) values (...column values)  - ���������� ����� ���������� ���� �������
-- insert into table  values (...all column values)  - ���������� �� ������� �������� ���������� �������
insert into Employee(Name, Surname, Age, Position, Email) values(N'���', N'��������', 25, 'Counter', 'ann@gmai.com'),
							(N'���������', N'��������', 30, N'���������', Null)
Go
insert into Employee values (N'�����', N'����������', '1997-5-5', 23 ,N'����������', 25000,'ssss@gmail.com')
Go
delete from Employee  -- ���� ���� �������� ��� where - �� ��������� �� ������ � �������, ��� �� ������������� ID
where Id = 12 Or Id = 13

Go
	truncate table Employee   -- �������� ������� � ���������� ID � 1
Go

Update Employee
Set DateofBirth = '1998-6-23'
Where DateofBirth is null
Go
-- Update - ������� ������� Set - �������� ���� � �������� value   set column = value
Update Employee
Set Position = N'����������',
 Age = 33
Where Position = 'Admin'
Go
-- Distinct - ��� ���������
-- Top - ������ N �������
Select Distinct Top(2)  Position
From Employee
Order by Position Desc

/*
1) Select Position
	Distinct
	Order by
	Top
*/

Select Name, Age
From Employee
--Where Age >= 23 And Age <= 30
Where Age Between 24 And 30   -- ������� (�������� ����������� (>= <=))

Select Name, Surname, Position
From Employee
--Where Position = 'Counter' Or Position = 'Admin'
Where Position In ('Counter', 'Admin')   -- ��������� � �������

Select * From Employee
Where Email is not null -- �� ���� ������

Select  * from Employee
Where Name Like N'[����]%'

-- Like:  % - ������� �-��� �������
--        _  - ���� ������
--        [Variants (aAoO)]
--        %a    a%  a%o%a  (angora)
--        b%l_   (blablabla)