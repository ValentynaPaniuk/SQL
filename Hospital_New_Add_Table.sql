use Paniuk_Hospital_New

create table Specializations
( ID int primary key identity,
  Name nvarchar(100) not null check(Name<>'')
);



drop table Specializations

create table DoctorsSpecializations
(ID int primary key identity,
 DoctorID int foreign key references Doctors(ID),
 SpecializationID int foreign key references Specializations(ID)
);

create table Vacations
(ID int primary key identity,
EndDate date not null,
StartDate date not null,
DoctorID int foreign key references Doctors(ID)
);

create table Sponsors
(ID int primary key identity,
Name nvarchar(100) not null default(0)
);


--Пожертви
create table Donations
(ID int primary key identity,
Amount money not null default(0),
Date date not null, 
SponsorsID int foreign key references Sponsors(ID),
DepartmentID int foreign key references Departments(ID)
);