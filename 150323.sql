--1. En k�sa s�rede giden sipari�i hangi kargo firmas� yapt� ?
select datediff(day,OrderDate,ShippedDate)'Gun Say�s�',ShipVia,CompanyName from orders o
join Shippers s on s.ShipperID=o.ShipVia
where datediff(day,OrderDate,ShippedDate) is not null
order by 1,2 

--2. �irketim, �imdiye kadar ne kadar ciro yapm�� ?

SELECT CAST(SUM(quantity*UnitPrice*(1-Discount)) AS DECIMAL (15,2)) FROM Orders o
JOIN [Order Details] od ON o.OrderID=od.OrderID

--3. Kategori idsi 1 ve 6 olan sipari�lerden en �ok sat�lan �r�n�n fiyat� ?

SELECT SUM(Quantity),P.ProductID,OD.UnitPrice FROM [Order Details] OD
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID
WHERE C.CategoryID = 1 OR C.CategoryID = 6
GROUP BY P.ProductID,OD.UnitPrice
ORDER BY SUM(Quantity) DESC

--4. En �ok sipari� veren �al��an�m�n ya��n� foto�raf�n� ve satt��� �r�n say�s�n� g�ster ?

SELECT COUNT(*),FirstName,LASTNAME,DATEDIFF(YEAR,BirthDate,GETDATE())'YA�',E.PhotoPath FROM Orders O
JOIN Employees E ON E.EmployeeID=O.EmployeeID
GROUP BY FirstName ,LASTNAME,E.PhotoPath,DATEDIFF(YEAR,BirthDate,GETDATE())
ORDER BY 1 DESC

--5. Kargo �dsi 2 olan kargo �irketine en �ok hangi �r�nleri teslim ettim ?
SELECT SUM(Quantity),ProductID FROM Orders O
JOIN Shippers S ON S.ShipperID=O.ShipVia
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
WHERE S.ShipperID=2 AND O.ShippedDate IS NOT NULL
GROUP BY ProductID 
ORDER BY 1 DESC

--6: Fax numaras� olmayan ve posta kodu d ile biten tedarik�ilerden al�n�p 1 numaral� kargo firmas� ile ismi m ile ba�layan �al��an taraf�ndan g�nderilen fakat kargoya belirtilen tarihten ge� verilmi�, s ile biten kategoriye ait �r�nleri g�steriniz.


SELECT P.ProductName FROM Suppliers S
JOIN Products P ON P.SupplierID=S.SupplierID
JOIN [Order Details] OD ON OD.ProductID=P.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID
JOIN Orders O ON O.OrderID=OD.OrderID
JOIN Employees E ON E.EmployeeID=O.EmployeeID
WHERE S.Fax IS NULL AND S.PostalCode LIKE '%D' AND ShipVia=1 AND FirstName LIKE 'M%' AND ShippedDate>RequiredDate AND CategoryName LIKE '%S'

--7: �stenen tarihten 3 haftadan k�sa s�rede m��teriye g�nderilmesi i�in kargoya verilmi� olan sipari�lerin ilk 3 �(kargo tarihi ile s�rala) hangi kargo firmalar� ile g�nderilmi�tir.

SELECT TOP 3 CompanyName,RequiredDate,ShippedDate,DATEDIFF(WEEK,ShippedDate,RequiredDate) FROM Orders O
JOIN Shippers S ON S.ShipperID=O.ShipVia
WHERE DATEDIFF(WEEK,ShippedDate,RequiredDate)<3
ORDER BY DATEDIFF(WEEK,ShippedDate,RequiredDate) DESC

--8: Amerika k�tas� d���ndan tedarik edilmi� olan �r�nlerin hangileri sipari� �zerine Amerika k�tas�n�n WA region a teslim edilmi�tir.


SELECT Country FROM Suppliers S
JOIN Products P ON P.SupplierID=S.SupplierID
JOIN [Order Details] OD ON OD.ProductID=P.ProductID
JOIN Orders O ON O.OrderID=OD.OrderID
WHERE S.Country <>'USA' AND O.ShipRegion='WA'

--9: ID'si 2 olan kategoriye ait �r�nlerin ilk 5 i ni birim fiyat� pahal�dan ucuza do�ru olacak �ekilde g�steriniz.

SELECT C.CategoryID,ProductName FROM Categories C
JOIN Products P ON P.CategoryID=C.CategoryID
WHERE C.CategoryID=2
ORDER BY UnitPrice DESC 

--10: 10 kere den fazla sipari� edilmi� �r�nlerin stoklar� kritik d�zeyde olanlar� listeleyiniz.
SELECT*FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
SELECT SUM (Quantity),ProductID FROM [Order Details] OD
WHERE SUM (Quantity)>10
GROUP BY OD.ProductID

SELECT ProductName,COUNT(*)'S�PAR�� SAYISI' ,OD.ProductID,UnitsInStock,ReorderLevel FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
WHERE UnitsInStock<5 AND Discontinued=0
GROUP BY OD.ProductID,UnitsInStock,ReorderLevel,ProductName
HAVING COUNT(*)>10
ORDER BY COUNT(*) DESC

SELECT*FROM Products
