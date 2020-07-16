select * from Achievement
select * from Groups
select * from Student

insert into Achievement values (6, 2, 4)

select S.Name, G.Name as Groups, Sb.Name Subject, A.Mark
from Student S, Groups G, Achievement A, Subject Sb
where S.Id = A.IdStudent and G.Id = S.IdGroup and Sb.Id = A.IdSubject

-- ������� ����� ���� � �������� ������ � ����
select G.Name, min(A.Mark) as Mark
from Groups G, Achievement A, Student S
where G.Id = S.IdGroup and S.Id = A.IdStudent and Mark = (select min(Mark) from  Achievement)
group by G.Name

select G.Name, min(A.Mark) as Mark
from Groups G, Achievement A, Student S
where G.Id = S.IdGroup and S.Id = A.IdStudent
group by G.Name
Having min(A.Mark) > 5

select * from Teacher

-- ������� ����� ������, � ���� ���������� �������� �������
select BirthMonth, Max(CountTeacher) as MaxCountTeacher 
From 
	(
	--1)  �������� ����� �� ������� ����������, �� ���������� � ������� �����
	select Month(BirthDate) as BirthMonth, Count(Id) as CountTeacher
	From Teacher
	Group by Month(BirthDate)) as ResultTable
	-- ��������� �� �����, ��� �-��� ���������� ���������� ����������� �-�� � ������ (� �������� �������)
where CountTeacher = (
					-- 3) �������� ����������� ������� ���������� �� �������� ������� �emp
					  select Max(CountTeacher)
					  from 
							--2) ������� ����� �� ������� ����������, �� ���������� � ������� �����
							 (select Month(BirthDate) as BirthMonth, Count(Id) as CountTeacher
							 From Teacher
							 Group by Month(BirthDate)) as Temp)
group by BirthMonth

select * from Student

-- ������� ��� ��������, ��� �� �� ���� ����� � ������� Achievement
select S.Name, S.Surname
From Student S
Where Not Exists (Select * 
			  From Achievement
			  Where Achievement.IdStudent = S.Id)

