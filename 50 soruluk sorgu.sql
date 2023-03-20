--1-En �ok sat�� yapt���m m��terim hangisi


SELECT TOP 1 COUNT(O.CustomerID),O.CustomerID,C.CompanyName  from Orders O
JOIN Customers C ON C.CustomerID=O.CustomerID
GROUP BY O.CustomerID,C.CompanyName ORDER BY 1 DESC

--2-En �ok hangi sipari�ten para kazanm���m?
SELECT SUM(UnitPrice*Quantity*(1-Discount))'S�PAR�� TUTARI',OrderID FROM [Order Details]
GROUP BY OrderID ORDER BY 1 DESC

--3 2 ay �nce yapt���m sat��lar�n�n london �ehrinde ki x �r�n�n sat�� miktari


SELECT od.ProductID,p.ProductName,SUM(Quantity) FROM Orders o
join [Order Details] od on od.OrderID=o.OrderID
join Products p on p.ProductID=od.ProductID
WHERE DATEDIFF(MONTH,OrderDate,GETDATE())>2 AND ShipCity='London'
group by od.ProductID,p.ProductName

--4-son 2 y�l i�inde en �ok sat�lan �r�n ve en az sat�lan �r�n
SELECT TOP 1 SUM(Quantity),OD.ProductID,P.ProductName FROM Orders O
JOIN [Order Details] OD ON O.OrderID=OD.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
WHERE DATEDIFF(YEAR,(SELECT MAX(OrderDate) FROM Orders),OrderDate)<3 
GROUP BY OD.ProductID,P.ProductName ORDER BY 1 DESC

--5-y�l�n �al��an� kim en �ok sat�� yapan
SELECT TOP 1 COUNT(*),O.EmployeeID,FirstName,LastName FROM Orders O
JOIN Employees E ON E.EmployeeID=O.EmployeeID
GROUP BY O.EmployeeID,FirstName,LastName ORDER BY 1 DESC

--6: Tedarik�i id si 1 ile 5 olan tedarik�ilerden al�nan �r�nlerin ad�n� ve stok say�s�n� g�steren sorgu.
SELECT*FROM Products
WHERE SupplierID LIKE 1 OR SupplierID LIKE 5 
--7: Stok say�s� kritik olan 10 �r�n�n tedarik�ilerinin ad�n� yazd�r�n.
SELECT ProductName,UnitsInStock,CompanyName FROM Products P
JOIN Suppliers S ON S.SupplierID=P.SupplierID
WHERE UnitsInStock<5 AND Discontinued=0
--8:Esparta b�lgesine g�nderilen en �ok 5 �r�n� listele.

SELECT sum(Quantity), OD.ProductID,P.ProductName FROM ORDERS O
JOIN [Order Details] OD ON  OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
WHERE ShipRegion LIKE '%ESPARTA%' 
GROUP BY OD.ProductID ,P.ProductName
ORDER BY 1 DESC

--9: En �ok �r�n alan m��teriye sat�� yapan personeller kimdir listele.
SELECT COUNT(*)'ALDI�I S�PAR��',O.CustomerID'EN �OK �R�N ALAN M��TER�', O.EmployeeID,LastName FROM Orders O
JOIN Employees E ON E.EmployeeID=O.EmployeeID
WHERE CustomerID =(SELECT  TOP 1 CustomerID FROM Orders O JOIN [Order Details] OD ON OD.OrderID=O.OrderID GROUP BY CustomerID ORDER BY SUM(Quantity) DESC)
GROUP BY O.EmployeeID,LastName,O.CustomerID

--10: En �ok hangi kategori t�r�nde sat�� olmustur.
SELECT TOP 1 SUM(Quantity),P.CategoryID,CategoryName FROM Products P
JOIN [Order Details] OD ON OD.ProductID=P.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID
GROUP BY P.CategoryID,CategoryName ORDER BY 1 DESC

--11- Ship PostalCode'u sadece say�lardan olu�mayan sipari�ler
SELECT ShipPostalCode FROM Orders
WHERE ShipPostalCode LIKE '%[^0-9]%'
--12- ContactTitle'a g�re s�ralanm�� ve Kendi i�inde de s�ralanm�� tedarik�ilerin adres �ehir ve b�lgeleri tek kolonda, kolon ad� Adres
SELECT Address+Country+Region,ContactTitle FROM Customers
ORDER BY ContactTitle
--13- En ucuz sipari� kaleminin tutar�
SELECT TOP 1 SUM(Quantity*UnitPrice*(1-Discount)) TUTAR,OrderID FROM [Order Details]
GROUP BY OrderID ORDER BY 1

