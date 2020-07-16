use Paniuk_Hospital_New

--�������
--1. ������� ���������� ������� �����.
Go
Select * from Wards
Go
--2. ������� ������� � �������� ���� ������.
Go
Select Surname, Phone
from Doctors
Go
--3. ������� ��� ����� ��� ����������, �� ������� ������������� ������.
Go
Select Distinct FLOOR
from Wards
Go
--4. ������� �������� ����������� ��� ������ "Name of Disease" � ������� �� ������� ��� ������ "Severity of Disease".
Select Name as 'Name of Disease', Severity as 'Severity of Disease'
From Diseases
Go
--5. ������������ ��������� FROM ��� ����� ���� ������ ���� ������, ��������� ��� ��� ����������.
Select ID as '�', Building as '������', Financing as 'Գ����������', Name as '�����', Floor as '������'
from Departments
Go

Select ID as '�', Name as [��'�], Phone as '�������', Salary as '��', Surname as '�������', Premium as '�����'
from Doctors
Go

Select ID as '�', Building as '������', Floor as '������', Name as '�����'
from Wards
Go


--6. ������� �������� ���������, ������������� � ������� 5 � ������� ���� �������������� ����� 30000.
Select Name
from Departments
where Building=5 and Financing<30000
Go
--7. ������� �������� ���������, ������������� � 3-� ������� � ������ �������������� � ��������� �� 15000 �� 25000.
Select Name
from Departments
where Building = 3 and (Financing>=15000 and Financing<=25000)
Go
--8. ������� �������� �����, ������������� � �������� 4 � 5 �� 3-� �����.
Select Name, Building, Floor
from Wards
where (Building=4 or Building=5) and Floor=3
Go

--9. ������� �������� ������� � ����� �������������� ���������, ������������� � �������� 3 ��� 6 � ������� ���� �������������� ������ 11000 ��� ������ 25000.
Select Name, Financing,Building, Financing
from Departments
where (Building = 3 or Building = 6) and (Financing < 11000 or Financing > 25000)

--10. ������� ������� ������, ��� �������� (����� ������ � ��������) ��������� 15000.
Select Surname , Salary+ Premium
from Doctors
where Salary+Premium>15000;
Go
--11. ������� ������� ������, � ������� �������� �������� ��������� ����������� ��������.
Select Surname
from Doctors
where Salary/2>Premium*3

--12. ������� �������� ������������ ��� ����������, ���������� � ������ ��� ��� ������ � 12:00 �� 17:00.
Select Distinct Name
from Examinations
where (DayOfWeek=1 or DayOfWeek=2 or DayOfWeek=3) and (StartTime>='12:00' and EndTime<='17:00')
Go

--13. ������� �������� � ������ �������� ���������, ������������� � �������� 1, 3, 8 ��� 10.
Select Name
from Departments
where Building=1 or Building=3 or Building=8 or Building=10
Go

--14. ������� �������� ����������� ���� �������� �������,����� 1-� � 2-�.
Select Name
from Diseases
where Severity <> 1 and Severity <> 2 -- not in
Go

--15. ������� �������� ���������, ������� �� ������������� � 1-� ��� 3-� �������.
Select Name
from Departments
where Building <>1 and Building<>3
Go

--16. ������� �������� ���������, ������� ������������� � 1-� ��� 3-� �������.
Select Name
from Departments
where Building = 1 or Building = 3
Go

--17. ������� ������� ������, ������������ �� ����� "P"
Select Surname
from Doctors
where Surname like '[Pp]%'
Go


