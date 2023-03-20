--1-En çok satýþ yaptýðým müþterim hangisi


SELECT TOP 1 COUNT(O.CustomerID),O.CustomerID,C.CompanyName  from Orders O
JOIN Customers C ON C.CustomerID=O.CustomerID
GROUP BY O.CustomerID,C.CompanyName ORDER BY 1 DESC

--2-En çok hangi sipariþten para kazanmýþým?
SELECT SUM(UnitPrice*Quantity*(1-Discount))'SÝPARÝÞ TUTARI',OrderID FROM [Order Details]
GROUP BY OrderID ORDER BY 1 DESC

--3 2 ay önce yaptýðým satýþlarýnýn london þehrinde ki x ürünün satýþ miktari


SELECT od.ProductID,p.ProductName,SUM(Quantity) FROM Orders o
join [Order Details] od on od.OrderID=o.OrderID
join Products p on p.ProductID=od.ProductID
WHERE DATEDIFF(MONTH,OrderDate,GETDATE())>2 AND ShipCity='London'
group by od.ProductID,p.ProductName

--4-son 2 yýl içinde en çok satýlan ürün ve en az satýlan ürün
SELECT TOP 1 SUM(Quantity),OD.ProductID,P.ProductName FROM Orders O
JOIN [Order Details] OD ON O.OrderID=OD.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
WHERE DATEDIFF(YEAR,(SELECT MAX(OrderDate) FROM Orders),OrderDate)<3 
GROUP BY OD.ProductID,P.ProductName ORDER BY 1 DESC

--5-yýlýn çalýþaný kim en çok satýþ yapan
SELECT TOP 1 COUNT(*),O.EmployeeID,FirstName,LastName FROM Orders O
JOIN Employees E ON E.EmployeeID=O.EmployeeID
GROUP BY O.EmployeeID,FirstName,LastName ORDER BY 1 DESC

--6: Tedarikçi id si 1 ile 5 olan tedarikçilerden alýnan ürünlerin adýný ve stok sayýsýný gösteren sorgu.
SELECT*FROM Products
WHERE SupplierID LIKE 1 OR SupplierID LIKE 5 
--7: Stok sayýsý kritik olan 10 ürünün tedarikçilerinin adýný yazdýrýn.
SELECT ProductName,UnitsInStock,CompanyName FROM Products P
JOIN Suppliers S ON S.SupplierID=P.SupplierID
WHERE UnitsInStock<5 AND Discontinued=0
--8:Esparta bölgesine gönderilen en çok 5 ürünü listele.

SELECT sum(Quantity), OD.ProductID,P.ProductName FROM ORDERS O
JOIN [Order Details] OD ON  OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
WHERE ShipRegion LIKE '%ESPARTA%' 
GROUP BY OD.ProductID ,P.ProductName
ORDER BY 1 DESC

--9: En çok ürün alan müþteriye satýþ yapan personeller kimdir listele.
SELECT COUNT(*)'ALDIÐI SÝPARÝÞ',O.CustomerID'EN ÇOK ÜRÜN ALAN MÜÞTERÝ', O.EmployeeID,LastName FROM Orders O
JOIN Employees E ON E.EmployeeID=O.EmployeeID
WHERE CustomerID =(SELECT  TOP 1 CustomerID FROM Orders O JOIN [Order Details] OD ON OD.OrderID=O.OrderID GROUP BY CustomerID ORDER BY SUM(Quantity) DESC)
GROUP BY O.EmployeeID,LastName,O.CustomerID

--10: En çok hangi kategori türünde satýþ olmustur.
SELECT TOP 1 SUM(Quantity),P.CategoryID,CategoryName FROM Products P
JOIN [Order Details] OD ON OD.ProductID=P.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID
GROUP BY P.CategoryID,CategoryName ORDER BY 1 DESC

--11- Ship PostalCode'u sadece sayýlardan oluþmayan sipariþler
SELECT ShipPostalCode FROM Orders
WHERE ShipPostalCode LIKE '%[^0-9]%'
--12- ContactTitle'a göre sýralanmýþ ve Kendi içinde de sýralanmýþ tedarikçilerin adres þehir ve bölgeleri tek kolonda, kolon adý Adres
SELECT Address+Country+Region,ContactTitle FROM Customers
ORDER BY ContactTitle
--13- En ucuz sipariþ kaleminin tutarý
SELECT TOP 1 SUM(Quantity*UnitPrice*(1-Discount)) TUTAR,OrderID FROM [Order Details]
GROUP BY OrderID ORDER BY 1

