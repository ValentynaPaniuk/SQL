
--3
Create database Paniuk_MusicCollection
use Paniuk_MusicCollection

select *from Disk
select *from Style
select *from Singer
select *from Publisher
select *from Song
select *from DiskSong

--3.1
create table Disk
( ID int primary key identity,
  DiskName nvarchar(50) not null check(DiskName<>'') unique,
  SingerID int foreign key references Singer(ID),
  DiskDate date not null,
  StyleID int foreign key references Style(ID),
  PublisherID int foreign key references Publisher(ID),
);

INSERT INTO Disk values('Disk 2', 3, '2018-01-01', 4, 3, 'Classic')
INSERT INTO Disk values('Disk 3', 3, '2016-01-01', 1, 2, 'Classic')
INSERT INTO Disk values('My Disk', 3, '2020-01-01', 1, 2, 'Jazz')


--3.2
create table Style
( ID int primary key identity,
  StyleName nvarchar(50) not null check(StyleName<>'') unique,
 );

 insert into Style values ('Classical music')
 insert into Style values ('Jazz')
 insert into Style values ('Pop music')
 insert into Style values ('Dance music')
 insert into Style values ('Chamber music')

 --3.3
 create table Singer
 ( ID int primary key identity,
   SingerName nvarchar(50) not null check(SingerName<>'') unique,
 );
 
 insert into Singer values ('Beyonce')
 insert into Singer values ('Duffy')
 insert into Singer values ('Adele Adkins')
 insert into Singer values ('Okean Elzy')
 insert into Singer values ('Kazka')

 --3.4
 create table Publisher
 ( ID int primary key identity,
   PublisherName nvarchar(50) not null check(PublisherName<>'') unique,
   Country nvarchar(50) not null check(Country<>'')
 );

  insert into Publisher values ('Nash Format', 'Ukraine')
  insert into Publisher values ('Ranok', 'Ukraine')
  insert into Publisher values ('Osnova', 'Ukraine')


 --3.5
 create table Song
 (
 ID int primary key identity,
 SongName nvarchar(50) not null check(SongName<>'') unique,
 Duration time not null  check(Duration<>''),
 SingerID int foreign key references Singer(ID),
  );


   insert into Song values ('Pereval', '3:00:00',  4)
   insert into Song values ('Bez mezh', '4:25:12',  4)
   insert into Song values ('Hello', '4:10:00',  3)
   insert into Song values ('Rolling in Deep', '5:41:00',  3)
   insert into Song values ('Halo', '3:25:00', 1)

 
 create table DiskSong
 (
  ID int primary key identity,
  DiskID int foreign key references Disk(ID),
  SongID int foreign key references Song(ID),
 );

 insert into DiskSong values (1, 5)
 insert into DiskSong values (1, 4)
 insert into DiskSong values (1, 1)

--drop table Disk
--drop table Style
--drop table Singer
--drop table Publisher
--drop table Song
--drop table DiskSong


select *from Disk
select *from Style
select *from Singer
select *from Publisher
select *from Song
select *from DiskSong

--4.1 Додати до існуючої таблиці з інформацією про диск стовпчик з рецензією
alter table Disk
add Review varchar(30) null

--4.2 Додати до існуючої таблиці з інформацією про видавця совпчик з юридичним адресом
alter table Publisher
add Address varchar(30) null

--4.3 Змінити в уже створеній таблиці з інформацією про пісні розмір поля, що зберігає назву пісні
alter table Song
alter column SongName nvarchar(100)

--4.4 Видалити з вже існуючої таблиці з інформацією про видавця стовпчик з юридичним адресом
alter table Publisher
drop column Address

--4.5 Видалити зв'язок між таблицями Disk і Singer
alter table Disk 
drop constraint FK__Disk__SingerID__73BA3083

--4.6 Додати зв'язок між таблицями Disk і Singer
alter table Disk 
add constraint FK__Disk__SingerID__73BA3083 foreign key (SingerID) references Singer(ID)


--5. Створити наступні View:
--5.1 Відображення всіх стилів
create view View_Style as
select StyleName
from Style

--5.2 Відображення всіх видавців
create view View_Publisher as
select PublisherName
from Publisher

--5.3 Відображення повної інформації про диск: назва, виконавець, дата випуску, стиль, видавець
--variant 1
create view View_Disk as
select D.DiskName as 'DiskName', S.SingerName as 'Singer Name', D.DiskDate as 'Date', St.StyleName as 'Style', P.PublisherName as 'Publisher'
from Disk D, Singer S, Style St, Publisher P
where D.SingerID = S.ID and D.StyleID = St.ID and D.PublisherID = P.ID

--variant 2
create view View_Disk2 as
select D.DiskName as 'DiskName', S.SingerName as 'Singer Name', D.DiskDate as 'Date', St.StyleName as 'Style', P.PublisherName as 'Publisher'
from Disk D join Singer S on D.SingerID = S.ID join Style St on D.StyleID = St.ID join Publisher P on D.PublisherID=P.ID

