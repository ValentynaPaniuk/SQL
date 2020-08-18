use Paniuk_Travel_Agency

select *from Position


insert into Position values ('Director')
insert into Position values ('Domestic tourism manager')
insert into Position values ('Foreign tourism manager')

select *from City
--Ukraine
insert into City values ('Kyiv', 1)
insert into City values ('Lviv', 1)
insert into City values ('Odessa', 1)
insert into City values ('Dnipro', 1)
insert into City values ('Lutsk', 1)
insert into City values ('Ternopil', 1)
insert into City values ('Ivano-Frankivsk', 1)
-- Italy
insert into City values ('Rym', 2)
insert into City values ('Milan', 2)
insert into City values ('Venecia', 2)
insert into City values ('Florencia', 2)
insert into City values ('Verona', 2)
insert into City values ('Neapol', 2)
insert into City values ('Bolonia', 2)

--France
insert into City values ('Paris', 3)
insert into City values ('Marseille', 3)
insert into City values ('Lyon', 3)
insert into City values ('Toulouse', 3)
insert into City values ('Nice', 3)
insert into City values ('Straßburg', 3)
insert into City values ('Bordo', 3)

--England
insert into City values ('London', 4)
insert into City values ('Manchester', 4)
insert into City values ('Birmingham', 4)
insert into City values ('Liverpool', 4)
insert into City values ('Cambridge', 4)
insert into City values ('Oxford', 4)
insert into City values ('Sheffield', 4)


--Georgia
insert into City values ('Tbilisi', 5)
insert into City values ('Batumi', 5)
insert into City values ('Kutaisi', 5)
insert into City values ('Poti', 5)
insert into City values ('Rustavi', 5)
insert into City values ('Ahalcha', 5)
insert into City values ('Telavi', 5)

--Poland
insert into City values ('Warszawa', 6)
insert into City values ('Kraków', 6)
insert into City values ('Wrocław', 6)
insert into City values ('Gdańsk', 6)
insert into City values ('Poznań', 6)
insert into City values ('Łódź', 6)
insert into City values ('Katowice', 6)

select *from Country
insert into Country values ('Ukraine')
insert into Country values ('Italy')
insert into Country values ('France')
insert into Country values ('England')
insert into Country values ('Georgia')
insert into Country values ('Poland')

--Customer
insert into Customer values ('Kateryna Koval',     '096-599-13-35', 'koval@gmail.com')
insert into Customer values ('Anastasia Petrenko', '096-288-14-25', 'petrenko@gmail.com')
insert into Customer values ('Ludmyla Proday',     '096-188-18-25', 'proday@gmail.com')
insert into Customer values ('Maria Kovalchuk',    '097-193-26-15', 'kovalchuk@gmail.com')
insert into Customer values ('Nina Savchuk',       '097-193-26-16', 'savchuk@gmail.com')
insert into Customer values ('Alla Sulzhuk',       '098-222-26-20', 'sulzhuk@gmail.com')
insert into Customer values ('Iryna Popova',       '099-288-20-18', 'popova@gmail.com')
insert into Customer values ('Oleksandr Overchuk', '063-125-96-45', 'overchuk@gmail.com')
insert into Customer values ('Luba Marchuk', '099-125-96-45', 'marchuk.Luba@gmail.com')
insert into Customer values ('Olena Marchuk', '099-125-96-46', 'marchuk.Olena@gmail.com')
insert into Customer values ('Victor Marchuk', '099-125-96-46', 'marchuk.Victor@gmail.com')

--Employee
select *from Position
select *from Employee

insert into Employee values ('Natali Lutsyk', 1,   '099-999-99-99', 'Go@anex.com',            '1980-03-08', '2000-06-01')
insert into Employee values ('Oleg Nechyporuk', 2, '095-555-55-55', 'GoWithOleg@anex.com',    '1983-05-08', '2000-07-01')
insert into Employee values ('Dmytro Babeshko', 3, '097-444-44-44', 'GoWithDmytro@anex.com',  '1985-05-08', '2001-08-12')
insert into Employee values ('Nina Ostapchuk', 3,  '093-666-66-66', 'GoWithNina@anex.com',    '1980-05-18', '2001-10-15')


--Transport
select *from Transport
insert into Transport values ('Plane')
insert into Transport values ('Bus')
insert into Transport values ('Train')
insert into Transport values ('Car')
insert into Transport values ('Ship')
insert into Transport values ('Yacht')

