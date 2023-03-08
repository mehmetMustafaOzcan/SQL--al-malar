--1.SORu tablosunda tan�mlanacak 2 tamsay�n�n sonu� tablosunda g�r�nt�lenmesine ekrana verelim

DECLARE @SAYI INT;
DECLARE @SAYI2 INT;
SET @SAYI=5
SET @SAYI2=2
SELECT @SAYI+@SAYI2 AS 'TOPLAM'
 
-- 2.SORU ��e giri� tarihi en eski olan �al��an�m�n ad� ve soyad�n� adSoyad isimli bir de�i�kende tutarak ekrana yazd�r�n�z. (Northwind Employees tablosundan)

DECLARE @ADSOYAD NVARCHAR(50);
SET @ADSOYAD= (SELECT FirstName+' '+LastName FROM Employees WHERE HireDate= (SELECT MIN(HireDate) FROM Employees))
SELECT @ADSOYAD 'En Eski �al��an'

--
select top 1 FirstName+' '+LastName FROM Employees order by HireDate

SELECT FirstName,LastName FROM Employees WHERE HireDate= (SELECT MIN(HireDate)   FROM Employees) 

-- 3.SORU Employees tablosunda, �al��anlar�, �lkelerine g�re, �lke ad� USA ise Amerika, UK ise Birle�ik Krall�k, T�rkiye ise T�rkiye Cumhuriyeti ve e�er ba�ka bir de�er veya NULL ise �lke Belirtilmedi �eklinde '�lkesi' kolon ba�l��� ile listeleyiniz...
INSERT Employees(FirstName,LastName, Country)
VALUES('MUSTAFA','OZCAN','T�RK�YE'),('ATAKAN','BEKTES',NULL)

SELECT*FROM Employees

SELECT Country, 
CASE 
WHEN COUNTRY LIKE 'USA' THEN 'AMER�KA'
WHEN COUNTRY LIKE 'UK' THEN 'B�RLE��K KRALLIK'
WHEN COUNTRY LIKE 'T�RK�YE' THEN 'T�RK�YE CUMHUR�YET�'
ELSE '�lke Belirtilmedi'
end as '�lkesi'
FROM Employees;

-- 4.SORU negatif girelim girilen negatif bir de�eri pozitif olarak ekranda g�sterelim
DECLARE @SAY INT =-10
PRINT ABS(@SAY)
-- 5.SORU Bir de�er giri�i yapal�m girilen de�er negatif ise mutlak de�erini alal�m de�il ise kendi de�erini ekrana yazd�ral�m

CREATE TABLE SAYILAR(SAYI INT )
INSERT SAYILAR (SAYI)
VALUES(5),(-10),(-20),(0)


DECLARE @_SAY INT =-10
SELECT @_SAY,
CASE
WHEN @_SAY>0 THEN @SAY
ELSE ABS(@_SAY)
END AS 'SAY�'
-- 6.SORU �al��anlar�n do�um tarihleri bilgilerini y�l, ay ve g�n tablolar�nda ekranda g�sterelim
-- �al��anlar�n Ad� Soyad� ve Do�um tarihleri bilgiside g�sterilecek

SELECT FirstName,LastName,YEAR(BirthDate)'YIL',MONTH(BirthDate)'AY',dAY(BirthDate)'GUN' FROM Employees

-- 7.SORU �al��anlar�n Ya�lar�n� ekrana getirelim

Select FirstName,LastName,DATEDIFF(DAY,BirthDate, GETDATE()) from Employees

Select DATEDIFF(YEAR,'1995-02-22',GETDATE())

-- 8.SORU �al��anlar�m�n bug�ne kadar ka� g�nd�r �al��t�klar�n� bulal�m
Select FirstName,LastName,DATEDIFF(DAY,HireDate, GETDATE())'�ALI�MA g�N�' from Employees ORDER BY HireDate

-- Bug�nden 2 g�n sonras�n� ekrana yazd�ral�m
SELECT DATEADD(DAY,2,GETDATE())

-- 10.SORU a karakterinin ASCII kodundaki numaras�n� bulal�m
SELECT ASCII('A')

-- 11.SORU ASCII kodu 65 olan karakteri bulal�m
SELECT CHAR(255)
-- 12.SORU Bilge Adam Akademi metni i�erisinde ilk e harfinin yerinin say�s�n� bulal�m
SELECT CHARINDEX('E','B�LGEADAM')

-- 13.SORU Bilge Adam Akademi metnini Bilge Adam olarak ekrana yazd�ral�m

SELECT SUBSTRING('Bilge Adam Akademi',0,11) AS '110B�N'

-- 14.SORU Bilge Adam Akademi metnini Akademi olarak ekrana yazd�ral�m
SELECT RIGHT('Bilge Adam Akademi',7)

-- 15.SORU Bilge Adam Akademi metninin karakter say�s�n� bulal�m
SELECT LEN('Bilge Adam Akademi')

-- 16.SORU B�LGE ADAM AKADEM� metnini k���k harflerle yazd�ral�m
SELECT LOWER('Bilge Adam Akademi')
--17. 16.SORU B�LGE ADAM AKADEM� metnini B�Y�K harflerle yazd�ral�m
SELECT UPPER('Bilge Adam Akademi')
--18.SORU���������������� Bilge Adam Akdemi������������� yaz�s�n� soldan bo�luksuz yazal�m
SELECT LTRIM('              Bilge Adam Akdemi                  ')
SELECT RTRIM('            Bilge Adam Akdemi              ')
SELECT TRIM('            Bilge Adam Akdemi              ')

-- 21.SORU Toplam �al��an say�s�n� bulal�m
SELECT COUNT(EmployeeID)FROM Employees

-- 22.SORU �al��anlar�m, ka� farkl� �ehirden geliyor, bulal�m.

SELECT COUNT(DISTINCT (City))'Farkl� �ehir say�s�' FROM Employees 

--23.SORU Employees tablosundaki EmployeeID'lerin toplam� ka�t�r?

SELECT sum(EmployeeID)'EmployeeID lerin toplam�' FROM Employees

--24.SORU Employees tablosundaki EmployeeID'lerin ortalamas� ka�t�r?
SELECT avg(EmployeeID)'EmployeeID lerin ortalamas�' FROM Employees


SELECT*FROM Employees