--14- Ad�nda a ve e harfi birlikte bulunan �al��anlar�n ya�a g�re s�ralanm�� halde bilgileri, ad� ve soyad� Ad Soyad kolon ad�yla gelecek
SELECT FirstName,LastName,BirthDate FROM Employees
WHERE FirstName LIKE '%a%E%'OR FirstName LIKE '%E%A%'
ORDER BY BirthDate DESC
--15- ��e girdi�inde ya�� en gen� olan top 3 �al��an
SELECT TOP 3 *FROM Employees
ORDER BY DATEDIFF(YEAR,BirthDate,HireDate)

--16:5 numaral� �al��an�n yapt��� sat��lar�n toplam �creti ne kadard�r.
SELECT SUM(Quantity*UnitPrice*(1-Discount)) FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
WHERE EmployeeID=5
GROUP BY EmployeeID

--17:Kategorisi 1,3,5,7 olan �r�nleri �r�n isimlerine g�re listeleyiniz.
SELECT*FROM Products
WHERE CategoryID = 1 OR CategoryID = 3 OR CategoryID =5 OR CategoryID =7
ORDER BY ProductName
--18: 5 numaral� �r�n� 2 numaral� kargocuya ta��tan m��terileri g�steriniz
SELECT*FROM Products P
JOIN Suppliers S ON S.SupplierID=P.SupplierID
WHERE ProductID=5 AND S.SupplierID=2
--19: Chai �r�n�n� en �ok alan m��terileri ve �denen fiyat� azalan �ekilde listeleyiniz.
SELECT SUM(Quantity) ,C.CompanyName,O.CustomerID FROM [Order Details] OD
JOIN Orders O ON O.OrderID=OD.OrderID
JOIN Products P ON OD.ProductID=P.ProductID
JOIN Customers C ON C.CustomerID=O.CustomerID
WHERE ProductName='Chai'
GROUP BY O.CustomerID,C.CompanyName ORDER BY 1 DESC


--20:�r�n ad� cha ile ba�layan ve 4 harften olu�an �r�nleri sorgusunu yaz�n�z.
SELECT*FROM Products
WHERE ProductName LIKE 'CHA_'
--21-Tekrar sipari� etme seviyesi 25'ten fazla olan �r�nlerden birim fiyat� en y�ksek olan ilk 3 �r�n�n �r�n ad� ve birim fiyat�n� g�sterin
SELECT TOP 3 *FROM Products
WHERE ReorderLevel>25
ORDER BY UnitPrice DESC
--22-sipari� tarihi 01.01.1997 den �nce olan sipari�lerden b�lge bilgisi bo� olmayan ve �lkesi Meksika olan sipari�lerin sipari� idsi tarihi ve �lkesini listeleyin
SELECT OrderID,ShippedDate,ShipCountry FROM Orders
WHERE OrderDate< '1997-01-01' AND ShipRegion IS NOT NULL AND ShipCountry='Mexico'


--23-stoklar� 10 ve 50 aras�nda olan �r�nlerin indirim yap�lmayanlar�n�n birim fiyatlar�n� azdan �o�a do�ru listeleyin.
SELECT P.ProductID,ProductName, P.UnitPrice FROM Products P
JOIN [Order Details] OD ON OD.ProductID=P.ProductID
WHERE UnitsInStock BETWEEN 10 AND 50
AND Discount=0
GROUP BY P.ProductID,P.UnitPrice,ProductName
ORDER BY P.UnitPrice


--24-4 numaral� kategoriye ait olan birim fiyat� 10'dan b�y�k olan �r�nlerin ismini ve fiyat�n� fiyat �oktan aza s�ralanacak �ekilde listeleyin

SELECT ProductName,UnitPrice FROM Products
WHERE CategoryID=4 AND UnitPrice>10
ORDER BY UnitPrice DESC
--25-m��teri ismi T ile ba�layan ve �lkesi USA olan m��terilerin m��teri ismi ve telefon numaralar�n� listeleyin
SELECT*FROM Customers
WHERE CompanyName LIKE 'T%' AND Country='USA'

