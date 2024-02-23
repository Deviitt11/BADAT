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

-- 1.22










