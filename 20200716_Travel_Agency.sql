go
use master
Create database Paniuk_Travel_Agency
drop database Paniuk_Travel_Agency
use Paniuk_Travel_Agency
go


--��� �������������� ��������� ������� ����� �� 80 ���� ���������� ������� ���� ������. 
--� ���� ������ ����� ������� ����� ����������:
--1. ��������� ������������
--	�. ���
--	b. ���������
--	c. ���������� ������� � email
--	d. ���� ����� �� ������

go
create table Position
(ID int primary key identity,
PositionName nvarchar(50) not null check(PositionName<>'')
)

go


select *from Employee
create table Employee
(
ID int primary key identity,
FullName nvarchar(50) not null,
PositionID int foreign key references Position(ID),
Phone nvarchar(50) not null,
Email nvarchar(30) not null unique,
BirthDate date not null check(BirthDate>'01.01.1970'),
EmploymentDate date not null check(EmploymentDate>'01.01.1990'),
)




--2. ����������, ������������� �� ������, ����
create table Transport
(ID int primary key identity,
TransportName nvarchar(50) not null check(TransportName<>'')
)


create table CountryEmployee
(
ID int primary key identity,
CountryID int foreign key references Country(ID),
EmployeeID int foreign key references Employee(ID)
)

create table Country
(ID int primary key identity,
CountryName nvarchar(50) not null check(CountryName<>'')
)

create table City
(ID int primary key identity,
CityName nvarchar(50) not null check(CityName<>''),
CountryID int foreign key references Country(ID)
)

create table TurCity
(ID int primary key identity,
 TurID int foreign key references Tur(ID),
 CityID int foreign key references City(ID)
)

--3. ����
--	a. �������� ����
--	b. ���������
--	�. ���� ������ � ���������
--	d. �������) ������������
--	�. ������ � ������ ���� (������� ���������� � ����� ���������)

create table Tur
(
ID int primary key identity,
TurName nvarchar(50) not null check(TurName<>''),
Cost money not null check(Cost>0),
StartDate date not null ,
EndDate date not null ,
TransportID int foreign key references Transport(ID),
check (StartDate < EndDate),
)

alter table Tur
add MaxCountCustomer int not null check(MaxCountCustomer<>'')


drop table Tur

create table CityPlace
(
ID int primary key identity,
ImageNamePlace nvarchar(50) not null check(ImageNamePlace<>''),
CityID int foreign key references City(ID),
PlaceID int foreign key references Place(ID)
)
exec sp_rename 'ImagesPlace', 'CityPlace'


create table Place
(
ID int primary key identity,
NamePlace nvarchar(50) not null check(NamePlace<>''),
CityID int foreign key references City(ID),
PlaceAddress  nvarchar(50) not null check(PlaceAddress<>''),
Details text
)

alter table Place
add CostPlace money


create table CityHotel
(
ID int primary key identity,
ImageNameHotel nvarchar(50) not null check(ImageNameHotel<>''),
HotelID int foreign key references Hotel(ID),
CityID int foreign key references City(ID)
)

alter table CityHotel
add Foreign key(HotelID) References Hotel(ID)


exec sp_rename 'ImagesHotel', 'CityHotel'

create table Hotel
(
ID int primary key identity,
HotelName nvarchar(50) not null check(HotelName<>''),
CityID int foreign key references City(ID),
HotelAddress  nvarchar(50) not null check(HotelAddress<>''),
Details text,
Active bit not null
)


create table Customer (
ID int primary key identity,
FullName nvarchar(30) not null,
Phone nvarchar(30) not null,
Email nvarchar(30) not null unique,
)

create table TurCustomer
(
ID int primary key identity,
TurID int foreign key references Tur(ID),
CustomerID int foreign key references Customer(ID),
Paid bit not null
)



--4. ��������������������� � ������ ����� �������� (���������� � ��������� ���� � ������������ �� �������������� �����)
--	�. ����������� ����������������������	
--	�. ���������� � ����������, ��� ����� �������� ������� � ����
--	�. ����������� ��������
--	d. ������ ��������, ���������� ���
--	�, ������������ ���������� �������� ��� ����
--	f. ������ ������������� ��������, ������� �������������� �����
--	g. ��� ����������, ����������� �� ���������� ���

--5. ������� ���������
--	�. ���
--	b. ���������� ������� � email
--	�. ���� ��������
--	d. ������� ���� �������
--	�. ������� ���� �������

--6. � ����� ����������� �����.

create table Archive
(
ID int primary key identity,
TurID int foreign key references Tur(ID),
CustomerID int foreign key references Customer(ID),
)