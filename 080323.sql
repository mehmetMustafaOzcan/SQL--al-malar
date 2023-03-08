--1.SORu tablosunda tanýmlanacak 2 tamsayýnýn sonuç tablosunda görüntülenmesine ekrana verelim

DECLARE @SAYI INT;
DECLARE @SAYI2 INT;
SET @SAYI=5
SET @SAYI2=2
SELECT @SAYI+@SAYI2 AS 'TOPLAM'
 
-- 2.SORU Ýþe giriþ tarihi en eski olan çalýþanýmýn adý ve soyadýný adSoyad isimli bir deðiþkende tutarak ekrana yazdýrýnýz. (Northwind Employees tablosundan)

DECLARE @ADSOYAD NVARCHAR(50);
SET @ADSOYAD= (SELECT FirstName+' '+LastName FROM Employees WHERE HireDate= (SELECT MIN(HireDate) FROM Employees))
SELECT @ADSOYAD 'En Eski Çalýþan'

--
select top 1 FirstName+' '+LastName FROM Employees order by HireDate

SELECT FirstName,LastName FROM Employees WHERE HireDate= (SELECT MIN(HireDate)   FROM Employees) 

-- 3.SORU Employees tablosunda, çalýþanlarý, ülkelerine göre, ülke adý USA ise Amerika, UK ise Birleþik Krallýk, Türkiye ise Türkiye Cumhuriyeti ve eðer baþka bir deðer veya NULL ise Ülke Belirtilmedi þeklinde 'Ülkesi' kolon baþlýðý ile listeleyiniz...
INSERT Employees(FirstName,LastName, Country)
VALUES('MUSTAFA','OZCAN','TÜRKÝYE'),('ATAKAN','BEKTES',NULL)

SELECT*FROM Employees

SELECT Country, 
CASE 
WHEN COUNTRY LIKE 'USA' THEN 'AMERÝKA'
WHEN COUNTRY LIKE 'UK' THEN 'BÝRLEÞÝK KRALLIK'
WHEN COUNTRY LIKE 'TÜRKÝYE' THEN 'TÜRKÝYE CUMHURÝYETÝ'
ELSE 'Ülke Belirtilmedi'
end as 'Ülkesi'
FROM Employees;

-- 4.SORU negatif girelim girilen negatif bir deðeri pozitif olarak ekranda gösterelim
DECLARE @SAY INT =-10
PRINT ABS(@SAY)
-- 5.SORU Bir deðer giriþi yapalým girilen deðer negatif ise mutlak deðerini alalým deðil ise kendi deðerini ekrana yazdýralým

CREATE TABLE SAYILAR(SAYI INT )
INSERT SAYILAR (SAYI)
VALUES(5),(-10),(-20),(0)


DECLARE @_SAY INT =-10
SELECT @_SAY,
CASE
WHEN @_SAY>0 THEN @SAY
ELSE ABS(@_SAY)
END AS 'SAYÝ'
-- 6.SORU Çalýþanlarýn doðum tarihleri bilgilerini yýl, ay ve gün tablolarýnda ekranda gösterelim
-- Çalýþanlarýn Adý Soyadý ve Doðum tarihleri bilgiside gösterilecek

SELECT FirstName,LastName,YEAR(BirthDate)'YIL',MONTH(BirthDate)'AY',dAY(BirthDate)'GUN' FROM Employees

-- 7.SORU Çalýþanlarýn Yaþlarýný ekrana getirelim

Select FirstName,LastName,DATEDIFF(DAY,BirthDate, GETDATE()) from Employees

Select DATEDIFF(YEAR,'1995-02-22',GETDATE())

-- 8.SORU Çalýþanlarýmýn bugüne kadar kaç gündür çalýþtýklarýný bulalým
Select FirstName,LastName,DATEDIFF(DAY,HireDate, GETDATE())'çALIÞMA gÜNÜ' from Employees ORDER BY HireDate

-- Bugünden 2 gün sonrasýný ekrana yazdýralým
SELECT DATEADD(DAY,2,GETDATE())

-- 10.SORU a karakterinin ASCII kodundaki numarasýný bulalým
SELECT ASCII('A')

-- 11.SORU ASCII kodu 65 olan karakteri bulalým
SELECT CHAR(255)
-- 12.SORU Bilge Adam Akademi metni içerisinde ilk e harfinin yerinin sayýsýný bulalým
SELECT CHARINDEX('E','BÝLGEADAM')

-- 13.SORU Bilge Adam Akademi metnini Bilge Adam olarak ekrana yazdýralým

SELECT SUBSTRING('Bilge Adam Akademi',0,11) AS '110BÝN'

-- 14.SORU Bilge Adam Akademi metnini Akademi olarak ekrana yazdýralým
SELECT RIGHT('Bilge Adam Akademi',7)

-- 15.SORU Bilge Adam Akademi metninin karakter sayýsýný bulalým
SELECT LEN('Bilge Adam Akademi')

-- 16.SORU BÝLGE ADAM AKADEMÝ metnini küçük harflerle yazdýralým
SELECT LOWER('Bilge Adam Akademi')
--17. 16.SORU BÝLGE ADAM AKADEMÝ metnini BÜYÜK harflerle yazdýralým
SELECT UPPER('Bilge Adam Akademi')
--18.SORU                 Bilge Adam Akdemi              yazýsýný soldan boþluksuz yazalým
SELECT LTRIM('              Bilge Adam Akdemi                  ')
SELECT RTRIM('            Bilge Adam Akdemi              ')
SELECT TRIM('            Bilge Adam Akdemi              ')

-- 21.SORU Toplam çalýþan sayýsýný bulalým
SELECT COUNT(EmployeeID)FROM Employees

-- 22.SORU Çalýþanlarým, kaç farklý þehirden geliyor, bulalým.

SELECT COUNT(DISTINCT (City))'Farklý þehir sayýsý' FROM Employees 

--23.SORU Employees tablosundaki EmployeeID'lerin toplamý kaçtýr?

SELECT sum(EmployeeID)'EmployeeID lerin toplamý' FROM Employees

--24.SORU Employees tablosundaki EmployeeID'lerin ortalamasý kaçtýr?
SELECT avg(EmployeeID)'EmployeeID lerin ortalamasý' FROM Employees


SELECT*FROM Employees
