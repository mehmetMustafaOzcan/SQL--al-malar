-- RestoranDB adýnda bir veritabaným olsun.
-- Musteriler, MusteriDetaylari ve Siparisler isimli tablolarým olsun. -- Musteriler Tablosu
    -- MusteriID (Primary Key (PK), Identity)
    -- MusteriAdi
    -- MusteriSoyadi 
-- MusteriDetaylari Tablosu
    -- MusteriID (Unique, Foreign Key (FK) -> 1e1 iliþkili (Musteriler tablosu MusteriID kolonu ile))
    -- Adres
    -- TelefonNo
    -- Sehir
    -- Ulke (Default olarak Türkiye olsun) -- Siparisler Tablosu
    -- SiparisID (PK, Identity)
    -- MusteriID (FK, 1eN iliþkili, Musteriler tablosu MusteriID kolonu ile)
    -- YemekSirketi
    -- Urun
    -- Adet
    -- BirimFiyat
    -- ToplamTutar ( BirimFiyat * Adet)
    -- SiparisTarihi ( O anki saati ve tarihi kaydedecek)
create database RestoranDB
CREATE TABLE Musteriler
(MusteriID int Primary Key  Identity,
     MusteriAdi nvarchar(20),
MusteriSoyadi nvarchar(20))

create table [MusteriDetaylari Tablosu]
(
	MusteriID int Foreign key (MusteriID) REFERENCES Musteriler UNIQUE,
    Adres nvarchar(200),
    TelefonNo int,
    Sehir nvarchar(15),
    Ulke NVARCHAR Default 'Türkiye'
)
ALTER TABLE [MusteriDetaylari Tablosu]
ALTER COLUMN Ulke NVARCHAR(10)

ALTER TABLE [MusteriDetaylari Tablosu]
ALTER COLUMN TelefonNo BIGint

     CREATE TABLE [Siparisler Tablosu]
(
    SiparisID INT PRIMARY KEY  Identity,
    MusteriID int FOREIGN KEY (MusteriID) REFERENCES Musteriler ,
    YemekSirketi NVARCHAR(50),
    Urun NVARCHAR(25),
    Adet INT,
    BirimFiyat MONEY NOT NULL,
    ToplamTutar AS (BirimFiyat *Adet),
    SiparisTarihi DATE Default GETDATE())
SELECT*FROM Musteriler
SELECT*FROM [MusteriDetaylari Tablosu]
--5 tane müþteri ekleyelim, her müþteri için de müþteri detaylarý ekleyelim
INSERT MUSTERÝLER(MusteriAdi,MusteriSoyadi)
VALUES
('Mustafa','ozcan'),('Atakan','Bektaþ'),('Burak','Özgür'),('Gökçehan','Bektaþ'),('Oðuz','Bektaþ')

INSERT [MusteriDetaylari Tablosu](MusteriID,TelefonNo,Adres,Sehir)
VALUES(1,5535335050,'MERKEZ','NEVÞEHÝR'),(2,5333333333,'ÇANKAYA','ANKARA'),
(3,5333333333,'ÇANKAYA','ANKARA'),
(4,5333333333,'SÝNCAN','ANKARA'),
(5,5333333333,'KEÇÝÖREN','ANKARA')