--Hotel
exec sp_rename 'CountryEmployee', 'TurEmployee'

truncate table Hotel

alter table CityHotel
drop FK__CityHotel__Hotel__07C12930

alter table CityHotel
add Foreign key(HotelID) References Hotel(ID)


update Hotel
Set HotelAddress = 'Piazza San Anselmo 2, Aventin, 00153 Rym'
where ID = 16

delete from Hotel
where ID = 20

--Hotel Kyiv
insert into Hotel values ('Khreshchatyk', 'Khreshchatyk Street, 14, Kyiv, 01001', '****', 1)
insert into Hotel values ('Ukraine', 'Institute Street, 4, Kyiv, 01001', '****', 1)

--Hotel Lviv
insert into Hotel values ('Lviv', 'Vyacheslava Chornovola, 7, Lviv, 79000', '****', 1)
insert into Hotel values ('Kryva Lyra', 'Kryva Lypa Passage 3A, Lviv, 79000', '****', 1)

--Hotel Odessa
insert into Hotel values ('Potemkinn', 'Mayakovskogo Lane 5, Odessa, 65082', '****', 1)
insert into Hotel values ('Alexandrovskiy', 'Alexandrovskiy Avenue 12, Odessa, 65045', '****', 1)
--Hotel Dnipro
insert into Hotel values ('Dnepropetrovsk', 'Sicheslavska Naberezhna street 33, Dnipro, 49000', '****', 1)
insert into Hotel values ('Bartolomeo', 'Naberezhnaya Pobedy 9B, Dnipro, 49094', '****', 1)
--Hotel Lutsk
insert into Hotel values ('Rhombus', '33, Danyla Halytskoho Street, Lutsk, 43000', '****', 1)
insert into Hotel values ('Versailles', 'Prezydenta Hrushevskoho Ave 2, Lutsk, 43000', '****', 1)
--Hotel Ternopil
insert into Hotel values ('Avalon Palace', 'Stepana Bandery Street 2, Ternopil, 46002', '***', 1)
insert into Hotel values ('Hotel Aquapark Alligator ', 'Gayova Street 29, Ternopil, 46001', '***', 1)
--Hotel Ivano-Frankivsk
insert into Hotel values ('Clubhouse', 'Tysmynska 220a /2 , Ivano-Frankivsk, 76494', '***', 1)
insert into Hotel values ('Grand Hotel Roxolana', 'Vulytsya Gryunvalʹdsʹka 7/9,Ivano-Frankivsk, 76000', '***', 1)

--Hotel Rym
insert into Hotel values ('Charme Spagna Boutique Hotel', '37 Via della Mercede, Spania, Rym, 00187', '***', 1)
insert into Hotel values ('San Anselmo', ' Piazza San Anselmo 2, Авентін, 00153 Rym', '****', 1)

--Hotel Milan
insert into Hotel values ('Hotel Milano Castello', 'Via San Tomaso 2, Centre Milan, 20121', '***', 1)
insert into Hotel values ('Room Mate Giulia', 'Silvio Pellico 4, Centre Milan, 20121', '***', 1)

--Hotel Venecia
insert into Hotel values ('Las Cabañas', '2km sur del Colegio de Venecia, 21005', '***', 1)
insert into Hotel values ('Villa Marsella', 'San Juan Barrio San Juan, 21005 Venecia', '***', 1)

--Hotel Florencia
insert into Hotel values ('C-hotels Joy', 'Via Degli Orti Oricellari 30, Florencia, 50123', '****', 1)
insert into Hotel values ('Hotel del Corso', 'Via del Corso, 1 nero/black, Florencia, 50123', '***', 1)

--Hotel Verona
insert into Hotel values ('Sole Hotel Verona', 'Piazzale XXV Aprile 4B, Verona, 37138', '****', 1)
insert into Hotel values ('Hotel Giulietta e Romeo ***S ', ' Vicolo Tre Marchetti 3, Verona, 37121', '***', 1)

--Hotel Neapol
insert into Hotel values ('Hotel Cristina', 'Via Diocleziano, 109, Fier Forig, Neapol, 80125', '***', 1)
insert into Hotel values ('Grand Hotel Vesuvio', 'Via Partenope 45, Lungmore , Neapol, 80121', '*****', 1)

