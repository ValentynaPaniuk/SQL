--�� �������� ������ �� ���������� ������
select name, recovery_model_desc from sys.databases

--��������� �� ������� ���������� ���������
alter database Paniuk_Travel_Agency
set recovery full

--�������� backups BD
backup database Paniuk_Travel_Agency
to disk = 'D:\Backups\Backups.bak'


--�������� � ������
use master
go
create database Paniuk_Travel_Agency 
restore database Paniuk_Travel_Agency
from disk = 'D:\Backups\Backups.bak'
with replace -- ���������

use Paniuk_Travel_Agency

--�������� ������� ���� (���� �� ������ ��)
exec sp_addumpdevice 'disk','BackPath','D:\Backups\Travel_Agency.bak'

--�������� ������� ���� BackPath
exec sp_dropdevice BackPath

--����������� �� backups
use master
select *from sys.backup_devices

backup database Paniuk_Travel_Agency to BackPath

--�������� ��
--use master
--go
--drop database Paniuk_Travel_Agency


exec  sp_addumpdevice 'disk','LogPath','D:\Logs\test.log'

--�������� ������ �������
backup log Paniuk_Travel_Agency
to LogPath