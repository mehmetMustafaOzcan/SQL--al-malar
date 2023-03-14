--1- Customers tablosundan CustomerID�sinin 2. harfi A, 4. harfi T olanlar�n %15 lik k�sm�n� getiren sorguyu yaz�n�z.
select top 15 percent *from Customers
where CustomerID like '_a_t%' 

--2. En �ok �r�n alan m��teri

select top 1  sum(quantity)'Toplam �r�n',c.CustomerID,c.CompanyName from Orders o
join [Order Details] od on od.OrderID=o.OrderID
join Customers c on c.CustomerID=o.CustomerID
group by c.CustomerID,c.CompanyName order by 1 desc

--3. En y�ksek �creti �deyen m��teri,ALDI�I TOPLAM S�PAR��
select   sum(quantity*UnitPrice*(1-Discount))'F�YAT',count(DISTINCT od.OrderID)'VERD��� S�PAR��',c.CustomerID,c.CompanyName from Orders o
join [Order Details] od on od.OrderID=o.OrderID
join Customers c on c.CustomerID=o.CustomerID
group by c.CustomerID,c.CompanyName order by 1 desc

--4. En �ok �r�n satan ilk 5 �al��an
SELECT TOP 5 SUM(Quantity),E.EmployeeID,SUM((quantity*UnitPrice*(1-Discount))) FROM Orders O
JOIN Employees E ON E.EmployeeID=O.EmployeeID
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
GROUP BY E.EmployeeID order by 1 desc

--5. Frans�zca konu�abilen �al��an�m hangisi ?
SELECT*FROM Employees
WHERE Notes LIKE '%FRENCH%' 

-- 6.SORU vw_SiparisRaporlari ad� alt�nda view olu�turulacak-- Bir sipari�in, hangi �al��an taraf�ndan, hangi m��teriye, hangi kategorideki �r�nden, hangi fiyattan, ka� adet sat�ld���n� lisleteliyiniz...�-- Yukar�daki sorgu i�in; (Orders orta tablo gibi d���n�lebilir, ilgili ID'leri e�le�tirmek i�in)
-- �al��an�n: FirstName, LastName, TitleOfCourtesy, Title kolonlar�
-- M��terinin: CompanyName, ContactName, Phone,
-- �r�n�n: ProductName, UnitsInStock,
-- Kategorinin: CategoryName kolonlar�,
-- Sipari� Detay�n�n: UnitPrice, Quantity kolonlar�,
-- tek bir sorguda yaz�lacak.ba�lam men�s� var

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

-- 7.SORU @fiyat ad�nda bir function tan�mlayal�m bu function ta��ma �cretlerine Y�zde 18 lik kdv uygulas�n
DECLARE @fiyat money
declare @tas�maucr money
CREATE FUNCTION kdvekle (@fiyat money)
RETURNS MONEY
BEGIN
RETURN @fiyat*1.18
END;

select *,[dbo].[kdvekle](Freight)'KDVli fiyat' from Orders

-- 8.SORU olu�turd�umuz bu function ile ProductName, CategoryName, UnitPrice, ve UnitPrice*function�m�z
select ProductName,CategoryName,OD.UnitPrice,[dbo].[kdvekle](OD.UnitPrice), [dbo].[kdvekle](O.Freight)'KDVli fiyat' from Orders O
JOIN [Order Details] OD ON OD.OrderID=O.OrderID
JOIN Products P ON P.ProductID=OD.ProductID
JOIN Categories C ON C.CategoryID=P.CategoryID

-- Sadece Beverages kategorisinde �r�nlerin KDV oran� %8 olsun, di�er kategorilerdeki �r�nlerin KDV oran� %18 olsun.
--ProductNmae, CategoryName, UnitPrice, KDVLi Fiyat tablolar� olu�turulcak
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