--Hotel Bolonia
insert into Hotel values ('Albergo Elena', 'Via Garganelli 11/12, Bolonia 40065', '***', 1)
insert into Hotel values ('Hotel Fiera Wellness & Spa', 'Via Stalingrado 82, Bolonia 40128', '***', 1)

--Hotel Paris
insert into Hotel values ('La Planque Hotel', '3 Rue Arthur Groussier, Paris, 75010', '***', 1)
insert into Hotel values ('Jardins de Mademoiselle Hôtel & Spa', '15 rue, Paris, 75015', '****', 1)

--Hotel Marseille
insert into Hotel values ('Novotel Marseille Est', '184 Avenue de Saint Menet, Marsel, 13011', '****', 1)
insert into Hotel values ('Hotel La Girafe Marseille', 'Allée de la Colombe, Marsel, 13821', '****', 1)

--Hotel Lyon
insert into Hotel values ('Alter hostel', '32 QUAI ARLOING, 09. Lion, 69009', '****', 1)
insert into Hotel values ('Séjours & Affaires Lyon Park Lane', '43 Rue Du Sergent Berthet, 09. Lion, 69009', '****', 1)

--Hotel Toulouse
insert into Hotel values ('Residhome Toulouse Tolosa', '279 avenue Grande Bretagne, Toulouse 31300', '****', 1)
insert into Hotel values ('Hotel Palladia', '271 avenue de Grande Bretagne, Toulouse, 31300', '****', 1)

--Hotel Nice
insert into Hotel values ('Hotel 66 Nice', '6, rue de Belgique, Nice, 06000', '****', 1)
insert into Hotel values ('Hotel 64 Nice', '64 avenue Jean Médecin, Nice, 06000 ', '****', 1)

--Hotel Strasburg
insert into Hotel values ('Hotel Arok', '7- 8 Place de la Gare, Strasburg, 67000', '****', 1)
insert into Hotel values ('Okko Hotels Strasbourg Centre', '46, Rue du Bassin dAusterlitz, Strasburg, 67100', '****', 1)

--Hotel Bordo
insert into Hotel values ('my HOTEL Bordeaux', '1,rue de la blancherie, Bordo, 33370', '****', 1)
insert into Hotel values ('Cosy Appart', '19 rue Charles Perrault, Bordo, 33370', '****', 1)

--Hotel London
insert into Hotel values ('Britannia International Hotel', 'Marsh Wall, Isle of Dogs, London E14 9SJ', '****', 1)
insert into Hotel values ('Comfort Inn Hyde Park', '73 Queensborough Terrace, Bayswater, London W2 3SU', '****', 1)

--Hotel Manchester
insert into Hotel values ('Princess St. Hotel', '18-24 Princess Street, Manchester, M1 4LG', '****', 1)
insert into Hotel values ('Roomzzz Manchester City', '36 Princess Street, Manchester, M14JY', '****', 1)

--Hotel Birminghem
insert into Hotel values ('Tennant Street Residence', '98 Tennant Street, Birminghem, B15 1BS', '****', 1)
insert into Hotel values ('Jurys Inn Birmingham', ' 245 Broad Street, Birminghem, B1 2HQ', '****', 1)

--Hotel Liverpool
insert into Hotel values ('Travelodge Liverpool Central The Strand', 'The Strand, Liverpool L2 0PP', '***', 1)
insert into Hotel values ('Adelphi Hotel', 'Ranelagh St, Liverpool L3 5UL', '***', 1)

--Hotel Cambridge
insert into Hotel values ('Owlpen Manor Cottages', 'Owlpen Manor, Near Uley, Cambridge, GL11 5BZ', '***', 1)
insert into Hotel values ('Egypt Mill Hotel and Restaurant ', 'Stroud Rd, Nailsworth, Cambridge, GL6 0AE', '***', 1)

--Hotel Oxford
insert into Hotel values ('The Coach & Horses Inn', 'Watlington Road Chiselhampton, Oxford, OX44 7UX', '***', 1)
insert into Hotel values ('Clifton Hampden B&B', 'Abingdon Road, Clifton Hampden, OX14 3EG', '***', 1)

--Hotel Sheffield
insert into Hotel values ('Days Inn by Wyndham Sheffield M1', '71 High St.Sheffield S1 2GD', '***', 1)
insert into Hotel values ('The Three Merry Lads', '610 Redmires Rd, Sheffield S10 4LJ', '***', 1)

