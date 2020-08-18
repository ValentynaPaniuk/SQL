use Paniuk_Hospital_New

--������� 1. ��� ���� ������ �Hospital� ��������� ����� ��������:
--1. �������� ����� clustered (����������������) �������� ��� ��� ������, ��� ��� ����������

--��������������� - ���� �� ������� (Primary Key), ���������� � �������
exec sp_helpindex Departments
exec sp_helpindex Doctors
exec sp_helpindex Diseases
exec sp_helpindex DoctorsSpecializations
exec sp_helpindex Donations
exec sp_helpindex Examinations
exec sp_helpindex Specializations
exec sp_helpindex Sponsors
exec sp_helpindex Vacations
exec sp_helpindex Wards

--2. �������� ����� nonclustered (������������������) �������� ��� ��� ������, ��� ��� ����������
select *from Departments
go
CREATE NONCLUSTERED INDEX IX_Departments_Financing 
    ON dbo.Departments (Financing Desc);   
go


select *from Doctors
go
CREATE NONCLUSTERED INDEX IX_Doctors_Salary  
    ON dbo.Doctors (Salary Desc);   
go

select *from Donations
go
CREATE NONCLUSTERED INDEX IX_Donations_Amount
    ON dbo.Donations (Amount Desc);   
go

--3. ������ ����� �� ��� composite (�����������) ������� � ������ ��������� ���� ������ � ��������. ���� ��,
--�������� �������


alter table Departments
drop FK__Departmen__Docto__0F624AF8

alter table DoctorsSpecializations
drop FK__DoctorsSp__Docto__778AC167

alter table Donations
drop FK__Donations__Docto__0C85DE4D

alter table Examinations
drop FK__Examinati__Docto__09A971A2

alter table Vacations
drop FK__Vacations__Docto__7B5B524B

alter table Doctors
drop CK__Doctors__Name__5629CD9C

alter table Departments
add Foreign key(DoctorID) References Doctors(ID)
alter table DoctorsSpecializations
add Foreign key(DoctorID) References Doctors(ID)
alter table Donations
add Foreign key(DoctorID) References Doctors(ID)
alter table Examinations
add Foreign key(DoctorID) References Doctors(ID)
alter table Vacations
add Foreign key(DoctorID) References Doctors(ID)


alter table Doctors
alter column Name nvarchar(50) not null


select *from Diseases
go
CREATE NONCLUSTERED INDEX IX_Diseases_Name_Severity 
    ON dbo.Diseases (Name Desc, Severity Asc);   
go

select *from Doctors
go
CREATE NONCLUSTERED INDEX IX_Doctors_Name_Salary  
    ON dbo.Doctors (Name Asc, Salary Desc);   
go


select *from Donations
go
CREATE NONCLUSTERED INDEX IX_Donations_Date_Amount 
    ON dbo.Donations (Date Desc, Amount Asc);   
go


use Paniuk_MusicCollection
--������� 2. ��� ���� ������ ����������� ������� �� ������������� ������� ������ ���������, 
--�������� ��������� � ���������������� ������� ��������� ��������:
--1. �������� ����� clustered (����������������) �������� ��� ��� ������, ��� ��� ����������
exec sp_helpindex Disk
exec sp_helpindex DiskSong
exec sp_helpindex Publisher
exec sp_helpindex Singer
exec sp_helpindex Song
exec sp_helpindex Style

--2. �������� ����� nonclustered (������������������) �������� ��� ��� ������, ��� ��� ����������
select * from Disk
go
CREATE NONCLUSTERED INDEX IX_Disk_Date
    ON dbo.Disk (DiskDate Desc);   
go


--3. ������ ����� �� ��� composite (�����������) ������� � ������ ��������� ���� ������ � ��������. 
-- ���� ��, �������� �������

select *from Disk
go
CREATE NONCLUSTERED INDEX IX_Disk_Style
    ON dbo.Disk (DiskName Desc, StyleID Asc);   
go
