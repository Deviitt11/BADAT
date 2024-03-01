USE AdventureWorksLT2019;

-- 1.1
SELECT *
FROM SalesLT.ProductCategory
WHERE ParentProductCategoryID IS NULL;

-- 1.2
SELECT Name, StandardCost
FROM SalesLT.Product
WHERE ProductCategoryID = 5;

-- 1.3
SELECT Name, Size
FROM SalesLT.Product
WHERE ProductModelID = 8;

-- 1.4
SELECT COUNT(*) 
FROM SalesLT.ProductCategory
WHERE ParentProductCategoryID = 3;

-- 1.5
SELECT FirstName, EmailAddress
FROM SalesLT.Customer
WHERE LOWER(EmailAddress) LIKE 'j%';
-- LEFT(LOWER(EmailAddress), 1) = 'j';

-- 1.6
SELECT DISTINCT Title
FROM SalesLT.Customer;

-- 1.7
-- MAL
-- SELECT Title, COUNT(FirstName)
-- FROM SalesLT.Customer
-- GROUP BY Title;
SELECT Title, COUNT(DISTINCT EmailAddress)
FROM SalesLT.Customer
GROUP BY Title;

SELECT C1.CustomerID, COUNT(C2.CustomerID)
FROM SalesLT.Customer AS C1
JOIN SalesLT.Customer AS C2
ON C1.EmailAddress = C2.EmailAddress
WHERE C1.CustomerID <> C2.CustomerID
GROUP BY C1.CustomerID;

-- 1.8
SELECT COUNT(*)
FROM SalesLT.Customer
WHERE MiddleName IS NULL;

-- 1.9
SELECT FirstName
FROM SalesLT.Customer
WHERE YEAR(ModifiedDate) = 2007;

-- OTRA FORMA
-- SELECT LEFT(ModifiedDate, 15)
-- FROM SalesLT.Customer
-- WHERE ModifiedDate LIKE '%2007%';

-- 1.10
SELECT FirstName
FROM SalesLT.Customer
WHERE PasswordHash LIKE '%/%';

-- 1.11
SELECT SalesPerson, COUNT(*) AS Cuenta
FROM SalesLT.Customer
GROUP BY SalesPerson;

/*
SELECT *
FROM SalesLT.Customer
WHERE SalesPerson = 'adventure-works\pamela10';
*/

-- 1.12
SELECT City
FROM SalesLT.Address
GROUP BY City;

-- 1.13
SELECT CountryRegion, SUM(AddressID)
FROM SalesLT.Address
GROUP BY CountryRegion;

/*
SELECT MAX(CountryRegion), SUM(AddressID)
FROM SalesLT.Address;
*/

-- 1.14
SELECT AVG(CAST(PostalCode AS INT))
FROM SalesLT.Address
WHERE CountryRegion = 'United States'
AND PostalCode NOT LIKE '%-%';

-- 1.15
SELECT AVG(CAST(PostalCode AS INT))
FROM SalesLT.Address
WHERE CountryRegion = 'Canada';
--AND PostalCode NOT LIKE '%[A-Z]%'

-- 1.16
SELECT Color, MIN(Size), Max(Size)
FROM SalesLT.Product
GROUP BY Color;

-- 1.17
SELECT Color, AVG(Weight)
FROM SalesLT.Product
GROUP BY Color;

-- 1.18



-- 1.19
SELECT SellEndDate-SellStartDate
FROM SalesLT.Product
WHERE SellEndDate-SellStartDate IS NOT NULL;

-- 1.20
SELECT DATEDIFF(YEAR, SellStartDate, SellEndDate)
FROM SalesLT.Product
WHERE SellEndDate - SellStartDate IS NOT NULL;

-- 1.21
SELECT ProductNumber, ListPrice - StandardCost
AS Beneficio
FROM SalesLT.Product;

/*Ejercicio 1.22.   
(Empleando una subconsulta) Muestra todos los datos 
del Product con mayor beneficio. No se puede buscar a 
mano, ni emplear el valor del beneficio máximo 
directamente en la consulta, ni ordenar los resultados 
para luego limitar la salida a una sola fila.*/
-- busco el product cuyo beneficio
-- es igual al beneficio máximo
SELECT * 
FROM SalesLT.Product
WHERE ListPrice-StandardCost = (
    SELECT MAX(ListPrice-StandardCost) 
    FROM SalesLT.Product
);

/*Ejercicio 1.23.   
Muestra para cada categoría la suma de los beneficios 
de sus Product.*/
SELECT ProductCategoryID, SUM(ListPrice-StandardCost)
FROM SalesLT.Product
GROUP BY ProductCategoryID;
/*La columna 'SalesLT.Product.ProductCategoryID' 
de la lista de selección no es válida, 
porque no está contenida en una función de 
agregado ni en la cláusula GROUP BY.*/
SELECT A.Name, SUM(B.ListPrice-B.StandardCost)
FROM SalesLT.ProductCategory AS A 
LEFT JOIN SalesLT.Product AS B
ON A.ProductCategoryID = B.ProductCategoryID
GROUP BY A.Name;