--Hotel Tbilisi
insert into Hotel values ('Shota Rustaveli Boutique Hotel', 'Shevchenko str. 1, Tbilisi 0108', '****', 1)
insert into Hotel values ('EZO Hotel', '12a Gabriel Isakadze Street, Tbilisi, 0160', '****', 1)

--Hotel Batumi
insert into Hotel values ('Hotel London', 'Giorgi Mazniashvili Street 52, Batumi, 60100', '****', 1)
insert into Hotel values ('Batumi Palm Hotel', '52 Lech and Maria Kaczynski Str, Batumi, 6000', '****', 1)

--Hotel Kutaisi
insert into Hotel values ('Balanchine', 'I.Gogebashvili str. 37, Kutaisi 4600', '****', 1)
insert into Hotel values ('Hotel Hollywood', 'Gr. Abashidze st 20, Kutaisi, 4600', '****', 1)

--Hotel Poti
insert into Hotel values ('Hotel Park Green', '181a Guria St., Poti, 4400', '****', 1)
insert into Hotel values ('Maltakva', 'Naberezhnaia Maltakva 7, Poti, 4400', '***', 1)

--Hotel Rustavi
insert into Hotel values ('Prestige','21 Merab Kostava Avenue, Rustavi, 3700', '**', 1)
insert into Hotel values ('Hotel Rustavi',' Megobroba Street 32, Rustavi, 3700', '***', 1)

--Hotel Ahalcha
insert into Hotel values ('Hotel Rio','7th microdistrict, Niko Lomouri Str, Ahalcha 3700', '**', 1)
insert into Hotel values ('Takuna','Leonidze Str 24buil 128flat, Ahalcha, 2400', '**', 1)
--Hotel Telavi
insert into Hotel values ('Farmers Guest House','10 300 Aragveli St, Telavi', '**', 1)
insert into Hotel values ('Tin-Tina Guesthouse','Bakhtrioni St, Telavi', '**', 1)

--Hotel Warszawa
insert into Hotel values ('PURO Warszawa Centrum','Ul. Widok 9, Warszawa, 00-023', '****', 1)
insert into Hotel values ('Four Points by Sheraton Warsaw Mokotow',' Suwak 7B, Мокотов, Warszawa, 02-676', '****', 1)

--Hotel Krakow
insert into Hotel values ('Metropolo by Golden Tulip Krakow','Ul. Orzechowa 11, Krakov, 30-422', '****', 1)
insert into Hotel values ('Hotel Unicus Palace','ul. Florianska 28 , Krakow, 31-020', '*****', 1)

--Hotel Wroclaw
insert into Hotel values ('Korona Hotel Wroclaw Market Square','2 Oławska, Wroclaw, 51-123', '****', 1)
insert into Hotel values ('DoubleTree by Hilton Wroclaw','Ul. Podwale 84, Wroclaw, 50-414', '*****', 1)

--Hotel Gdansk
insert into Hotel values ('Radisson Hotel & Suites, Gdansk','Chmielna 10-25, Gdansk, 80-748', '****', 1)
insert into Hotel values ('PURO Gdańsk Stare Miasto','Stągiewna 26, Gdansk, 80-750', '***', 1)

--Hotel Poznan
insert into Hotel values ('Hotel DeSilva Premium Poznań','5 Piekary, Poznan, 61-823', '***', 1)
insert into Hotel values ('City Park Hotel & Residence','Wyspiańskiego 26a, Poznan, 60-751', '*****', 1)

--Hotel Lodz
insert into Hotel values ('PURO Łódź Centrum','ul. Ogrodowa 16, Baluty, Lodz, 91-065', '***', 1)
insert into Hotel values ('Holiday Inn Łódź','ul. Piotrkowska 229, Srodmiescie, Lodz, 90-456', '***', 1)

--Hotel Katowice
insert into Hotel values ('Best Western Hotel Mariacki Katowice','Mariacka Tylna 15, Katowice, 40-014', '***', 1)
insert into Hotel values ('Q Hotel Plus Katowice','12 Wojewódzka, Katowice, 40-026', '****', 1)



alter table CityPlace
drop CK__ImagesPla__Image__6477ECF3

alter table CityPlace
alter column ImageNamePlace nvarchar(max) not null

alter table CityPlace
add check(ImageNamePlace<>'')

alter table CityPlace
add Foreign key(PlaceID) References Place(ID)

--National Museum of Taras Shevchenko
insert into Place values ('National Museum of Taras Shevchenko', 'Kiev, Shevchenko boulevard, 12.', 'Museum', 25)


