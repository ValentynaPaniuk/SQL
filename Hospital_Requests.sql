use Paniuk_Hospital_New

--Запросы
--1. Вывести содержимое таблицы палат.
Go
Select * from Wards
Go
--2. Вывести фамилии и телефоны всех врачей.
Go
Select Surname, Phone
from Doctors
Go
--3. Вывести все этажи без повторений, на которых располагаются палаты.
Go
Select Distinct FLOOR
from Wards
Go
--4. Вывести названия заболеваний под именем "Name of Disease" и степень их тяжести под именем "Severity of Disease".
Select Name as 'Name of Disease', Severity as 'Severity of Disease'
From Diseases
Go
--5. Использовать выражение FROM для любых трех таблиц базы данных, используя для них псевдонимы.
Select ID as '№', Building as 'Корпус', Financing as 'Фінансування', Name as 'Назва', Floor as 'Поверх'
from Departments
Go

Select ID as '№', Name as [Ім'я], Phone as 'Телефон', Salary as 'ЗП', Surname as 'Прізвище', Premium as 'Премія'
from Doctors
Go

Select ID as '№', Building as 'Корпус', Floor as 'Поверх', Name as 'Назва'
from Wards
Go


--6. Вывести названия отделений, расположенных в корпусе 5 и имеющих фонд финансирования менее 30000.
Select Name
from Departments
where Building=5 and Financing<30000
Go
--7. Вывести названия отделений, расположенных в 3-м корпусе с фондом финансирования в диапазоне от 15000 до 25000.
Select Name
from Departments
where Building = 3 and (Financing>=15000 and Financing<=25000)
Go
--8. Вывести названия палат, расположенных в корпусах 4 и 5 на 3-м этаже.
Select Name, Building, Floor
from Wards
where (Building=4 or Building=5) and Floor=3
Go

--9. Вывести названия корпуса и фонды финансирования отделений, расположенных в корпусах 3 или 6 и имеющих фонд финансирования меньше 11000 или больше 25000.
Select Name, Financing,Building, Financing
from Departments
where (Building = 3 or Building = 6) and (Financing < 11000 or Financing > 25000)

--10. Вывести фамилии врачей, чья зарплата (сумма ставки и надбавки) превышает 15000.
Select Surname , Salary+ Premium
from Doctors
where Salary+Premium>15000;
Go
--11. Вывести фамилии врачей, у которых половина зарплаты превышает троекратную надбавку.
Select Surname
from Doctors
where Salary/2>Premium*3

--12. Вывести названия обследований без повторений, проводимых в первые три дня недели с 12:00 до 17:00.
Select Distinct Name
from Examinations
where (DayOfWeek=1 or DayOfWeek=2 or DayOfWeek=3) and (StartTime>='12:00' and EndTime<='17:00')
Go

--13. Вывести названия и номера корпусов отделений, расположенных в корпусах 1, 3, 8 или 10.
Select Name
from Departments
where Building=1 or Building=3 or Building=8 or Building=10
Go

--14. Вывести названия заболеваний всех степеней тяжести,кроме 1-й и 2-й.
Select Name
from Diseases
where Severity <> 1 and Severity <> 2 -- not in
Go

--15. Вывести названия отделений, которые не располагаются в 1-м или 3-м корпусе.
Select Name
from Departments
where Building <>1 and Building<>3
Go

--16. Вывести названия отделений, которые располагаются в 1-м или 3-м корпусе.
Select Name
from Departments
where Building = 1 or Building = 3
Go

--17. Вывести фамилии врачей, начинающиеся на букву "P"
Select Surname
from Doctors
where Surname like '[Pp]%'
Go


