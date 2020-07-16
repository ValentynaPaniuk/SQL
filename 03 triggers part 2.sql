select * from Student
select * from Groups
select * from Subject
select * from Achievement
select * from TeachersGroups

-- � ��� ����������� �������� �� ����� � �����, ����� ������ ���� ��������
update Student
Set IdGroup = 2
where Id = 1

select * from History

--
-- ������������ ������� History
select S.Name, G.Name,  New
from History H , Student S, Groups G , 
				(select H.IdStudent HidStud, G.Name as New From History H join Groups G on G.Id = H.IdGroupNew Join Student S On H.IdStudent = S.Id) as result
where H.IdStudent = S.Id And G.Id = H.IdGroupOld  and HidStud = H.IdStudent
group by S.Name, G.Name,  New
go

alter trigger onUpdateStudentGroup
on Student
for update
as
begin
	declare @new int, @old int, @idStud int
	select @idStud = Id from deleted
	select @old = IdGroup  from deleted
	select @new = IdGroup from inserted

	insert into History values (@idStud, @old, @new)
	Print 'Student changed group'
end
go

create table History (
	Id int primary key identity,
	IdStudent int foreign key references Student(Id),
	IdGroupOld int foreign key references Groups(Id),
	IdGroupNew int foreign key references Groups(Id)
)

-- ������ �� �����, � ���� ��������� ����
-- 1   1  1  2
-- 1   1  2  1
-- select IdStudent, IdGroupOld
-- from History
-- where IdStudent = 1



-- ��� �������� �������� ������ � ����� ���������� ��� �����
create table Archieve (
	IdStudent int primary key,
	[Name] [nvarchar](20) NULL,
	[Surname] [nvarchar](30) NULL,
	[IdGroup] [int] NULL
)
alter table Archieve add Description nvarchar(100)

--------
go

create trigger onDeleteStudent
on Student
for delete
as
begin
	insert into Archieve(IdStudent, Name, Surname, IdGroup)
	select * from deleted
	print 'deleted student'
end

delete from Student
where Id = 17

select * from Archieve