--14- Adýnda a ve e harfi birlikte bulunan çalýþanlarýn yaþa göre sýralanmýþ halde bilgileri, adý ve soyadý Ad Soyad kolon adýyla gelecek
SELECT FirstName,LastName,BirthDate FROM Employees
WHERE FirstName LIKE '%a%E%'OR FirstName LIKE '%E%A%'
ORDER BY BirthDate DESC
--15- Ýþe girdiðinde yaþý en genç olan top 3 çalýþan
SELECT TOP 3 *FROM Employees
ORDER BY DATEDIFF(YEAR,BirthDate,HireDate)

--16:5 numaralý çalýþanýn yaptýðý satýþlarýn toplam ücreti ne kadardýr.
SELECT SUM(Quantity*UnitPrice*(1-Discount)) FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
WHERE EmployeeID=5
GROUP BY EmployeeID

--17:Kategorisi 1,3,5,7 olan ürünleri ürün isimlerine göre listeleyiniz.
SELECT*FROM Products
WHERE CategoryID = 1 OR CategoryID = 3 OR CategoryID =5 OR CategoryID =7
ORDER BY ProductName
--18: 5 numaralý ürünü 2 numaralý kargocuya taþýtan müþterileri gösteriniz
SELECT*FROM Products P
JOIN Suppliers S ON S.SupplierID=P.SupplierID
WHERE ProductID=5 AND S.SupplierID=2
--19: Chai ürününü en çok alan müþterileri ve ödenen fiyatý azalan þekilde listeleyiniz.
SELECT SUM(Quantity) ,C.CompanyName,O.CustomerID FROM [Order Details] OD
JOIN Orders O ON O.OrderID=OD.OrderID
JOIN Products P ON OD.ProductID=P.ProductID
JOIN Customers C ON C.CustomerID=O.CustomerID
WHERE ProductName='Chai'
GROUP BY O.CustomerID,C.CompanyName ORDER BY 1 DESC


--20:ürün adý cha ile baþlayan ve 4 harften oluþan ürünleri sorgusunu yazýnýz.
SELECT*FROM Products
WHERE ProductName LIKE 'CHA_'
--21-Tekrar sipariþ etme seviyesi 25'ten fazla olan ürünlerden birim fiyatý en yüksek olan ilk 3 ürünün ürün adý ve birim fiyatýný gösterin
SELECT TOP 3 *FROM Products
WHERE ReorderLevel>25
ORDER BY UnitPrice DESC
--22-sipariþ tarihi 01.01.1997 den önce olan sipariþlerden bölge bilgisi boþ olmayan ve ülkesi Meksika olan sipariþlerin sipariþ idsi tarihi ve ülkesini listeleyin
SELECT OrderID,ShippedDate,ShipCountry FROM Orders
WHERE OrderDate< '1997-01-01' AND ShipRegion IS NOT NULL AND ShipCountry='Mexico'


--23-stoklarý 10 ve 50 arasýnda olan ürünlerin indirim yapýlmayanlarýnýn birim fiyatlarýný azdan çoða doðru listeleyin.
SELECT P.ProductID,ProductName, P.UnitPrice FROM Products P
JOIN [Order Details] OD ON OD.ProductID=P.ProductID
WHERE UnitsInStock BETWEEN 10 AND 50
AND Discount=0
GROUP BY P.ProductID,P.UnitPrice,ProductName
ORDER BY P.UnitPrice


--24-4 numaralý kategoriye ait olan birim fiyatý 10'dan büyük olan ürünlerin ismini ve fiyatýný fiyat çoktan aza sýralanacak þekilde listeleyin

SELECT ProductName,UnitPrice FROM Products
WHERE CategoryID=4 AND UnitPrice>10
ORDER BY UnitPrice DESC
--25-müþteri ismi T ile baþlayan ve ülkesi USA olan müþterilerin müþteri ismi ve telefon numaralarýný listeleyin
SELECT*FROM Customers
WHERE CompanyName LIKE 'T%' AND Country='USA'

