CREATE DATABASE zcnHolding
CREATE TABLE Birim
(BirimNo INT PRIMARY KEY  IDENTITY NOT NULL,
BirimAd NVARCHAR(20) NOT NULL
)
CREATE TABLE Unvan
(UnvanNO INT PRIMARY KEY IDENTITY NOT NULL,
UnvanAd NVARCHAR(20) NOT NULL
)
CREATE TABLE Il
(IlID INT PRIMARY KEY IDENTITY NOT NULL,
IlAd NVARCHAR(20) NOT NULL
)

CREATE TABLE Ilce
(
IlceNo INT PRIMARY KEY IDENTITY NOT NULL,
IlceAd NVARCHAR(20),
IlID INT
)
ALTER TABLE Ilce
ADD FOREIGN KEY (IlID) REFERENCES Il(IlID);

CREATE TABLE Proje
(
ProjeID INT PRIMARY KEY IDENTITY NOT NULL,
BaslamaTarihi Date,
BitisTarihi Date
)
ALTER TABLE Proje
ADD ProjeAD nvarchar(10)

CREATE TABLE Personel
(PersonelTC BIGINT PRIMARY KEY NOT NULL,
PersonelAdi NVARCHAR(20),
PersonelSoyAdi NVARCHAR(20),
Cinsiyet NVARCHAR(5),
DogumTarihi Date,
BaslamaTarihi Date,
BirimNo INT,
UnvanNo INT,
Maas MONEY,
Prim MONEY
)
ALTER TABLE Personel
ADD FOREIGN KEY (BirimNo) REFERENCES Birim(BirimNo);
ALTER TABLE Personel
ADD FOREIGN KEY (UnvanNo) REFERENCES Unvan(UnvanNo);

INSERT  Birim(BirimAd)
VALUES('Hukuk'),('Finans'),('Pazarlama'),('Planlama'),('Proje Y�netimi')
INSERT Unvan(UnvanAd)
VALUES('M�hendis'),('IK Uzman�'),('Teknisyen'),('Mimar'),('Temizlik G�revlisi'),('M�d�r Yard�mc�s�'),('Asistan'),('Sekreter'),('Denetmen'),('M�d�r')

set identity_insert IL on
INSERT Il(IlID,IlAd)
VALUES(06,'Ankara'),(16,'Bursa'),(07,'Antalya'),(26,'Eski�ehir'),(34,'�stanbul'),(35,'�zmir'),(48,'Mu�la'),(10,'Bal�kesir'),(45,'Manisa'),(09,'Ayd�n')

INSERT Ilce(IlceAd,IlID)
VALUES('Polatl�',6),('MustafaKemalPa�a',06),('Edremit',10),('Kad�k�y',34),('Bornova',35),('Ortaca',48),('Didim',09),('Odun Pazar�',26),('Manavgat',7),('Soma',45)

INSERT Proje(ProjeAD,BaslamaTarihi,BitisTarihi)
VALUES('Ak�ll� �ehir Ankara
','2019-06-15','2024-12-10'),('Ak�ll� �ehir Ankara
','2018-10-15','2025-11-09'),('Ak�ll� �ehir Bursa

','2016-06-15','2035-12-10'),('Ak�ll� �ehir �stanbul
','2019-06-15','2023-12-12'),('Ak�ll� �ehir Eski�ehir
','2018-02-15','2024-06-10'),('Ak�ll� �ehir Mu�la
','2020-06-15','2024-09-10'),('Ak�ll� �ehir Ayd�n
','2019-06-15','2024-12-10'),('Ak�ll� �ehir Manisa
','2021-06-15','2023-12-12'),('Ak�ll� �ehir Bal�kesir
','2019-06-15','2024-12-10'),('Ak�ll� �ehir Antalya
','2018-07-15','2024-12-15')



CREATE TABLE IlProjeleri
(IlID INT FOREIGN KEY REFERENCES Il(IlID),
ProjeID INT FOREIGN KEY REFERENCES Proje(ProjeID)
)
ALTER TABLE Personel
ADD ProjeID INT FOREIGN KEY REFERENCES Proje(ProjeID);

INSERT Personel(PersonelTC,PersonelAdi,PersonelSoyAdi,Cinsiyet,DogumTarihi,BaslamaTarihi,Maas,Prim,BirimNo,UnvanNo,ProjeID)
VALUES(123478900,'MUSTAFA','OZCAN','ERKEK','1992-06-15','2017-10-10',25000,5000,1,1,1)

INSERT Personel(PersonelTC,PersonelAdi,PersonelSoyAdi,Cinsiyet,DogumTarihi,BaslamaTarihi,Maas,Prim,BirimNo,UnvanNo,ProjeID)
VALUES(123478922,'MEHMET','I�IK','ERKEK','1992-10-15','2018-09-20',20000,2000,2,1,2),(123478944,'MAHMUT','S�NMEZ','ERKEK','1995-12-15','2019-09-20',19000,1000,1,1,3),(123478966,'AHMET','I�IK','ERKEK','1993-09-15','2020-09-20',21000,2000,1,1,4),(123478988,'�SMA�L','DAYI','ERKEK','1989-10-15','2016-09-20',15000,2000,2,1,5),(123478100,'MUHAMMET','ATA','ERKEK','1992-10-15','2018-09-20',20000,2000,2,1,6),(123478122,'AL�','I�IK','�Z','1992-10-15','2018-09-20',20000,2000,3,4,7),(123478144,'VEL�','TEMEL','ERKEK','1992-10-15','2018-09-20',20000,2000,5,2,8),(123478166,'BURAK','KAL','ERKEK','1998-10-15','2018-09-20',20000,2000,3,6,9),(123478188,'ABDULLAH','ARI','ERKEK','1997-12-15','2015-09-20',9000,900,3,5,10)