--PinchukArtCentre
insert into Place values ('PinchukArtCentre', '1/3-2 Velyka Vasylkivska / Baseyna str., Kyiv', 'Galary', 200)

update City
Set CityName = 'Rome'
where ID = 8
--Kyiv Zoo
insert into Place values ('Kyiv zoo', '32 Peremohy., Kyiv', 'Zoo', 150)

alter table Place
add unique (NamePlace)

update Place
Set Details = 'Theater'
where ID = 4

--Lviv National Opera
insert into Place values ('Lviv National Opera', 'Lviv, Svobody Ave. 28', 'Opera', 300)

--Odessa Opera and Ballet Theater
insert into Place values ('Odessa Opera and Ballet Theater', '65026, Odessa','Theather', 300)

--Odessa Passage
insert into Place values ('Odessa Passage', 'on the main street of the Deribasivsky','Shop', 300)

--Сolosseum Rum
insert into Place values ('Colosseum', 'Rome','Monument of architecture', 0)

--Eiffel Tower
insert into Place values ('Eiffel Tower', 'Champ de Mars, 5 Avenue Anatole, Paris, 75007','Monument of architecture', 0)

select *from Place
select *from City
select *from CityPlace



insert into CityPlace values ('https://life.bodo.ua/interesnye-mesta/muzei/895-natsionalniy-muzey-tarasa-shevchenka-v-kieve', 1, 1)
insert into CityPlace values ('https://museum-portal.com/en/museum/national-museum-of-taras-shevchenko/', 1, 1)
insert into CityPlace values ('http://new.pinchukartcentre.org/en', 1, 2)
insert into CityPlace values ('https://uk.wikipedia.org/wiki/PinchukArtCentre', 1, 2)
insert into CityPlace values ('https://zoo.kiev.ua/en/', 1, 3)
insert into CityPlace values ('https://moemisto.ua/kiev/kiyivskiy-zoopark-kvitki-77548.html', 1, 3)
insert into CityPlace values ('https://opera.lviv.ua/en/contacts/', 2, 4)
insert into CityPlace values ('https://afisha.lviv.ua/theatre/lvivskyy-nacionalnyy-akademichnyy-teatr-opery-ta-baletu-im-solomiyi-krushelnyckoyi', 2, 4)
insert into CityPlace values ('http://opera.odessa.ua/en', 3, 5)
insert into CityPlace values ('https://leodessa.com/odessa-passage/', 3, 7)
insert into CityPlace values ('https://www.pizzatravel.com.ua/ukr/italy/40/roma', 8, 8)

insert into CityPlace values ('https://www.tripadvisor.ru/Attraction_Review-g187147-d188151-Reviews-Eiffel_Tower-Paris_Ile_de_France.html',15 , 9)


truncate table CityPlace