--26-En çok sipariþ veren müþteri bilgileri listele
SELECT*FROM Customers
WHERE CustomerID=( SELECT TOP 1 Orders.CustomerID FROM Orders
JOIN Customers C ON C.CustomerID=Orders.CustomerID
GROUP BY ORDERS.CustomerID ORDER BY COUNT(*) DESC)
--27-UnitPrice ý 15 ile 100 arasýnda olan, devam ettirilen ürünlerin adý ve fiyat bilgilerini fiyata göre artan sekilde sýralayýn
SELECT*FROM Products
WHERE UnitPrice BETWEEN 15 AND 100 AND Discontinued=0
--28-1 numaralý kargo ile Cork sehrine gönderilen veya taþýma ücreti 111 den küçük olanlarýn siparis tarihini ve gönderim tarihlerini listeleyin

SELECT  OrderDate,ShippedDate FROM Orders
WHERE ShipVia=1 OR Freight<111
--29-Tedarikci adýnýn 2. harfi a veya e olan ve sonu n veya s ile bitmeyenlerin listesi
SELECT *FROM Suppliers
WHERE (CompanyName LIKE '_[AE]%') AND CompanyName LIKE '%[^NS]' 
--30-Sales Representative  lerin ad ve soyadlarýný bir kolonda, iþe girisinden sonra geçen günü 'Geçen Gün' kolonunda gösterip sýralamayý geçen güne göre artan yapýn
select*from [dbo].[Employees]
--31-personelleri yaþ sýralamasý yapýp 25ten büyük olanlarýn ünvan kolonu açýp usta küçükse çýrak yazsýn
--32-personellerin yaþýný hesaplayýp ayrý bir yaþ kolonunda yazýn
ALTER TABLE Employees
ADD YAS INT 
UPDATE Employees
SET YAS =  DATEDIFF(YEAR,BirthDate,GETDATE()) 

SELECT*FROM Employees
--33-ürün tablosundan categorisi 2 olanlarýn stoklarýný 10 ar arttýrarak yenileyelim ve indirim uygulayalým
UPDATE Products
SET UnitsInStock=UnitsInStock+10
WHERE CategoryID LIKE 2

--34-ürün stoklarý 100ün üzerinde olanlarýa indirim uygulayýp birim fiyatýnýda 1$ düþürelim
update Products
set UnitPrice=1
where UnitsInStock>100

SELECT*FROM Products

--35-costumers tablosundaki country kolonunda mexico yerine siesta yazalým
update Customers
set Country='Siesta'
where Country='Mexico'

SELECT*FROM Customers

--36-En çok satilan 10 ürünün kategorileri
SELECT TOP 10 SUM(Quantity) ,OD.ProductID,P.CategoryID FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID 
GROUP BY OD.ProductID,P.CategoryID ORDER BY 1 DESC

--37-1997 Ocak ayýnda en çok alýþveriþ yapan müþterinin en çok aldýðý ürünün indirim oraný

SELECT count(*),CustomerID FROM Orders o
WHERE OrderDate > '1997-01-01' AND  OrderDate < '1997-02-01'
GROUP BY CustomerID ORDER BY 1 DESC

--38-1996 yýlýnýn en çok satilan ürünün ülkesi ve totalprice
SELECT TOP 1 SUM(Quantity) as SatýlanAdet,OD.ProductID,S.Country,sUM(Quantity*od.UnitPrice*(1-Discount)) as ToplamFiyat FROM Orders O
JOIN [Order Details] OD ON O.OrderID=OD.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Suppliers S ON S.SupplierID=P.SupplierID
WHERE OrderDate>'1996-01-01' AND OrderDate<'1997-01-01'
GROUP BY OD.ProductID,S.Country ORDER BY 1 DESC --EN ÇOK SATILAN ÜLKENÝN TEDARÝK EDÝLDÝÐÝ ÜLKE

SELECT TOP 1 O.ShipCountry, SUM(OD.Quantity)  AS TotalQuantity,SUM(Quantity*UnitPrice*(1-Discount))AS TotalPrice
FROM [Order Details] OD
JOIN Orders O ON O.OrderID = OD.OrderID
WHERE O.OrderDate >= '1996-01-01' AND O.OrderDate < '1997-01-01'
GROUP BY O.ShipCountry
ORDER BY TotalQuantity DESC; --EN ÇOK SATILAN ÜRÜNÜN ÜLKESÝ

