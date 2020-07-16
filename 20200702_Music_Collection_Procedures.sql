use Paniuk_MusicCollection

select *from Disk
select *from Style
select *from Singer
select *from Publisher
select *from Song
select *from DiskSong


INSERT INTO Disk values('Disk 3', 3, '2016-01-01', 2, 2, 'Jazz')
INSERT INTO Disk values('My Disk', 3, '2020-01-01', 1, 1, 'Classic')
INSERT INTO Disk values('Disk 3', 4, '2020-07-01', 1, 1, 'Ukraine music')
INSERT INTO Disk values('Okean Elzy', 4, '2020-07-01', 1, 1, 'Ukraine music')

insert into DiskSong values (3, 6)
insert into DiskSong values (3, 7)
insert into DiskSong values (3, 8)

insert into DiskSong values (11, 7)
insert into DiskSong values (12, 8)
insert into DiskSong values (13, 8)



ALTER TABLE Disk DROP COLUMN DiskSongID;
ALTER TABLE Song DROP COLUMN StyleID;


--Процедури 
--1. Показує повну інформацію про диски
go
alter proc sp_InformationAllDisks
as
begin
 select  D.DiskName, S.SongName, Sg.SingerName,St.StyleName, D.DiskDate, P.PublisherName, D.Review
 from DiskSong DS, Disk D, Song S, Publisher P, Singer Sg, Style St
 where DS.DiskID = D.ID and DS.SongID=S.ID and P.ID=D.PublisherID and Sg.ID=D.SingerID and D.StyleID = St.ID
 
			 
end

exec sp_InformationAllDisks
go


--2. Повну інформацію про диски конкретного видавця. Назва видавця в параметрах
go
create proc sp_InformationDiskOnePublisher
@namePublisher nvarchar(50) 
as
begin
 
 select  D.DiskName, S.SongName, Sg.SingerName,D.DiskDate, P.PublisherName, D.Review
 from DiskSong DS, Disk D, Song S, Publisher P, Singer Sg
 where DS.DiskID = D.ID and DS.SongID=S.ID and P.ID=D.PublisherID and Sg.ID=D.SingerID and P.PublisherName = @namePublisher
 			 
end

exec sp_InformationDiskOnePublisher 'Ranok'
go

--3. !!!!!!!!!!!!! Показує назву самого популярного стилю
select *from Disk
select *from Style

go
alter proc sp_InformationAboutMostPopularStyle
as
begin
    select S.StyleName, COUNT(S.ID) as 'Count'
	from Style S join Disk D on S.ID = D.StyleID
	group by S.StyleName

end

exec sp_InformationAboutMostPopularStyle
go


--4. Популярність стилю визначається по кількості дисків в колекції

go
create proc sp_InformationAboutCountDisks
as
begin
    select S.StyleName, COUNT(S.ID) as 'Count'
	from Style S join Disk D on S.ID = D.StyleID
	group by S.StyleName

end

exec sp_InformationAboutCountDisks

--5. Відображає інформацію про диск конкретного стилю з найбільшою кількістю пісень.
-- Назва стиля передається в якості параметра, якщо передається слово all - вивід по всіх стилях
go
alter proc sp_InformationDiskOneStyle
@nameStyle nvarchar(50) 
as
begin
   if @nameStyle = 'All'
      begin
          select  D.DiskName, S.SongName, Sg.SingerName,D.DiskDate, St.StyleName, P.PublisherName, D.Review
          from DiskSong DS, Disk D, Song S, Publisher P, Singer Sg, Style St
          where DS.DiskID = D.ID and DS.SongID=S.ID and P.ID=D.PublisherID and Sg.ID=D.SingerID and D.StyleID=St.ID
      end
   else
       begin
          select  D.DiskName, S.SongName, Sg.SingerName,D.DiskDate, St.StyleName, P.PublisherName, D.Review
          from DiskSong DS, Disk D, Song S, Publisher P, Singer Sg, Style St
          where DS.DiskID = D.ID and DS.SongID=S.ID and P.ID=D.PublisherID and Sg.ID=D.SingerID and D.StyleID=St.ID and St.StyleName = @nameStyle
       end
end

exec sp_InformationDiskOneStyle 'Pop music'
go


--6. Видаляє всі диски певного стилю. Стиль передається в параметрі. Повертає кількість видалених альбомів
go
alter proc sp_DeleteDiskOneStyle
@nameStyle nvarchar(50), 
@count int out
as
set @count = 0
begin
     delete from D 
     from Style St join Disk D on St.ID=D.StyleID 
     where St.StyleName = @nameStyle
	 set @count = @count+1
end

declare @res int
exec sp_DeleteDiskOneStyle 'Jazz', @res output
Print 'Deleted: ' + ' '+ Convert (nvarchar(30), @res) + ' disks'

go


--7. Відображає інформацію про самий старий і самий новий диску
go
alter proc sp_InformatinOldYoungestDisk
as   
begin
     select D.DiskName, Min(D.DiskDate) as 'Oldest', Max(D.DiskDate) as 'Younger'
	 from Disk D
	 group by D.DiskName
   
end


exec sp_InformatinOldYoungestDisk 


--8. Видаляє всі диски, в назві яких є певне слово. Слово передається в параметри. 
-- Процедура повертає кількість видалених альбомів
go
alter proc sp_DeleteDiskWithSomeText
@nameDisk nvarchar(50)
as 
begin
delete from D 
from Disk D 
where D.DiskName LIKE '%' + @nameDisk + '%'
end

exec sp_DeleteDiskWithSomeText 'My Disk'
go