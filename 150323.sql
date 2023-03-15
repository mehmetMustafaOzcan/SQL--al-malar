--1. En kýsa sürede giden sipariþi hangi kargo firmasý yaptý ?
select datediff(day,OrderDate,ShippedDate)'Gun Sayýsý',ShipVia,CompanyName from orders o
join Shippers s on s.ShipperID=o.ShipVia
where datediff(day,OrderDate,ShippedDate) is not null
order by 1,2 

--2. Þirketim, þimdiye kadar ne kadar ciro yapmýþ ?

SELECT CAST(SUM(quantity*UnitPrice*(1-Discount)) AS DECIMAL (15,2)) FROM Orders o
JOIN [Order Details] od ON o.OrderID=od.OrderID

--3. Kategori idsi 1 ve 6 olan sipariþlerden en çok satýlan ürünün fiyatý ?

SELECT SUM(Quantity),P.ProductID,OD.UnitPrice FROM [Order Details] OD
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID
WHERE C.CategoryID = 1 OR C.CategoryID = 6
GROUP BY P.ProductID,OD.UnitPrice
ORDER BY SUM(Quantity) DESC

--4. En çok sipariþ veren çalýþanýmýn yaþýný fotoðrafýný ve sattýðý ürün sayýsýný göster ?

SELECT COUNT(*),FirstName,LASTNAME,DATEDIFF(YEAR,BirthDate,GETDATE())'YAÞ',E.PhotoPath FROM Orders O
JOIN Employees E ON E.EmployeeID=O.EmployeeID
GROUP BY FirstName ,LASTNAME,E.PhotoPath,DATEDIFF(YEAR,BirthDate,GETDATE())
ORDER BY 1 DESC

--5. Kargo ýdsi 2 olan kargo þirketine en çok hangi ürünleri teslim ettim ?
SELECT SUM(Quantity),ProductID FROM Orders O
JOIN Shippers S ON S.ShipperID=O.ShipVia
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
WHERE S.ShipperID=2 AND O.ShippedDate IS NOT NULL
GROUP BY ProductID 
ORDER BY 1 DESC

--6: Fax numarasý olmayan ve posta kodu d ile biten tedarikçilerden alýnýp 1 numaralý kargo firmasý ile ismi m ile baþlayan çalýþan tarafýndan gönderilen fakat kargoya belirtilen tarihten geç verilmiþ, s ile biten kategoriye ait ürünleri gösteriniz.


SELECT P.ProductName FROM Suppliers S
JOIN Products P ON P.SupplierID=S.SupplierID
JOIN [Order Details] OD ON OD.ProductID=P.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID
JOIN Orders O ON O.OrderID=OD.OrderID
JOIN Employees E ON E.EmployeeID=O.EmployeeID
WHERE S.Fax IS NULL AND S.PostalCode LIKE '%D' AND ShipVia=1 AND FirstName LIKE 'M%' AND ShippedDate>RequiredDate AND CategoryName LIKE '%S'

--7: Ýstenen tarihten 3 haftadan kýsa sürede müþteriye gönderilmesi için kargoya verilmiþ olan sipariþlerin ilk 3 ü(kargo tarihi ile sýrala) hangi kargo firmalarý ile gönderilmiþtir.

SELECT TOP 3 CompanyName,RequiredDate,ShippedDate,DATEDIFF(WEEK,ShippedDate,RequiredDate) FROM Orders O
JOIN Shippers S ON S.ShipperID=O.ShipVia
WHERE DATEDIFF(WEEK,ShippedDate,RequiredDate)<3
ORDER BY DATEDIFF(WEEK,ShippedDate,RequiredDate) DESC

--8: Amerika kýtasý dýþýndan tedarik edilmiþ olan ürünlerin hangileri sipariþ üzerine Amerika kýtasýnýn WA region a teslim edilmiþtir.


SELECT Country FROM Suppliers S
JOIN Products P ON P.SupplierID=S.SupplierID
JOIN [Order Details] OD ON OD.ProductID=P.ProductID
JOIN Orders O ON O.OrderID=OD.OrderID
WHERE S.Country <>'USA' AND O.ShipRegion='WA'

--9: ID'si 2 olan kategoriye ait ürünlerin ilk 5 i ni birim fiyatý pahalýdan ucuza doðru olacak þekilde gösteriniz.

SELECT C.CategoryID,ProductName FROM Categories C
JOIN Products P ON P.CategoryID=C.CategoryID
WHERE C.CategoryID=2
ORDER BY UnitPrice DESC 

--10: 10 kere den fazla sipariþ edilmiþ ürünlerin stoklarý kritik düzeyde olanlarý listeleyiniz.
SELECT*FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
SELECT SUM (Quantity),ProductID FROM [Order Details] OD
WHERE SUM (Quantity)>10
GROUP BY OD.ProductID

SELECT ProductName,COUNT(*)'SÝPARÝÞ SAYISI' ,OD.ProductID,UnitsInStock,ReorderLevel FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
WHERE UnitsInStock<5 AND Discontinued=0
GROUP BY OD.ProductID,UnitsInStock,ReorderLevel,ProductName
HAVING COUNT(*)>10
ORDER BY COUNT(*) DESC

SELECT*FROM Products
