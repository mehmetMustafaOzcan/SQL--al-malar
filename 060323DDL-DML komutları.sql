--�al��anlar�m�n aras�nda ad�n�n ilk harfi A veya R olanlar� listeleyiniz...
SELECT*FROM Employees
WHERE FirstName LIKE ('A%') OR FirstName LIKE ('r%')

--aras�nda soyad�n�n i�inde A harfi ge�enleri listeleyelim...
SELECT *FROM Employees
WHERE LastName LIKE ('%A%')

--�al��anlar�m�n aras�nda ad� alfabetik olarak B ile S aras�nda olanlar� listeleyiniz...
SELECT * FROM Employees
 WHERE FirstName BETWEEN 'B' AND 'S' ORDER BY FirstName

 SELECT * FROM Employees
 WHERE FirstName LIKE '[B-S]%'

 --�al��anlar�m�n aras�nda ad�n�n i�inde A ve E harfi olan ve 
 --bu karakterler aras�nda yaln�zca 1 karakter olanlar� listeleyiniz...
SELECT *FROM Employees
WHERE FirstName LIKE ('%A_E%')

-- �al��anlar�m�n aras�nda ad�n�n i�inde A ve E harfi olan ve bu karakterler aras�nda 
--yaln�zca 2 karakter olanlar� listeleyiniz... (�rnek: AyfEr, AskEr gibi)ba�lam men�s� var

SELECT*FROM Employees
WHERE FirstName LIKE ('%A__E%')

SELECT*FROM Employees
WHERE FirstName LIKE'[^B]%'

--Employees tablosundan ID'si 2 ile 8 aras�nda olan �al��anlar�n bilgilerini,FirstName kolonuna g�re ARTAN s�rada s�ralay�n�z (A'dan Z'ye)
SELECT*FROM Employees
WHERE EmployeeID>=2 AND EmployeeID<=8 ORDER BY FirstName

--Employees tablosundan, �al��anlar�n, Ad�, Soyad�, Do�um tarihi bilgilerini, BirthDate kolonuna g�re ARTAN s�rada s�ralayarak listeleyiniz...

SELECT FirstName,LastName,BirthDate FROM Employees e
ORDER BY BirthDate DESC
-- 8.SORU Kategoriler tablosuna 'Meyveler' kategorisini, 'Mevsim meyveleri taze t�ketilirse faydal� olur.' a��klamas�yla birlikte ekleyiniz...ba�lam men�s� var
INSERT INTO Categories (CategoryName,[Description])
VALUES ('mEYVELER','Mevsim meyveleri taze t�ketilirse faydal� olur.')
SELECT * FROM Categories

update Categories
set CategoryName='Meyveler'
where CategoryID=9

-- 9.SORU Employees tablosuna kendi bilgilerinizi ekleyiniz.
SELECT * FROM Employees
INSERT INTO Employees (LastName,FirstName,Title,TitleOfCourtesy,BirthDate,HireDate,Address,City,Region,PostalCode,Country)
VALUES('�ZCAN','M.Mustafa','Full Stack Dev.','Mr.','1992-06-15',GETDATE(),'Alt�ndag','Ankara','�slam','06100','TR')
	
Insert Into Employees(LastName,FirstName,Title,TitleOfCourtesy)
VALUES
('�ZCAN','Ali','Gamer','Mr.') ,
('�ZCAN','Emre','Giri�imci.','Mr.') 

--�al��anlar tablosundan ID'si 7 olan �al��an�n soyad�n� g�ncelleyiniz...

Update Employees
set LastName='Deneme'
where EmployeeID=7

select * from Employees

-- 12.SORU �al��anlar tablosundaki b�t�n �al��anlar�n soyad�n� g�ncelleyiniz...
Update Employees
set LastName='Zcn'
 --�al��anlar tablosunda Unvan� 'Mr.' olanlar� 'Bay' olarak g�ncelleyiniz...
 Update Employees
 set TitleOfCourtesy='Bay'
 where TitleOfCourtesy='MR.'

 -- 14.SORU Bayan �al��anlar i�erisinde g�revi Sales Representative olanlar� Sat�� Temsilcisi olarak g�ncelleyiniz...
 update Employees
 set Title='Sat�� Temsilcisi'
 where TitleOfCourtesy LIKE 'MS.' OR TitleOfCourtesy LIKE 'MRS.' AND Title LIKE 'Sales Representative'

 -- 15.SORU �al��anlar tablosundan ID'si 5 olan �al��an� silelim...
 DELETE FROM Employees
 WHERE EmployeeID=5
 
 SELECT *INTO CALISANLAR
FROM Employees


SELECT *FROM CALISANLAR
DELETE FROM CALISANLAR  WHERE EmployeeID=5

--�al��anlar tablosundaki T�M verileri silelim...



-- 16.SORU �al��anlar tablosundan unvan� bayan olan �al��anlar� silmek istersek;
DELETE FROM CALISANLAR WHERE TitleOfCourtesy ='mS.' OR TitleOfCourtesy='MRS.'

TRUNCATE tABLE CALISANLAR

DROP TABLE CALISANLAR
