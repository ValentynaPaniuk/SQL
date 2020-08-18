--Всі операції робили на локальному сервері
select name, recovery_model_desc from sys.databases

--підготовка до повного резервного копіювання
alter database Paniuk_Travel_Agency
set recovery full

--Створити backups BD
backup database Paniuk_Travel_Agency
to disk = 'D:\Backups\Backups.bak'


--відновити з архіву
use master
go
create database Paniuk_Travel_Agency 
restore database Paniuk_Travel_Agency
from disk = 'D:\Backups\Backups.bak'
with replace -- перезапис

use Paniuk_Travel_Agency

--створити логічний диск (шлях до архіву БД)
exec sp_addumpdevice 'disk','BackPath','D:\Backups\Travel_Agency.bak'

--видалити логічний шлях BackPath
exec sp_dropdevice BackPath

--переглянути всі backups
use master
select *from sys.backup_devices

backup database Paniuk_Travel_Agency to BackPath

--видалити БД
--use master
--go
--drop database Paniuk_Travel_Agency


exec  sp_addumpdevice 'disk','LogPath','D:\Logs\test.log'

--створити журнал безпеки
backup log Paniuk_Travel_Agency
to LogPath