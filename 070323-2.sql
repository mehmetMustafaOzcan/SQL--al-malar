-- KursDB adýnda bir veritabaný oluþturalým.
-- Ogrenciler (OgrenciID, OgrenciAdi, OgrenciSoyadi)
-- Dersler (DersID, DersAdi)
-- OgrencilerDersler (OgrenciID, DersID)
-- Yukarýdaki tablolarý oluþturalým. Daha sonra Ogrenciler ve Dersler tablolarýnda ilgili alanlarý PK ve Identity olarak iþaretleyelim.
-- OgrencilerDersler tablosunda iki alaný da seçip PK olarak iþaretleyelim.-- Öðrenci ekleyelim -- Ders ekleyelim

CREATE DATABASE KursDB2
CREATE TABLE Ogrenciler
(
OgrenciID INT IDENTITY ,
OgrenciAdi nvarchar(50),OgrenciSoyadi NVARCHAR(50)
)
CREATE TABLE DERSLER
(
DersID INT IDENTITY  PRIMARY KEY, DersAdi NVARCHAR(50)
)

ALTER TABLE Ogrenciler 
ADD PRIMARY KEY  (OgrenciID)

CREATE TABLE OgrencilerDersler
(OgrenciID int,DersID int
)

Alter Table OgrencilerDersler
Alter Column OgrenciID int not null
Alter Table OgrencilerDersler
Alter Column DersID int not null

Alter Table OgrencilerDersler
Add Primary Key(OgrenciID ,DersID) 


Alter Table OgrencilerDersler
ADD Foreign Key (OgrenciID) references Ogrenciler(OgrenciID)

Alter Table OgrencilerDersler 
ADD Foreign Key (DersID) references DERSLER(DersID)

Insert Ogrenciler(OgrenciAdi,OgrenciSoyadi)
values ('Mustafa','Ozcan'),('Ali','Ozan'),('Atkan','Bektas'),('Gokce','Han')

INSERT DERSLER(DersAdi)
VALUES('Matematik'),('Kimya'),('Fizik'),('Yazýlým')