select *from CityHotel
insert into CityHotel values ('https://www.booking.com/', 1, 1)
insert into CityHotel values ('https://www.booking.com/', 2, 1)
insert into CityHotel values ('https://www.booking.com/', 3, 2)
insert into CityHotel values ('https://www.booking.com/', 4, 2)
insert into CityHotel values ('https://www.booking.com/', 5, 3)
insert into CityHotel values ('https://www.booking.com/', 6, 3)
insert into CityHotel values ('https://www.booking.com/', 7, 4)
insert into CityHotel values ('https://www.booking.com/', 8, 4)
insert into CityHotel values ('https://www.booking.com/', 9, 5)
insert into CityHotel values ('https://www.booking.com/', 10, 5)
insert into CityHotel values ('https://www.booking.com/', 11, 6)
insert into CityHotel values ('https://www.booking.com/', 12, 6)
insert into CityHotel values ('https://www.booking.com/', 13, 7)
insert into CityHotel values ('https://www.booking.com/', 14, 7)
insert into CityHotel values ('https://www.booking.com/', 15, 8)
insert into CityHotel values ('https://www.booking.com/', 16, 8)
insert into CityHotel values ('https://www.booking.com/', 17, 9)
insert into CityHotel values ('https://www.booking.com/', 18, 9)
insert into CityHotel values ('https://www.booking.com/', 19, 10)
insert into CityHotel values ('https://www.booking.com/', 20, 10)
insert into CityHotel values ('https://www.booking.com/', 21, 11)
insert into CityHotel values ('https://www.booking.com/', 22, 11)
insert into CityHotel values ('https://www.booking.com/', 23, 12)
insert into CityHotel values ('https://www.booking.com/', 24, 12)
insert into CityHotel values ('https://www.booking.com/', 25, 13)
insert into CityHotel values ('https://www.booking.com/', 26, 13)
insert into CityHotel values ('https://www.booking.com/', 27, 14)
insert into CityHotel values ('https://www.booking.com/', 28, 14)
insert into CityHotel values ('https://www.booking.com/', 29, 15)
insert into CityHotel values ('https://www.booking.com/', 30, 15)
insert into CityHotel values ('https://www.booking.com/', 31, 16)
insert into CityHotel values ('https://www.booking.com/', 32, 16)
insert into CityHotel values ('https://www.booking.com/', 33, 17)
insert into CityHotel values ('https://www.booking.com/', 34, 17)
insert into CityHotel values ('https://www.booking.com/', 35, 18)
insert into CityHotel values ('https://www.booking.com/', 36, 18)
insert into CityHotel values ('https://www.booking.com/', 37, 19)
insert into CityHotel values ('https://www.booking.com/', 38, 19)
insert into CityHotel values ('https://www.booking.com/', 39, 20)
insert into CityHotel values ('https://www.booking.com/', 40, 20)
insert into CityHotel values ('https://www.booking.com/', 41, 21)
insert into CityHotel values ('https://www.booking.com/', 42, 21)
insert into CityHotel values ('https://www.booking.com/', 43, 22)
insert into CityHotel values ('https://www.booking.com/', 44, 22)
insert into CityHotel values ('https://www.booking.com/', 45, 23)
insert into CityHotel values ('https://www.booking.com/', 46, 23)
insert into CityHotel values ('https://www.booking.com/', 47, 24)
insert into CityHotel values ('https://www.booking.com/', 48, 24)
insert into CityHotel values ('https://www.booking.com/', 49, 25)
insert into CityHotel values ('https://www.booking.com/', 50, 25)
insert into CityHotel values ('https://www.booking.com/', 51, 26)
insert into CityHotel values ('https://www.booking.com/', 52, 26)
insert into CityHotel values ('https://www.booking.com/', 53, 27)
insert into CityHotel values ('https://www.booking.com/', 54, 27)
insert into CityHotel values ('https://www.booking.com/', 55, 28)
insert into CityHotel values ('https://www.booking.com/', 56, 28)
insert into CityHotel values ('https://www.booking.com/', 57, 29)
insert into CityHotel values ('https://www.booking.com/', 58, 29)
insert into CityHotel values ('https://www.booking.com/', 59, 30)
insert into CityHotel values ('https://www.booking.com/', 60, 30)
insert into CityHotel values ('https://www.booking.com/', 61, 31)
insert into CityHotel values ('https://www.booking.com/', 62, 31)
insert into CityHotel values ('https://www.booking.com/', 63, 32)
insert into CityHotel values ('https://www.booking.com/', 64, 32)
insert into CityHotel values ('https://www.booking.com/', 65, 33)
insert into CityHotel values ('https://www.booking.com/', 66, 33)
insert into CityHotel values ('https://www.booking.com/', 67, 34)
insert into CityHotel values ('https://www.booking.com/', 68, 34)
insert into CityHotel values ('https://www.booking.com/', 69, 35)
insert into CityHotel values ('https://www.booking.com/', 70, 35)
insert into CityHotel values ('https://www.booking.com/', 71, 36)
insert into CityHotel values ('https://www.booking.com/', 72, 36)
insert into CityHotel values ('https://www.booking.com/', 73, 37)
insert into CityHotel values ('https://www.booking.com/', 74, 37)
insert into CityHotel values ('https://www.booking.com/', 75, 38)
insert into CityHotel values ('https://www.booking.com/', 76, 38)
insert into CityHotel values ('https://www.booking.com/', 77, 39)
insert into CityHotel values ('https://www.booking.com/', 78, 39)
insert into CityHotel values ('https://www.booking.com/', 79, 40)
insert into CityHotel values ('https://www.booking.com/', 80, 40)
insert into CityHotel values ('https://www.booking.com/', 81, 41)
insert into CityHotel values ('https://www.booking.com/', 82, 41)
insert into CityHotel values ('https://www.booking.com/', 83, 42)
insert into CityHotel values ('https://www.booking.com/', 84, 42)


