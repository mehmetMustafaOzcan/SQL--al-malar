-- RestoranDB ad�nda bir veritaban�m olsun.
-- Musteriler, MusteriDetaylari ve Siparisler isimli tablolar�m olsun.�-- Musteriler Tablosu
��� -- MusteriID (Primary Key (PK), Identity)
��� -- MusteriAdi
��� -- MusteriSoyadi�
-- MusteriDetaylari Tablosu
��� -- MusteriID (Unique, Foreign Key (FK) -> 1e1 ili�kili (Musteriler tablosu MusteriID kolonu ile))
��� -- Adres
��� -- TelefonNo
��� -- Sehir
��� -- Ulke (Default olarak T�rkiye olsun)�-- Siparisler Tablosu
��� -- SiparisID (PK, Identity)
��� -- MusteriID (FK, 1eN ili�kili, Musteriler tablosu MusteriID kolonu ile)
��� -- YemekSirketi
��� -- Urun
��� -- Adet
��� -- BirimFiyat
��� -- ToplamTutar ( BirimFiyat * Adet)
��� -- SiparisTarihi ( O anki saati ve tarihi kaydedecek)
create database RestoranDB
CREATE TABLE Musteriler
(MusteriID int Primary Key  Identity,
���  MusteriAdi nvarchar(20),
MusteriSoyadi�nvarchar(20))

create table [MusteriDetaylari Tablosu]
(
	MusteriID int Foreign key (MusteriID) REFERENCES Musteriler UNIQUE,
��� Adres nvarchar(200),
��� TelefonNo int,
��� Sehir nvarchar(15),
��� Ulke NVARCHAR Default 'T�rkiye'
)
ALTER TABLE [MusteriDetaylari Tablosu]
ALTER COLUMN Ulke NVARCHAR(10)

ALTER TABLE [MusteriDetaylari Tablosu]
ALTER COLUMN TelefonNo BIGint

��� �CREATE TABLE [Siparisler Tablosu]
(
��� SiparisID INT PRIMARY KEY  Identity,
��� MusteriID int FOREIGN KEY (MusteriID) REFERENCES Musteriler ,
��� YemekSirketi NVARCHAR(50),
��� Urun NVARCHAR(25),
��� Adet INT,
��� BirimFiyat MONEY NOT NULL,
��� ToplamTutar AS (BirimFiyat *Adet),
��� SiparisTarihi DATE Default GETDATE())
SELECT*FROM Musteriler
SELECT*FROM [MusteriDetaylari Tablosu]
--5 tane m��teri ekleyelim, her m��teri i�in de m��teri detaylar� ekleyelim
INSERT MUSTER�LER(MusteriAdi,MusteriSoyadi)
VALUES
('Mustafa','ozcan'),('Atakan','Bekta�'),('Burak','�zg�r'),('G�k�ehan','Bekta�'),('O�uz','Bekta�')

INSERT [MusteriDetaylari Tablosu](MusteriID,TelefonNo,Adres,Sehir)
VALUES(1,5535335050,'MERKEZ','NEV�EH�R'),(2,5333333333,'�ANKAYA','ANKARA'),
(3,5333333333,'�ANKAYA','ANKARA'),
(4,5333333333,'S�NCAN','ANKARA'),
(5,5333333333,'KE���REN','ANKARA')