/*Ejercicio 1.24.   
(Empleando una subconsulta) Muestra el id de la 
categoría más rentable (con mayor beneficio).*/
SELECT ProductCategoryID
FROM SalesLT.Product
GROUP BY ProductCategoryID
HAVING SUM(ListPrice-StandardCost)=(
    SELECT MAX(Beneficio) 
    FROM (SELECT SUM(ListPrice-StandardCost) AS Beneficio
    FROM SalesLT.Product
    GROUP BY ProductCategoryID) AS Misco
);

-- 1.25
SELECT OrderQty, UnitPrice, UnitPriceDiscount, LineTotal
FROM SalesLT.SalesOrderDetail;

-- 1.26
SELECT OrderQty, UnitPrice, UnitPriceDiscount, LineTotal,
OrderQty*UnitPrice*(1-UnitPriceDiscount) AS MisTotales
FROM SalesLT.SalesOrderDetail
WHERE ROUND(LineTotal,4)
<> OrderQty*UnitPrice*(1-UnitPriceDiscount);

-- 1.27
SELECT MIN(OrderQty) -- UnitPriceDiscount
FROM SalesLT.SalesOrderDetail
WHERE UnitPriceDiscount > 0;

-- 1.28
SELECT ProductID, SUM(LineTotal)
FROM SalesLT.SalesOrderDetail
GROUP BY ProductID;

-- 1.29
SELECT MAX(OrderQty)
FROM SalesLT.SalesOrderDetail
WHERE UnitPriceDiscount=0;

-- 1.30
SELECT *
FROM SalesLT.SalesOrderDetail
WHERE LineTotal = (
	SELECT MIN(LineTotal)
	FROM SalesLT.SalesOrderDetail
);

-- 1.31
SELECT LEFT(rowguid,1), AVG(LineTotal)
FROM SalesLT.SalesOrderDetail
GROUP BY LEFT(rowguid,1);

-- 1.32
SELECT rowguid
FROM SalesLT.SalesOrderDetail
WHERE UPPER(rowguid) LIKE '%G%';

-- 1.33
SELECT rowguid
FROM SalesLT.SalesOrderDetail
WHERE LOWER(rowguid) LIKE '%[g-z]%';

-- 1.34
SELECT rowguid
FROM SalesLT.SalesOrderDetail
WHERE rowguid NOT LIKE '%[0-9]%'
OR UPPER(rowguid) NOT LIKE '%[A-F]%';

-- 1.35
--??

-- 1.36
SELECT SubTotal, TaxAmt, Freight, TotalDue
FROM SalesLT.SalesOrderHeader;

-- 1.37
SELECT SubTotal, TaxAmt, Freight, TotalDue,
SubTotal+TaxAmt+Freight+TotalDue AS TotalDeYo
FROM SalesLT.SalesOrderHeader
WHERE SubTotal+TaxAmt+Freight<>TotalDue;

-- 1.38
SELECT *
FROM SalesLT.SalesOrderHeader
WHERE ModifiedDate <> (
	SELECT AVG(ModifiedDate)
	FROM SalesLT.SalesOrderHeader
);

-- 1.39
SELECT Name
FROM SalesLT.ProductCategory
WHERE ProductCategoryID IN(
	SELECT ParentProductCategoryID
	FROM SalesLT.ProductCategory
);

-- 1.40
SELECT Name
FROM SalesLT.ProductCategory
WHERE ProductCategoryID NOT IN(
	SELECT ParentProductCategoryID
	FROM SalesLT.ProductCategory
	WHERE ParentProductCategoryID IS NOT NULL
);

-- 2.1
SELECT A.Description, B.Culture
FROM SalesLT.ProductDescription AS A
JOIN SalesLT.ProductModelProductDescription AS B
ON A.ProductDescriptionID = B.ProductDescriptionID;

-- 2.2
SELECT A.Description, B.Culture
FROM SalesLT.ProductDescription AS A,
SalesLT.ProductModelProductDescription AS B
WHERE A.ProductDescriptionID = B.ProductDescriptionID;

-- 2.3
SELECT A.Name, B.Culture
FROM SalesLT.ProductModel AS A LEFT JOIN
SalesLT.ProductModelProductDescription AS B
ON B.ProductModelID = A.ProductModelID;

/*
SELECT B.Name, A.Culture
FROM SalesLT.ProductModelProductDescription AS A RIGHT JOIN
SalesLT.ProductModel AS B
ON B.ProductModelID = A.ProductModelID;
*/

-- 2.4
SELECT A.Name, B.Culture
FROM SalesLT.ProductModel AS A LEFT JOIN
SalesLT.ProductModelProductDescription AS B
ON B.ProductModelID = A.ProductModelID
WHERE B.Culture IS NULL;

-- 2.5




-- 2.6
SELECT A.Name
FROM SalesLT.ProductModel AS A
WHERE A.ProductModelID NOT IN
	(SELECT ProductModelID
	FROM SalesLT.ProductModelProductDescription
);

-- 2.7
SELECT A.Name, B.Name
FROM SalesLT.Product AS A
JOIN SalesLT.ProductModel AS B
ON A.ProductModelID = B.ProductModelID;

