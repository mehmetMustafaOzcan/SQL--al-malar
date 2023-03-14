--1- Customers tablosundan CustomerID’sinin 2. harfi A, 4. harfi T olanlarýn %15 lik kýsmýný getiren sorguyu yazýnýz.
select top 15 percent *from Customers
where CustomerID like '_a_t%' 

--2. En çok ürün alan müþteri

select top 1  sum(quantity)'Toplam Ürün',c.CustomerID,c.CompanyName from Orders o
join [Order Details] od on od.OrderID=o.OrderID
join Customers c on c.CustomerID=o.CustomerID
group by c.CustomerID,c.CompanyName order by 1 desc

--3. En yüksek ücreti ödeyen müþteri,ALDIÐI TOPLAM SÝPARÝÞ
select   sum(quantity*UnitPrice*(1-Discount))'FÝYAT',count(DISTINCT od.OrderID)'VERDÝÐÝ SÝPARÝÞ',c.CustomerID,c.CompanyName from Orders o
join [Order Details] od on od.OrderID=o.OrderID
join Customers c on c.CustomerID=o.CustomerID
group by c.CustomerID,c.CompanyName order by 1 desc

--4. En çok ürün satan ilk 5 çalýþan
SELECT TOP 5 SUM(Quantity),E.EmployeeID,SUM((quantity*UnitPrice*(1-Discount))) FROM Orders O
JOIN Employees E ON E.EmployeeID=O.EmployeeID
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
GROUP BY E.EmployeeID order by 1 desc

--5. Fransýzca konuþabilen çalýþaným hangisi ?
SELECT*FROM Employees
WHERE Notes LIKE '%FRENCH%' 

-- 6.SORU vw_SiparisRaporlari adý altýnda view oluþturulacak-- Bir sipariþin, hangi çalýþan tarafýndan, hangi müþteriye, hangi kategorideki üründen, hangi fiyattan, kaç adet satýldýðýný lisleteliyiniz... -- Yukarýdaki sorgu için; (Orders orta tablo gibi düþünülebilir, ilgili ID'leri eþleþtirmek için)
-- Çalýþanýn: FirstName, LastName, TitleOfCourtesy, Title kolonlarý
-- Müþterinin: CompanyName, ContactName, Phone,
-- Ürünün: ProductName, UnitsInStock,
-- Kategorinin: CategoryName kolonlarý,
-- Sipariþ Detayýnýn: UnitPrice, Quantity kolonlarý,
-- tek bir sorguda yazýlacak.baðlam menüsü var

create view vw_SiparisRaporlari as
SELECT E.FirstName,E.LastName,E.TitleOfCourtesy,e.Title, C.CompanyName,C.ContactName,Phone,ProductName,CategoryName,od.Quantity,od.UnitPrice,UnitsInStock FROM Orders O
JOIN Employees E ON o.EmployeeID=E.EmployeeID
JOIN [Order Details] OD ON O.OrderID=OD.OrderID
JOIN Customers C ON O.CustomerID=C.CustomerID
JOIN Products P ON OD.ProductID=P.ProductID
JOIN Categories Ct ON p.CategoryID=Ct.CategoryID

JOIN Orders ON Orders.EmployeeID = Employees.EmployeeID
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
JOIN Products ON [Order Details].ProductID = Products.ProductID
JOIN Categories ON Products.CategoryID = Categories.CategoryID



SELECT*FROM vw_SiparisRaporlari

alter VIEW [vw_SiparisRaporlari] AS
SELECT E.FirstName,E.LastName,E.TitleOfCourtesy,e.Title, C.CompanyName,C.ContactName,Phone,ProductName,CategoryName,od.Quantity,od.UnitPrice,UnitsInStock,HireDate FROM Orders O
JOIN Employees E ON o.EmployeeID=E.EmployeeID
JOIN [Order Details] OD ON O.OrderID=OD.OrderID
JOIN Customers C ON O.CustomerID=C.CustomerID
JOIN Products P ON OD.ProductID=P.ProductID
JOIN Categories Ct ON p.CategoryID=Ct.CategoryID

-- 7.SORU @fiyat adýnda bir function tanýmlayalým bu function taþýma ücretlerine Yüzde 18 lik kdv uygulasýn
DECLARE @fiyat money
declare @tasýmaucr money
CREATE FUNCTION kdvekle (@fiyat money)
RETURNS MONEY
BEGIN
RETURN @fiyat*1.18
END;

select *,[dbo].[kdvekle](Freight)'KDVli fiyat' from Orders

-- 8.SORU oluþturdðumuz bu function ile ProductName, CategoryName, UnitPrice, ve UnitPrice*functionýmýz
select ProductName,CategoryName,OD.UnitPrice,[dbo].[kdvekle](OD.UnitPrice), [dbo].[kdvekle](O.Freight)'KDVli fiyat' from Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID

-- Sadece Beverages kategorisinde ürünlerin KDV oraný %8 olsun, diðer kategorilerdeki ürünlerin KDV oraný %18 olsun.
--ProductNmae, CategoryName, UnitPrice, KDVLi Fiyat tablolarý oluþturulcak
alter FUNCTION kdvliekle (@fiyat money,@kategori nvarchar)
RETURNS MONEY
BEGIN
 IF @kategori ='Beverages' begin return @fiyat*1.08; end else begin return @fiyat*1.18 ;end
 return @fiyat
END;



select ProductName,CategoryName,OD.UnitPrice,[dbo].[kdvliekle](OD.UnitPrice,CategoryName) from Orders O

JOIN [Order Details] OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID

