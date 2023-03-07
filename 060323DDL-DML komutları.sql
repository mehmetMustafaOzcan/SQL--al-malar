--Çalýþanlarýmýn arasýnda adýnýn ilk harfi A veya R olanlarý listeleyiniz...
SELECT*FROM Employees
WHERE FirstName LIKE ('A%') OR FirstName LIKE ('r%')

--arasýnda soyadýnýn içinde A harfi geçenleri listeleyelim...
SELECT *FROM Employees
WHERE LastName LIKE ('%A%')

--Çalýþanlarýmýn arasýnda adý alfabetik olarak B ile S arasýnda olanlarý listeleyiniz...
SELECT * FROM Employees
 WHERE FirstName BETWEEN 'B' AND 'S' ORDER BY FirstName

 SELECT * FROM Employees
 WHERE FirstName LIKE '[B-S]%'

 --Çalýþanlarýmýn arasýnda adýnýn içinde A ve E harfi olan ve 
 --bu karakterler arasýnda yalnýzca 1 karakter olanlarý listeleyiniz...
SELECT *FROM Employees
WHERE FirstName LIKE ('%A_E%')

-- Çalýþanlarýmýn arasýnda adýnýn içinde A ve E harfi olan ve bu karakterler arasýnda 
--yalnýzca 2 karakter olanlarý listeleyiniz... (Örnek: AyfEr, AskEr gibi)baðlam menüsü var

SELECT*FROM Employees
WHERE FirstName LIKE ('%A__E%')

SELECT*FROM Employees
WHERE FirstName LIKE'[^B]%'

--Employees tablosundan ID'si 2 ile 8 arasýnda olan çalýþanlarýn bilgilerini,FirstName kolonuna göre ARTAN sýrada sýralayýnýz (A'dan Z'ye)
SELECT*FROM Employees
WHERE EmployeeID>=2 AND EmployeeID<=8 ORDER BY FirstName

--Employees tablosundan, çalýþanlarýn, Adý, Soyadý, Doðum tarihi bilgilerini, BirthDate kolonuna göre ARTAN sýrada sýralayarak listeleyiniz...

SELECT FirstName,LastName,BirthDate FROM Employees e
ORDER BY BirthDate DESC
-- 8.SORU Kategoriler tablosuna 'Meyveler' kategorisini, 'Mevsim meyveleri taze tüketilirse faydalý olur.' açýklamasýyla birlikte ekleyiniz...baðlam menüsü var
INSERT INTO Categories (CategoryName,[Description])
VALUES ('mEYVELER','Mevsim meyveleri taze tüketilirse faydalý olur.')
SELECT * FROM Categories

update Categories
set CategoryName='Meyveler'
where CategoryID=9

-- 9.SORU Employees tablosuna kendi bilgilerinizi ekleyiniz.
SELECT * FROM Employees
INSERT INTO Employees (LastName,FirstName,Title,TitleOfCourtesy,BirthDate,HireDate,Address,City,Region,PostalCode,Country)
VALUES('ÖZCAN','M.Mustafa','Full Stack Dev.','Mr.','1992-06-15',GETDATE(),'Altýndag','Ankara','Ýslam','06100','TR')
	
Insert Into Employees(LastName,FirstName,Title,TitleOfCourtesy)
VALUES
('ÖZCAN','Ali','Gamer','Mr.') ,
('ÖZCAN','Emre','Giriþimci.','Mr.') 

--Çalýþanlar tablosundan ID'si 7 olan çalýþanýn soyadýný güncelleyiniz...

Update Employees
set LastName='Deneme'
where EmployeeID=7

select * from Employees

-- 12.SORU Çalýþanlar tablosundaki bütün çalýþanlarýn soyadýný güncelleyiniz...
Update Employees
set LastName='Zcn'
 --Çalýþanlar tablosunda Unvaný 'Mr.' olanlarý 'Bay' olarak güncelleyiniz...
 Update Employees
 set TitleOfCourtesy='Bay'
 where TitleOfCourtesy='MR.'

 -- 14.SORU Bayan çalýþanlar içerisinde görevi Sales Representative olanlarý Satýþ Temsilcisi olarak güncelleyiniz...
 update Employees
 set Title='Satýþ Temsilcisi'
 where TitleOfCourtesy LIKE 'MS.' OR TitleOfCourtesy LIKE 'MRS.' AND Title LIKE 'Sales Representative'

 -- 15.SORU Çalýþanlar tablosundan ID'si 5 olan çalýþaný silelim...
 DELETE FROM Employees
 WHERE EmployeeID=5
 
 SELECT *INTO CALISANLAR
FROM Employees


SELECT *FROM CALISANLAR
DELETE FROM CALISANLAR  WHERE EmployeeID=5

--Çalýþanlar tablosundaki TÜM verileri silelim...



-- 16.SORU Çalýþanlar tablosundan unvaný bayan olan çalýþanlarý silmek istersek;
DELETE FROM CALISANLAR WHERE TitleOfCourtesy ='mS.' OR TitleOfCourtesy='MRS.'

TRUNCATE tABLE CALISANLAR

DROP TABLE CALISANLAR
