select * from Achievement
select * from Groups
select * from Student

insert into Achievement values (6, 2, 4)

select S.Name, G.Name as Groups, Sb.Name Subject, A.Mark
from Student S, Groups G, Achievement A, Subject Sb
where S.Id = A.IdStudent and G.Id = S.IdGroup and Sb.Id = A.IdSubject

-- вивести назви груп ≥ м≥н≥мальну оц≥нку в груп≥
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

-- ¬ибрати групи м≥с€ц≥в, в €ких народилось найб≥льше вчител≥в
select BirthMonth, Max(CountTeacher) as MaxCountTeacher 
From 
	(
	--1)  ¬ибираЇмо м≥с€ць та к≥льк≥сть викладач≥в, що народились в кожному м≥с€ц≥
	select Month(BirthDate) as BirthMonth, Count(Id) as CountTeacher
	From Teacher
	Group by Month(BirthDate)) as ResultTable
	-- обмеженн€ на р€дки, щоб к-сть викладач≥в дор≥внювала максимальн≥й к-ст≥ в групах (у внутр≥шн≥й таблиц≥)
where CountTeacher = (
					-- 3) ¬ибираЇмо максимальну к≥льк≥сть викладач≥в по внутр≥шн≥й таблиц≥ “emp
					  select Max(CountTeacher)
					  from 
							--2) √рупуЇмо м≥с€ць та к≥льк≥сть викладач≥в, що народились в кожному м≥с€ц≥
							 (select Month(BirthDate) as BirthMonth, Count(Id) as CountTeacher
							 From Teacher
							 Group by Month(BirthDate)) as Temp)
group by BirthMonth

select * from Student

-- ¬ибрати вс≥х студент≥в, про €к≥ не ≥снуЇ запис у таблиц≥ Achievement
select S.Name, S.Surname
From Student S
Where Not Exists (Select * 
			  From Achievement
			  Where Achievement.IdStudent = S.Id)

