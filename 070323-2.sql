-- KursDB ad�nda bir veritaban� olu�tural�m.
-- Ogrenciler (OgrenciID, OgrenciAdi, OgrenciSoyadi)
-- Dersler (DersID, DersAdi)
-- OgrencilerDersler (OgrenciID, DersID)
-- Yukar�daki tablolar� olu�tural�m. Daha sonra Ogrenciler ve Dersler tablolar�nda ilgili alanlar� PK ve Identity olarak i�aretleyelim.
-- OgrencilerDersler tablosunda iki alan� da se�ip PK olarak i�aretleyelim.-- ��renci ekleyelim�-- Ders ekleyelim

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
VALUES('Matematik'),('Kimya'),('Fizik'),('Yaz�l�m')




