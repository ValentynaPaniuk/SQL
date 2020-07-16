use University

select * from subject
select * from groups
select * from Department

use master
select *
from sysdatabases

select * from vw_allStudent

-- Triggers
-- DML-triggers  - after, instead of
					-- insert, update, delete 
-- DDL triggers  all server, database   logon
					use University
go
	CREATE TRIGGER onInsertSubject
	ON dbo.Subject
	FOR insert
	as
		begin
			--@@rowcount  - global variable, show count of rows, that were added 
			raiserror('U added %d rows', 0, 1, @@rowcount)  -- raiserror(msg, severity, state) --- error message, where severity - user defined number 
			-- that shoe critical level of error (0-25)
		end
go

insert into Subject values ('Network programming', 1)

go
--create trigger onInsertStudent
--on Student
--for insert
--as
--	begin
--		select * from inserted
--	end
--go

-- ���������� �������� �������� � ����� � id = 6
alter trigger onInsertStudent
on Student
for insert
as
	begin
	-- �������� �� �����, ��� ���������� � �������
		declare @id int
		select @id = IdGroup from inserted
		-- inserted - ��������� ������ �������, ��� ���� � ������� ������� � ������ �������
		if @id = 6
			begin
				Print 'U cant add into group with id 6'
				-- rollback - ����� ������� (����� ����������) - �������� �� ���� �������� �� ����������: ��� ��� - ��� �����
				rollback
			end
	end
go

select * from Student

insert into Student values ('Nina', 'Petrenko', 1)

insert into Student values ('Karina', 'Liutko', 6)

go
-- �������� ������
enable trigger onInsertStudent on Student
go
-- ��������� ������
disable trigger onInsertStudent on Student
go


--create trigger onDeleteGroup
--on Groups
--instead of Delete
--as
--begin
--	select * from deleted
--end

-- ���������� �������� ����� ����������
alter trigger onDeleteGroup
on Groups
for Delete
as
begin
	declare @gr nvarchar(20)
	select @gr = Name from deleted
	if @gr Like 'Pr%'
		rollback transaction
	else
		print 'operation delete completed successfully'
end

delete from Groups
Where Name = 'D123'

go

--create trigger onChangeMark
--on Achievement
--for update
--as
--begin
--	-- inserted deleted
--	select * from deleted
--	select * from inserted

--end


-- ���������� ���������� �������, ���� ���� ������ ����� �� �����
-- ���������� ����������� ������, ���� �������� �� �����
alter trigger onChangeMark
on Achievement
for update
as
begin
	declare @old int, @new int
	select @old = Mark from deleted
	select @new = Mark from inserted

	if (@new < @old)
	begin
		Print 'New Mark can`t be less than old'
		rollback
	end
end

select * from Achievement

update Achievement
set Mark = 4
where Mark = 10

go

-- �������� ������������ ��������� �������
create trigger onAlterTable
on Database
for alter_table
as
begin
	PRINT 'operation can`t be finished. Call admin'
	rollback
end

alter table Subject
add description nvarchar(100)
go

disable trigger onAlterTable On Database