--26-En �ok sipari� veren m��teri bilgileri listele
SELECT*FROM Customers
WHERE CustomerID=( SELECT TOP 1 Orders.CustomerID FROM Orders
JOIN Customers C ON C.CustomerID=Orders.CustomerID
GROUP BY ORDERS.CustomerID ORDER BY COUNT(*) DESC)
--27-UnitPrice � 15 ile 100 aras�nda olan, devam ettirilen �r�nlerin ad� ve fiyat bilgilerini fiyata g�re artan sekilde s�ralay�n
SELECT*FROM Products
WHERE UnitPrice BETWEEN 15 AND 100 AND Discontinued=0
--28-1 numaral� kargo ile Cork sehrine g�nderilen veya ta��ma �creti 111 den k���k olanlar�n siparis tarihini ve g�nderim tarihlerini listeleyin

SELECT  OrderDate,ShippedDate FROM Orders
WHERE ShipVia=1 OR Freight<111
--29-Tedarikci ad�n�n 2. harfi a veya e olan ve sonu n veya s ile bitmeyenlerin listesi
SELECT *FROM Suppliers
WHERE (CompanyName LIKE '_[AE]%') AND CompanyName LIKE '%[^NS]' 
--30-Sales Representative  lerin ad ve soyadlar�n� bir kolonda, i�e girisinden sonra ge�en g�n� 'Ge�en G�n' kolonunda g�sterip s�ralamay� ge�en g�ne g�re artan yap�n
select*from [dbo].[Employees]
--31-personelleri ya� s�ralamas� yap�p 25ten b�y�k olanlar�n �nvan kolonu a��p usta k���kse ��rak yazs�n
--32-personellerin ya��n� hesaplay�p ayr� bir ya� kolonunda yaz�n
ALTER TABLE Employees
ADD YAS INT 
UPDATE Employees
SET YAS =  DATEDIFF(YEAR,BirthDate,GETDATE()) 

SELECT*FROM Employees
--33-�r�n tablosundan categorisi 2 olanlar�n stoklar�n� 10 ar artt�rarak yenileyelim ve indirim uygulayal�m
UPDATE Products
SET UnitsInStock=UnitsInStock+10
WHERE CategoryID LIKE 2

--34-�r�n stoklar� 100�n �zerinde olanlar�a indirim uygulay�p birim fiyat�n�da 1$ d���relim
update Products
set UnitPrice=1
where UnitsInStock>100

SELECT*FROM Products

--35-costumers tablosundaki country kolonunda mexico yerine siesta yazal�m
update Customers
set Country='Siesta'
where Country='Mexico'

SELECT*FROM Customers

--36-En �ok satilan 10 �r�n�n kategorileri
SELECT TOP 10 SUM(Quantity) ,OD.ProductID,P.CategoryID FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID 
GROUP BY OD.ProductID,P.CategoryID ORDER BY 1 DESC

--37-1997 Ocak ay�nda en �ok al��veri� yapan m��terinin en �ok ald��� �r�n�n indirim oran�

SELECT count(*),CustomerID FROM Orders o
WHERE OrderDate > '1997-01-01' AND  OrderDate < '1997-02-01'
GROUP BY CustomerID ORDER BY 1 DESC

--38-1996 y�l�n�n en �ok satilan �r�n�n �lkesi ve totalprice
SELECT TOP 1 SUM(Quantity) as Sat�lanAdet,OD.ProductID,S.Country,sUM(Quantity*od.UnitPrice*(1-Discount)) as ToplamFiyat FROM Orders O
JOIN [Order Details] OD ON O.OrderID=OD.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Suppliers S ON S.SupplierID=P.SupplierID
WHERE OrderDate>'1996-01-01' AND OrderDate<'1997-01-01'
GROUP BY OD.ProductID,S.Country ORDER BY 1 DESC --EN �OK SATILAN �LKEN�N TEDAR�K ED�LD��� �LKE

SELECT TOP 1 O.ShipCountry, SUM(OD.Quantity)  AS TotalQuantity,SUM(Quantity*UnitPrice*(1-Discount))AS TotalPrice
FROM [Order Details] OD
JOIN Orders O ON O.OrderID = OD.OrderID
WHERE O.OrderDate >= '1996-01-01' AND O.OrderDate < '1997-01-01'
GROUP BY O.ShipCountry
ORDER BY TotalQuantity DESC; --EN �OK SATILAN �R�N�N �LKES�

--39-Stok miktari 20 alt�na d��en �r�nlerin tedarik�ilerinin telefon numalar�
SELECT ProductName,UnitsInStock,S.CompanyName,S.Phone FROM Products P
JOIN Suppliers S ON S.SupplierID=P.SupplierID
WHERE UnitsInStock<20
--40-bu ay en �ok sat�� yapan �al��an�n en fazla sat�� yapt��� �r�n�n devam� var m�
SELECT ProductID,ProductName,UnitsInStock FROM Products
WHERE ProductID=(
SELECT TOP 1 ProductID FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
WHERE EmployeeID=(SELECT TOP 1 EmployeeID FROM Orders
WHERE  OrderDate >= '1997-01-01' AND OrderDate < '1997-02-01'
GROUP BY EmployeeID ORDER BY COUNT(*) DESC)
GROUP BY ProductID ORDER BY COUNT(*) DESC)
--41-en fazla �r�n� bulunan tedarik�inin ka� adet �r�n� vard�r.
SELECT COUNT(*),SupplierID FROM Products
GROUP BY SupplierID ORDER BY 1 DESC
--42-�r�nlerden en az bir kere sat�lm�� olanlar�n listesi
SELECT COUNT(*)'Sat�lma adeti',OD.ProductID,ProductName FROM [Order Details] OD
JOIN Products P ON P.ProductID=OD.ProductID
GROUP BY OD.ProductID,ProductName

--43-Hi� al��veri� yapmam�� kullan�c�lar�n listesi
select C.CustomerID,CompanyName from Orders O
right JOIN Customers c on c.CustomerID=o.CustomerID
where OrderID IS NULL

--44-�ehri londra olan m��terilerin �r�nlerinden en �ok satanlar

SELECT TOP 3 SUM(Quantity),P.ProductID,ProductName FROM Customers C
JOIN ORDERS O ON C.CustomerID=O.CustomerID
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
WHERE ShipCity ='LONDON'
GROUP BY P.ProductID,ProductName ORDER BY 1 DESC


--45-Tedarik�i Id'si 1 olan �r�nleri en �ok sipari� eden 3 m��teri
SELECT SUM(Quantity)'ALDI�I �R�N SAYISI',C.CompanyName FROM [Order Details] OD
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Suppliers S ON S.SupplierID=P.SupplierID
JOIN Orders O ON O.OrderID=OD.OrderID
JOIN Customers C ON C.CustomerID=O.CustomerID
WHERE S.SupplierID=1
GROUP BY C.CompanyName ORDER BY 1 DESC


--46- Toplam kargo ya �dedi�imiz �cret toplam� ciromuzun %'de ka��d�r ?


SELECT '%'+ ROUND(((SELECT SUM(Freight) FROM Orders)/(SELECT SUM(UnitPrice*Quantity*(1-Discount)) FROM [Order Details])*100),2,1) AS 'KARGO MASRAFLARININ Y�ZDES�(C�ROYA G�RE) '

--47-En �ok satt���m�z �r�n ile en az satt���m�z �r�n aras�ndaki adet fark ka�t�r ?

SELECT (SELECT TOP 1  SUM(Quantity) AS MAXSALES FROM [Order Details]
GROUP BY ProductID ORDER BY 1 DESC) - (SELECT TOP 1  SUM(Quantity) AS MAXSALES FROM [Order Details]
GROUP BY ProductID ORDER BY 1 ) AS '�OK SATILAN VE AZ SATILAN FARKI'

--48-  �ndirim yap�lan �r�nler ile indirim yap�lmam�� halleri aras�ndaki fiyat fark� nedir hepsi i�in gruplayarak?
SELECT SUM(OD.UnitPrice*Quantity) INDIRIMSIZ,SUM((OD.UnitPrice*Quantity*(1-Discount))) INDIRIMLIFIYAT,OD.ProductID,ProductName  FROM [Order Details] OD
JOIN Products P ON P.ProductID= OD.ProductID
WHERE Discount>0
GROUP BY OD.ProductID,ProductName

--49- En �ok hangi �lkelere sat�� yapm���z top 5 s�ralay�n ?
SELECT TOP 5 SUM(Quantity*UnitPrice*(1-Discount)) ToplamOdeme, ShipCountry FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
GROUP BY ShipCountry ORDER BY 1 DESC -- �LKELERE G�RE EN FAZLA �DEME YAPAN �LKE

SELECT COUNT(*) toplamsipari�,ShipCountry FROM Orders
GROUP BY ShipCountry ORDER BY 1 DESC--�LKELRE G�RE EN FAZLA S�PAR�� VEREN �LKE

--50- En �ok �r�n� hangi city deki m��teri alm��t�r
SELECT sum(Quantity),O.CustomerID,C.CompanyName,City FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
JOIN Customers C ON C.CustomerID=O.CustomerID
group by O.CustomerID,C.CompanyName,City ORDER BY 1 DESC

