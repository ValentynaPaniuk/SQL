--1. ����������� ����������� �������� ��������� ���� ����� TravelAgency. 
-- ���������� �������. ������ ����� ��� � ������� � 17 �����

--------jobs name Backup_Paniuk_Travel_Agency 
--------(����������� ��� � ������ � ����������� � 17:00:00. ���������� ����� �������������� � 21.07.2020)

--2. �������� job, ��� ���� ������� ��� � 9 ����� ���������� ������� ����, 
-- �� ���� ���� ������� ���� ������� � ����������� � ���� �������� �������, �� ���������� ����� ��� � �����

select *from TurCustomer
select *from Tur
select *from Archive

use Paniuk_Travel_Agency
insert into Archive 
	select T.ID, T.TurName, T.Cost, T.StartDate, T.EndDate, T.TransportID
	from  Tur T
	where T.StartDate = cast(getdate()-1 as date) and T.ID not in 
	                                                     (select TC.TurID  
														 from  TurCustomer TC) 
														 or T.ID in (select TC.TurID  
														 from  TurCustomer TC join Tur T on Tc.TurID = T.ID
														 where TC.Paid=0 and T.StartDate = cast(getdate()-1 as date))


truncate table Archive	
drop table Archive
		
create table Archive
(
ID int primary key identity,
TurID int not null,
TurName nvarchar(50) not null,
Cost money not null,
StartDate date not null ,
EndDate date not null ,
TransportID int foreign key references Transport(ID)
)