-- 2.8
/*Ejercicio 2.8.	
Filtra los resultados del Ejercicio 2.7 para limitar los resultados a aquellos cuyo size no incluya números. Pista: se puede hacer de forma similar al Ejercicio 1.33.*/
SELECT A.Name, B.Name, Size
FROM SalesLT.Product AS A
JOIN SalesLT.ProductModel AS B
ON A.ProductModelID = B.ProductModelID
WHERE Size NOT LIKE '%[0-9]%';
/*Ejercicio 2.9.	
Empleando algún JOIN, muestra el name de los ProductModel que no tienen un Product
asociado. ¿Se podría hacer mediante producto cartesiano? */

SELECT A.Name--, B.Name
FROM SalesLT.ProductModel AS A
LEFT JOIN SalesLT.Product AS B
ON A.ProductModelID=B.ProductModelID
WHERE B.ProductModelID IS NULL;

SELECT A.Name--, B.Name
FROM SalesLT.ProductModel AS A
LEFT JOIN SalesLT.Product AS B
ON A.ProductModelID=B.ProductModelID
EXCEPT
SELECT A.Name
FROM SalesLT.ProductModel AS A
JOIN SalesLT.Product
ON A.ProductModelID = SalesLT.Product.ProductModelID;


/*Ejercicio 2.10.	
Repite el Ejercicio 2.9 mediante una subconsulta.*/

SELECT Name 
FROM SalesLT.ProductModel AS A
WHERE A.ProductModelID NOT IN(
	SELECT ProductModelID
	FROM SalesLT.Product
);

-- 2.11
SELECT NAME
FROM SalesLT.ProductCategory
WHERE ProductCategoryID NOT IN (
	SELECT ProductCategoryID
	FROM SalesLT.Product
);

-- 2.12
SELECT A.Name, AVG(B.StandardCost) AS 'Media de cosas'
FROM SalesLT.ProductCategory AS A
JOIN SalesLT.Product AS B
ON A.ParentProductCategoryID = b.ProductCategoryID
GROUP BY A.Name;

-- 2.13
SELECT A.Name, AVG(B.StandardCost) AS 'Media de grupo'
FROM SalesLT.ProductCategory AS A
JOIN SalesLT.Product AS B
ON A.ParentProductCategoryID = b.ProductCategoryID
GROUP BY A.Name
HAVING AVG(B.StandardCost) > (
	SELECT AVG(StandardCost)
	FROM SalesLT.Product
);

-- 2.14
/*
SELECT B.Name, MIN(A.Color), MAX(A.Color)
FROM SalesLT.Product AS A
JOIN SalesLT.ProductCategory AS B
ON A.ProductCategoryID = B.ProductCategoryID
*/
-- esto da error

SELECT B.Name, MIN(A.Color), MAX(A.Color)
FROM SalesLT.Product AS A
JOIN SalesLT.ProductCategory AS B
ON A.ProductCategoryID = B.ProductCategoryID
GROUP BY B.Name;

-- 2.15
SELECT B.Name, MIN(A.Color), MAX(A.Color)
FROM SalesLT.Product AS A
JOIN SalesLT.ProductCategory AS B
ON A.ProductCategoryID = B.ProductCategoryID
GROUP BY B.Name
HAVING MIN(A.Color) = MAX(A.Color);

-- 2.16
SELECT B.Name, MIN(A.Color), MAX(A.Color)
FROM SalesLT.Product AS A
JOIN SalesLT.ProductCategory AS B
ON A.ProductCategoryID = B.ProductCategoryID
GROUP BY B.Name
HAVING COUNT(DISTINCT A.Color) = 1;

-- 2.17
-- el id de categoria sale en los parent
SELECT B.Name, SUM(A.Weight)
FROM SalesLT.Product AS A
JOIN SalesLT.ProductCategory AS B 
ON A.ProductCategoryID = B.ProductCategoryID
WHERE B.ProductCategoryID IN 
	(SELECT ParentProductCategoryID
	FROM SalesLT.ProductCategory
	WHERE ParentProductCategoryID IS NOT NULL)
GROUP BY B.Name;

-- 2.18
SELECT COUNT(A.ProductCategoryID)
FROM SalesLT.ProductCategory AS A
JOIN SalesLT.Product AS B 
ON A.ProductCategoryID = B.ProductCategoryID
GROUP BY B.ThumbnailPhotoFileName;

-- 2.19
SELECT B.ThumbnailPhotoFileName
FROM SalesLT.ProductCategory AS A
RIGHT JOIN SalesLT.Product AS B
ON A.ProductCategoryID = B.ProductCategoryID
WHERE A.ProductCategoryID IS NULL;

-- 2.20
SELECT A.SalesOrderID, A.SubTotal, SUM(B.LineTotal)
FROM SalesLT.SalesOrderHeader AS A 
JOIN SalesLT.SalesOrderDetail AS B
ON A.SalesOrderID = B.SalesOrderID
GROUP BY A.SalesOrderID, A.SubTotal;













