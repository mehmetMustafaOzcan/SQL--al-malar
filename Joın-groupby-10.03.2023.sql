-- 1.SORU Her �r�n i�in �r�nler tablosundan �r�n Ad�, Kategoriler tablosundan Kategori Ad� bilgilerini listeleyiniz...

SELECT ProductName,Categories.CategoryName FROM Products
JOIN Categories
ON Products.CategoryID=Categories.CategoryID

-- 2.SORU Hangi sipari�in, hangi �al��an taraf�ndan al�nd���n�, hangi m��teriye g�nderilece�ini listeleyiniz...
SELECT EMP.FirstName,O.OrderID,C.ContactName,CompanyName FROM Orders O
JOIN Employees EMP
ON EMP.EmployeeID=O.EmployeeID
JOIN Customers C
ON O.CustomerID=C.CustomerID
-- 3.SORU Products tablosundan T�M KAYITLARI, Categories tablosundan ili�kili kay�tlar� listeleyelim. (ProductName, CategoryName)
INSERT INTO Categories(CategoryName)
VALUES('Elektronik')

INSERT INTO Products(ProductName)
VALUES('Monit�r')

INSERT INTO Products(ProductName)
VALUES('Klavye'),('Mouse')

INSERT INTO Products(CategoryID,ProductName)
VALUES(12,'Kola')

SELECT ProductName,CategoryName FROM Products P
RIGHT JOIN Categories C
ON P.CategoryID=C.CategoryID

SELECT P.ProductName,C.CategoryName FROM Products P
LEFT JOIN Categories C
ON P.CategoryID=C.CategoryID

SELECT P.ProductName,C.CategoryName FROM Products P
JOIN Categories C
ON P.CategoryID=C.CategoryID

-- 4.SORU T�M �al��anlar� ve e�er varsa rapor verdi�i ki�ilerle birlikte listeleyiniz...

SELECT  f.FirstName,e.FirstName'Rapor Verdi�i',f.ReportsTo FROM Employees f
JOIN Employees e
ON f.ReportsTo=e.EmployeeID

--5.SORU Fransaya en �ok satt���m�z �r�n
-- kolonlar�m�zda tedarik edilen adres, �r�n ismi, sat�� miktar�

Select TOP 1 SUM(Quantity),OD.ProductID,P.ProductName,S.[Address] from Orders O
JOIN [Order Details] OD
ON O.OrderID=OD.OrderID
JOIN Products P
ON P.ProductID=OD.ProductID
JOIN Suppliers S ON S.SupplierID=P.SupplierID 
WHERE O.ShipCountry='France'
group by OD.ProductID,P.ProductName ,S.Address
ORDER BY SUM(Quantity) DESC

-- 6.SORU Kargo �irketlerinin kargo �irket kodu ve �irket ad� bilgileriyle, toplam ta��d�klar� sipari� say�s�n� listeleyiniz...

SELECT s.ShipperID,s.CompanyName, COUNT(ShipperID)'Ta��nan Sipari�' FROM Shippers S
JOIN Orders O ON S.ShipperID=O.ShipVia
GROUP BY S.ShipperID,s.CompanyName
-- 7.SORU Brezilya'dan sipari� veren (orada ya�ayan) m��terilerin verdi�i en y�ksek sipari� tutar�n� getiriniz...
select*from [Order Details]

select sum(UnitPrice*Quantity),qd.OrderID from Orders o
JOIN [Order Details] qd
ON O.OrderID=QD.OrderID
where o.ShipCountry='Brazil'
group by qd.OrderID
order by sum(UnitPrice*Quantity)desc

select sum(UnitPrice*Quantity),qd.OrderID from [Order Details] qd
group by OrderID
order by sum(UnitPrice*Quantity)desc

select sum(qd.UnitPrice *qd.Quantity),qd.OrderID,c.CompanyName,c.Country from Orders ord
JOIN Customers C ON ord.CustomerID=C.CustomerID
JOIN [Order Details] qd ON ord.OrderID=qd.OrderID
where c.Country='Brazil'
group by qd.OrderID,c.CompanyName,c.Country
order by sum(UnitPrice*Quantity)desc






