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