--39-Stok miktari 20 altýna düþen ürünlerin tedarikçilerinin telefon numalarý
SELECT ProductName,UnitsInStock,S.CompanyName,S.Phone FROM Products P
JOIN Suppliers S ON S.SupplierID=P.SupplierID
WHERE UnitsInStock<20
--40-bu ay en çok satýþ yapan çalýþanýn en fazla satýþ yaptýðý ürünün devamý var mý
SELECT ProductID,ProductName,UnitsInStock FROM Products
WHERE ProductID=(
SELECT TOP 1 ProductID FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
WHERE EmployeeID=(SELECT TOP 1 EmployeeID FROM Orders
WHERE  OrderDate >= '1997-01-01' AND OrderDate < '1997-02-01'
GROUP BY EmployeeID ORDER BY COUNT(*) DESC)
GROUP BY ProductID ORDER BY COUNT(*) DESC)
--41-en fazla ürünü bulunan tedarikçinin kaç adet ürünü vardýr.
SELECT COUNT(*),SupplierID FROM Products
GROUP BY SupplierID ORDER BY 1 DESC
--42-Ürünlerden en az bir kere satýlmýþ olanlarýn listesi
SELECT COUNT(*)'Satýlma adeti',OD.ProductID,ProductName FROM [Order Details] OD
JOIN Products P ON P.ProductID=OD.ProductID
GROUP BY OD.ProductID,ProductName

--43-Hiç alýþveriþ yapmamýþ kullanýcýlarýn listesi
select C.CustomerID,CompanyName from Orders O
right JOIN Customers c on c.CustomerID=o.CustomerID
where OrderID IS NULL

--44-Þehri londra olan müþterilerin ürünlerinden en çok satanlar

SELECT TOP 3 SUM(Quantity),P.ProductID,ProductName FROM Customers C
JOIN ORDERS O ON C.CustomerID=O.CustomerID
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
WHERE ShipCity ='LONDON'
GROUP BY P.ProductID,ProductName ORDER BY 1 DESC


--45-Tedarikçi Id'si 1 olan ürünleri en çok sipariþ eden 3 müþteri
SELECT SUM(Quantity)'ALDIÐI üRÜN SAYISI',C.CompanyName FROM [Order Details] OD
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Suppliers S ON S.SupplierID=P.SupplierID
JOIN Orders O ON O.OrderID=OD.OrderID
JOIN Customers C ON C.CustomerID=O.CustomerID
WHERE S.SupplierID=1
GROUP BY C.CompanyName ORDER BY 1 DESC


--46- Toplam kargo ya ödediðimiz ücret toplamý ciromuzun %'de kaçýdýr ?


SELECT '%'+ ROUND(((SELECT SUM(Freight) FROM Orders)/(SELECT SUM(UnitPrice*Quantity*(1-Discount)) FROM [Order Details])*100),2,1) AS 'KARGO MASRAFLARININ YÜZDESÝ(CÝROYA GÖRE) '

--47-En çok sattýðýmýz ürün ile en az sattýðýmýz ürün arasýndaki adet fark kaçtýr ?

SELECT (SELECT TOP 1  SUM(Quantity) AS MAXSALES FROM [Order Details]
GROUP BY ProductID ORDER BY 1 DESC) - (SELECT TOP 1  SUM(Quantity) AS MAXSALES FROM [Order Details]
GROUP BY ProductID ORDER BY 1 ) AS 'çOK SATILAN VE AZ SATILAN FARKI'

--48-  Ýndirim yapýlan ürünler ile indirim yapýlmamýþ halleri arasýndaki fiyat farký nedir hepsi için gruplayarak?
SELECT SUM(OD.UnitPrice*Quantity) INDIRIMSIZ,SUM((OD.UnitPrice*Quantity*(1-Discount))) INDIRIMLIFIYAT,OD.ProductID,ProductName  FROM [Order Details] OD
JOIN Products P ON P.ProductID= OD.ProductID
WHERE Discount>0
GROUP BY OD.ProductID,ProductName

--49- En çok hangi ülkelere satýþ yapmýþýz top 5 sýralayýn ?
SELECT TOP 5 SUM(Quantity*UnitPrice*(1-Discount)) ToplamOdeme, ShipCountry FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
GROUP BY ShipCountry ORDER BY 1 DESC -- ÜLKELERE GÖRE EN FAZLA ÖDEME YAPAN ÜLKE

SELECT COUNT(*) toplamsipariþ,ShipCountry FROM Orders
GROUP BY ShipCountry ORDER BY 1 DESC--ÜLKELRE GÖRE EN FAZLA SÝPARÝÞ VEREN ÜLKE

--50- En çok ürünü hangi city deki müþteri almýþtýr
SELECT sum(Quantity),O.CustomerID,C.CompanyName,City FROM Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
JOIN Customers C ON C.CustomerID=O.CustomerID
group by O.CustomerID,C.CompanyName,City ORDER BY 1 DESC

