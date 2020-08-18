--1. Запланувати автоматичне резервне копіювання бази даних TravelAgency. 
-- Встановити розклад. Робити бекап раз в тиждень о 17 годині

--------jobs name Backup_Paniuk_Travel_Agency 
--------(Выполняется раз в неделю в воскресенье в 17:00:00. Расписание будет использоваться с 21.07.2020)

--2. Написати job, яка буде кожного дня о 9 ранку аналізувати доступні тури, 
-- та якщо дата початку туру співпадає з завтрашньою і немає бажаючих відвідати, то переносити такий тур в архів

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