select *from CityHotel
--select *from CityPlace    ЩЕ ДОДАТИ
--select *from Country
--select *from Customer
--select *from Hotel
--select *from Place   ЩЕ ДОДАТИ
--select *from Position
--select *from City
--select *from Transport
--select *from Tur
--select *from TurCity
--select *from TurCustomer
--select *from TurEmployee
--select *from Employee

insert into Tur values ('Italy-France', 10851, '2020-07-25', '2020-08-03', 2, 20)
insert into Tur values ('Italy-France', 10851, '2020-07-25', '2020-08-03', 2, 20)
insert into Tur values ('Italy-France', 10200, '2019-06-15', '2019-06-25', 2, 20)
insert into Tur values ('City of rendezvous - Krakow!', 1537, '2020-07-31', '2020-08-03', 2, 20)
insert into Tur values ('Odessa is the secret of the birth of a good mood', 1788, '2020-08-01', '2020-08-04', 2, 24)
insert into Tur values ('Kyiv', 550, '2020-08-06', '2020-08-07', 2, 25)
insert into Tur values ('Lviv', 550, '2020-08-06', '2020-08-07', 2, 25)
insert into Tur values ('Paris', 6000, '2020-09-06', '2020-09-12', 2, 20)
insert into Tur values ('Poland', 4300, '2020-09-01', '2020-09-12', 2, 20)
insert into Tur values ('Poland', 4300, '2018-03-01', '2018-03-12', 2, 15)



insert into Tur values ('Kyiv',550, '2020-07-22', '2020-07-24', 2, 20)
insert into Tur values ('Poland', 4000, '2020-07-22', '2020-07-26', 2, 10)
insert into Tur values ('Kyiv', 550, '2020-06-06', '2020-06-15', 2, 10)

insert into Tur values ('Paris', 5300, '2019-03-03', '2019-03-07', 2, 20)
insert into Tur values ('Krakow', 1337, '2019-07-31', '2019-08-03', 2, 20)

select *from Tur
select *from City
select *from TurCity



insert into TurCity values (1,8)
insert into TurCity values (1,9)
insert into TurCity values (1,10)
insert into TurCity values (2,37)
insert into TurCity values (3,3)
insert into TurCity values (4,1)
insert into TurCity values (5,2)
insert into TurCity values (6,15)
insert into TurCity values (7,36)
insert into TurCity values (7,37)
insert into TurCity values (7,38)
insert into TurCity values (8,1)
insert into TurCity values (9,39)
insert into TurCity values (10,1)
insert into TurCity values (11,15)
insert into TurCity values (12,37)

select *from Employee
select *from TurEmployee
insert into TurEmployee values (1,3)
insert into TurEmployee values (2,4)
insert into TurEmployee values (3,2)
insert into TurEmployee values (4,2)
insert into TurEmployee values (5,2)
insert into TurEmployee values (6,3)
insert into TurEmployee values (7,3)
insert into TurEmployee values (8,2)
insert into TurEmployee values (9,3)
insert into TurEmployee values (10,2)
insert into TurEmployee values (11,3)
insert into TurEmployee values (12,4)

select *from Tur
select *from Customer
select *from TurCustomer
insert into TurCustomer values (1,1,1)
insert into TurCustomer values (1,8,1)
insert into TurCustomer values (1,9,1)
insert into TurCustomer values (1,10,0)
insert into TurCustomer values (1,11,1)

insert into TurCustomer values (12,8,1)

insert into TurCustomer values (11,8,1)

insert into TurCustomer values (2,2,1)

insert into TurCustomer values (3,3,1)

insert into TurCustomer values (4,4,1)

insert into TurCustomer values (5,5,1)

insert into TurCustomer values (6,6)

insert into TurCustomer values (7,7)

insert into TurCustomer values (8,1,0)

insert into TurCustomer values (9,1,1)
insert into TurCustomer values (9,2,1)
insert into TurCustomer values (9,3,1)
insert into TurCustomer values (9,4,1)
insert into TurCustomer values (9,5,1)
insert into TurCustomer values (9,6,1)
insert into TurCustomer values (9,7,1)
insert into TurCustomer values (9,8,1)
insert into TurCustomer values (9,9,1)
insert into TurCustomer values (9,10,1)
insert into TurCustomer values (9,11,1)

select count (C.FullName) as CountInTur1
from Tur T join TurCustomer TC on T.ID=TC.TurID
           join Customer C on TC.CustomerID = C.ID
		   where T.ID=1
