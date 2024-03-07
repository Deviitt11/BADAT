USE AdventureWorksLT2019;

-- 1.1
/*
Muestra todos los datos de aquellas ProductCategory que no tienen una
categoría "parent" (4 filas)
*/
SELECT *
FROM SalesLT.ProductCategory
WHERE ParentProductCategoryID IS NULL;

-- 1.2
/*
Muestra el Name y el StandardCost de los Product cuya categoría es 5 (32 filas)
*/
SELECT Name, StandardCost
FROM SalesLT.Product
WHERE ProductCategoryID = 5;

-- 1.3
/*
Muestra el Name y el Size de los Product cuya ProductModelID es 8 (10 filas)
*/
SELECT Name, Size
FROM SalesLT.Product
WHERE ProductModelID = 8;

-- 1.4
/*
Muestra cuantas ProductCategory tienen como Parent la categoría 3 
(mediante una consulta, no leyendo el tamaño de la tabla obtenida) (1 fila)
*/
SELECT COUNT(*) 
FROM SalesLT.ProductCategory
WHERE ParentProductCategoryID = 3;

-- 1.5
/*
Muestra el nombre y el email de aquellos Customers cuyo email empieza por "j"
independientemente de como esté escrito (mayús o minus) (1 fila)
*/
SELECT FirstName, EmailAddress
FROM SalesLT.Customer
WHERE LOWER(EmailAddress) LIKE 'j%';
-- LEFT(LOWER(EmailAddress), 1) = 'j';

-- 1.6
/*
Muestra los distintos títulos que hay en la relación de Customer
*/
SELECT DISTINCT Title
FROM SalesLT.Customer;

-- 1.7
/*
Muestra para cada título en la relación Customer, cuantos clientes hay de cada tipo.
Es decir, muestra el titulo "Mr." y cuantos hay,
el titulo "Ms." y cuantas hay, etc... (5 filas)
*/
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
/*
Muestra cuantos (no cuales) Customer no tienen un nombre intermedio (1 fila)
*/
SELECT COUNT(*)
FROM SalesLT.Customer
WHERE MiddleName IS NULL;

-- 1.9
/*
Muestra el nombre de aquellos Customer cuyos datos se modificaron a lo largo
del año 2007 (210 filas)
*/
SELECT FirstName
FROM SalesLT.Customer
WHERE YEAR(ModifiedDate) = 2007;

-- OTRA FORMA
-- SELECT LEFT(ModifiedDate, 15)
-- FROM SalesLT.Customer
-- WHERE ModifiedDate LIKE '%2007%';

-- 1.10
/*
Muestra el nombre de los Customer cuya PasswordHash incluya "/" (388 filas)
*/
SELECT FirstName
FROM SalesLT.Customer
WHERE PasswordHash LIKE '%/%';

-- 1.11
/*
Muestra para cada SalesPerson, cuantos clientes tiene registrados.
Es decir, ha de verse el nombre de SalesPerson y al lado, el número de clientes (9 filas)
*/
SELECT SalesPerson, COUNT(*) AS Cuenta
FROM SalesLT.Customer
GROUP BY SalesPerson;

/*
SELECT *
FROM SalesLT.Customer
WHERE SalesPerson = 'adventure-works\pamela10';
*/

-- 1.12
/*
Empleando GROUP BY, muestras las diferentes ciudades presentes en la tabla Address (269 filas).
*/
SELECT City
FROM SalesLT.Address
GROUP BY City;

-- 1.13
/*
Muestra para cada CountryRegion de la tabla Address, la suma de sus IDs (3 filas).
*/
SELECT CountryRegion, SUM(AddressID)
FROM SalesLT.Address
GROUP BY CountryRegion;

/*
SELECT MAX(CountryRegion), SUM(AddressID)
FROM SalesLT.Address;
*/

-- 1.14
/*
Desde la tabla Address, muestra la media de los códigos postales de "United States"
que no contengan un guión (1 fila).
*/
SELECT AVG(CAST(PostalCode AS INT))
FROM SalesLT.Address
WHERE CountryRegion = 'United States'
AND PostalCode NOT LIKE '%-%';

-- 1.15
/*
Repite la consulta anterior pero para Canadá.
¿Qué fallo se produce y por qué?
*/
SELECT AVG(CAST(PostalCode AS INT))
FROM SalesLT.Address
WHERE CountryRegion = 'Canada';
--AND PostalCode NOT LIKE '%[A-Z]%'

-- 1.16
/*
Muestra para cada color de Product, el valor mínimo y máximo de Size.
¿Se podría calcular la suma o la media? ¿Por qué? (10 filas)
*/
SELECT Color, MIN(Size), Max(Size)
FROM SalesLT.Product
GROUP BY Color;

-- 1.17
/*
Muestra para cada color de Product, el valor medio del Weight (10 filas)
*/
SELECT Color, AVG(Weight)
FROM SalesLT.Product
GROUP BY Color;

-- 1.18
/*
Repite la consulta anterior pero descartando aquellos valores cuya media no sea válida (7 filas)
*/

-- 1.19
/*
Muestra la diferencia entra la SellEndDate y la SellStartDate de todos los productos,
descartando aquellos casos en los que la diferencia no sea válida.
¿Tienen sentido los resultados obtenidos? (98 filas)
*/
SELECT SellEndDate-SellStartDate
FROM SalesLT.Product
WHERE SellEndDate-SellStartDate IS NOT NULL;

-- 1.20
/*
Repite la consulta anterior empleando DATEDIFF(year, SellStartDate, SellEndDate) (98 filas)
*/
SELECT DATEDIFF(YEAR, SellStartDate, SellEndDate)
FROM SalesLT.Product
WHERE SellEndDate - SellStartDate IS NOT NULL;

-- 1.21
/*
Muestra para cada ProductNumber su beneficio: la diferencia entre el ListPrice y el StandardCost (295 filas)
*/
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
/*
Muestra de la tabla SalesOrderDetail los campos OrderQty, UnitPrice, UnitPriceDiscount
y LineTotal. ¿Qué relación habrá entre estos campos?
*/
SELECT OrderQty, UnitPrice, UnitPriceDiscount, LineTotal
FROM SalesLT.SalesOrderDetail;

-- 1.26
/*
Comprueba que esta relación se cumple a lo largo de la tabla.
Primero expresa la relación de forma matemática y luego haz una consulta con ella,
obteniendo el valor esperado y el real. ¿De qué forma sencilla
se puede comprobar si hay alguna discrepancia?
*/
SELECT OrderQty, UnitPrice, UnitPriceDiscount, LineTotal,
OrderQty*UnitPrice*(1-UnitPriceDiscount) AS MisTotales
FROM SalesLT.SalesOrderDetail
WHERE ROUND(LineTotal,4)
<> OrderQty*UnitPrice*(1-UnitPriceDiscount);

-- 1.27
/*
Muestra el menor número de items que tiene un descuento
(UnitPriceDiscount) asociado en la tabla SalesOrderDetail
*/
SELECT MIN(OrderQty) -- UnitPriceDiscount
FROM SalesLT.SalesOrderDetail
WHERE UnitPriceDiscount > 0;

-- 1.28
/*
En la tabla de SalesOrderDetail, muestra para cada ProductID,
la suma de su LineTotal
*/
SELECT ProductID, SUM(LineTotal)
FROM SalesLT.SalesOrderDetail
GROUP BY ProductID;

-- 1.29
/*
Muestra el mayor de items que NO tiene un descuento (UnitPriceDiscount)
asociado en la tabla SalesOrderDetail
*/
SELECT MAX(OrderQty)
FROM SalesLT.SalesOrderDetail
WHERE UnitPriceDiscount=0;

-- 1.30
/*
En la tabla de SalesOrderDetail, muestra todos los datos del
menor LineTotal presente
*/
SELECT *
FROM SalesLT.SalesOrderDetail
WHERE LineTotal = (
	SELECT MIN(LineTotal)
	FROM SalesLT.SalesOrderDetail
);

-- 1.31
/*
En la tabla de SalesOrderDetail, muestra para cada primer carácter
de rowguid (empleando la función LEFT), la media de su LineTotal,
¿En qué codificación estará guardado el rowguid?
*/
SELECT LEFT(rowguid,1), AVG(LineTotal)
FROM SalesLT.SalesOrderDetail
GROUP BY LEFT(rowguid,1);

-- 1.32
/*
Comprueba la codificación del SalesOrderDetail.rowguid buscando
algún carácter que no pertenezca a dicha codificación,
como puede ser la 'G'. Para ello, muestra aquellos rowguid
que contengan la letra 'G' (podría estar en mayus o minus)
*/
SELECT rowguid
FROM SalesLT.SalesOrderDetail
WHERE UPPER(rowguid) LIKE '%G%';

-- 1.33
/*
Muestra los SalesOrderDetail.rowguid que tienen alguna letra
entre 'g' y 'z' empleando '%[g-z]%' con la sentencia LIKE
*/
SELECT rowguid
FROM SalesLT.SalesOrderDetail
WHERE LOWER(rowguid) LIKE '%[g-z]%';

-- 1.34
/*
(Similar al anterior) Muestra los SalesOrderDetail.rowguid
que NO tienen alguna letra entre '0' y '9' o entre 'A' y 'F'
*/
SELECT rowguid
FROM SalesLT.SalesOrderDetail
WHERE rowguid NOT LIKE '%[0-9]%'
OR UPPER(rowguid) NOT LIKE '%[A-F]%';

-- 1.35
/*
(Similar al anterior) En la consulta anterior te habrán salido
rowguid ya que tienen un carácter adicional. Muestra los
SalesOrderDetail.rowguid que NO tienen alguna letra 
entre '0' y '9' o entre 'A' y 'F' y que tampoco tienen ese
carácter adicional
*/
--??

-- 1.36
/*
(Similar al 1.25) Muestra de la tabla SalesOrderHeader los
campos SubTotal, TaxAmt, Freight y TotalDue.
¿Qué relación habrá entre ellos?
*/
SELECT SubTotal, TaxAmt, Freight, TotalDue
FROM SalesLT.SalesOrderHeader;

-- 1.37
/*
(Similar al 1.26) Comprueba que esta relación se cumple a lo largo
de la tabla. Primero expresa la relación de forma matemática y luego haz
una consulta con ella, obteniendo el valor esperado y el real.
¿De qué forma sencilla se puede comprobar si hay alguna discrepancia?
*/
SELECT SubTotal, TaxAmt, Freight, TotalDue,
SubTotal+TaxAmt+Freight+TotalDue AS TotalDeYo
FROM SalesLT.SalesOrderHeader
WHERE SubTotal+TaxAmt+Freight<>TotalDue;

-- 1.38
/*
(Con una subconsulta) Muestra todos los datos de SalesOrderHeader
de las tuplas cuya ModifiedDate es diferente del valor medio de ModifiedDate
*/

/*
SELECT *
FROM SalesLT.SalesOrderHeader
WHERE ModifiedDate <> (
	AVG(ModifiedDate)
	FROM SalesLT.SalesOrderHeader
);
*/

-- 1.39
/*
(Con una subconsulta) Muestra los name de aquellas ProductCategory
que sean madres de otras, es decir, que aparezcan en ParentProductCategoryID
*/
SELECT Name
FROM SalesLT.ProductCategory
WHERE ProductCategoryID IN(
	SELECT ParentProductCategoryID
	FROM SalesLT.ProductCategory
);

-- 1.40
/*
(Con una subconsulta) Muestra los name de aquellas ProductCategory
que solo sean hijas de otras. ¿Cómo se podría plantear?
*/
SELECT Name
FROM SalesLT.ProductCategory
WHERE ProductCategoryID NOT IN(
	SELECT ParentProductCategoryID
	FROM SalesLT.ProductCategory
	WHERE ParentProductCategoryID IS NOT NULL
);

-- DOS TABLAS

-- 2.1
/*
Empleando JOIN: a partir de las tablas ProductDescription y
ProductModelProductDescription, muestra junto cada Culture,
la Description del Product asociado
*/
SELECT A.Description, B.Culture
FROM SalesLT.ProductDescription AS A
JOIN SalesLT.ProductModelProductDescription AS B
ON A.ProductDescriptionID = B.ProductDescriptionID;

-- 2.2
/*
Repite el 2.1 empleando el producto cartesiano (el "clásico" o CROSS JOIN)
*/
SELECT A.Description, B.Culture
FROM SalesLT.ProductDescription AS A,
SalesLT.ProductModelProductDescription AS B
WHERE A.ProductDescriptionID = B.ProductDescriptionID;

-- 2.3
/*
Muestra para cada name de ProductModel, su culture asociado (tenga culture o no)
*/
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
/*
Filtra la consulta anterior para obtener que name de ProductModel
no tiene un culture asociado. ¿Se podría realizar esta consulta con
producto cartesiano? ¿Por qué?
*/
SELECT A.Name, B.Culture
FROM SalesLT.ProductModel AS A LEFT JOIN
SalesLT.ProductModelProductDescription AS B
ON B.ProductModelID = A.ProductModelID
WHERE B.Culture IS NULL;

-- 2.5
/*
Repite el 2.4 mediante (INNER) JOIN.
*/


-- 2.6
/*
Repite el 2.4 mediante una subconsulta
*/
SELECT A.Name
FROM SalesLT.ProductModel AS A
WHERE A.ProductModelID NOT IN
	(SELECT ProductModelID
	FROM SalesLT.ProductModelProductDescription
);

-- 2.7
/*
Muestra el name del Product junto con el name del ProductModel asociado
*/
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

/*
2.11
Muestra que categories (names de ProductCategory) no se usan
(en Product)
*/
SELECT NAME
FROM SalesLT.ProductCategory
WHERE ProductCategoryID NOT IN (
	SELECT ProductCategoryID
	FROM SalesLT.Product
);

-- 2.12
/*
Muestra para cada name de ProductCategory, la media de los
StandardCost de los Product asociados. Es decir, que se vea
el name junto a la media
*/
SELECT A.Name, AVG(B.StandardCost) AS 'Media de cosas'
FROM SalesLT.ProductCategory AS A
JOIN SalesLT.Product AS B
ON A.ParentProductCategoryID = b.ProductCategoryID
GROUP BY A.Name;

-- 2.13
/*
Filtra la consulta del 2.12 de forma que solo se muestren los
name cuya media de StandardCost supere el valor medio de todos
los StandardCost de Product.
*/
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
Muestra para cada name de ProductCategory, el menor y el mayor
Color de los Product asociados
*/

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
/*
Filtra la consulta del 2.14 de forma que se muestren aquellos
name que tengan un solo color, idea: puedes comprobar si el
mínimo y el máximo son iguales
*/
SELECT B.Name, MIN(A.Color), MAX(A.Color)
FROM SalesLT.Product AS A
JOIN SalesLT.ProductCategory AS B
ON A.ProductCategoryID = B.ProductCategoryID
GROUP BY B.Name
HAVING MIN(A.Color) = MAX(A.Color);

-- 2.16
/*
Repite la consulta anterior empleando COUNT.
Ayuda: puedes usar COUNT(DISTINCT atributo)
*/
SELECT B.Name, MIN(A.Color), MAX(A.Color)
FROM SalesLT.Product AS A
JOIN SalesLT.ProductCategory AS B
ON A.ProductCategoryID = B.ProductCategoryID
GROUP BY B.Name
HAVING COUNT(DISTINCT A.Color) = 1;

-- 2.17
-- el id de categoria sale en los parent
/*
Muestra para cada ParentProductCategoryID de ProductCategory,
el name de la categoría junto con la suma de los weight de los
Product asociados
*/
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
/*
Muestra cuantos ProductCategory hay asociados a cada
ThumbnailPhotoFileName de Product.
*/
SELECT COUNT(A.ProductCategoryID)
FROM SalesLT.ProductCategory AS A
JOIN SalesLT.Product AS B 
ON A.ProductCategoryID = B.ProductCategoryID
GROUP BY B.ThumbnailPhotoFileName;

-- 2.19
/*
Muestra que ThumbnailPhotoFileName de Product no están asociados
a ningún ProductCategory. ¿Qué tipo de JOIN será necesario hacer?
*/
SELECT B.ThumbnailPhotoFileName
FROM SalesLT.ProductCategory AS A
RIGHT JOIN SalesLT.Product AS B
ON A.ProductCategoryID = B.ProductCategoryID
WHERE A.ProductCategoryID IS NULL;

-- 2.20
/*
Compara para cada SalesOrderID, el valor del SubTotal (en SalesOrderHeader)
con el de la suma de los sus LineTotal asociados (en SalesOrderDetail)
*/
SELECT A.SalesOrderID, A.SubTotal, SUM(B.LineTotal)
FROM SalesLT.SalesOrderHeader AS A 
JOIN SalesLT.SalesOrderDetail AS B
ON A.SalesOrderID = B.SalesOrderID
GROUP BY A.SalesOrderID, A.SubTotal;

-- 2.21
SELECT CustomerID, SUM(LineTotal)
FROM SalesLT.SalesOrderHeader AS A
JOIN SalesLT.SalesOrderDetail AS B
ON A.SalesOrderID = B.SalesOrderID
GROUP BY CustomerID;

-- 2.22
SELECT CustomerID, SUM(LineTotal)
FROM SalesLT.SalesOrderHeader AS A
JOIN SalesLT.SalesOrderDetail AS B
ON A.SalesOrderID = B.SalesOrderID
GROUP BY CustomerID
HAVING SUM(LineTotal) = (
	SELECT MAX(suma)
	FROM (
			SELECT SUM(LineTotal) AS suma
			FROM SalesLT.SalesOrderHeader AS A
			JOIN SalesLT.SalesOrderDetail AS B
			ON A.SalesOrderID = B.SalesOrderID
			GROUP BY CustomerID)
	AS Misco
);

-- 2.23
SELECT SOD.ProductID, AVG(SOH.SubTotal)
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
GROUP BY SOD.ProductID;

-- 2.24
SELECT SOD.ProductID, AVG(SOH.SubTotal)
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
GROUP BY SOD.ProductID
HAVING AVG(SOH.SubTotal) > (
	SELECT AVG(SubTotal)
	FROM SalesLT.SalesOrderHeader
);

-- 2.25
SELECT AddressID, CustomerID
FROM SalesLT.Address
CROSS JOIN SalesLT.Customer;
-- from SalesLT.Address, SalesLT.Customer

-- 2.26
SELECT A.CustomerID, A.EmailAddress, B.CustomerID, B.EmailAddress
FROM SalesLT.Customer AS A,
SalesLT.Customer AS B
WHERE A.EmailAddress = B.EmailAddress
AND A.CustomerID <> B.CustomerID;

-- 2.27

-- VARIAS TABLAS

-- 3.1
SELECT C.Name, A.Name, B.Name
FROM SalesLT.ProductCategory AS A
JOIN SalesLT.ProductCategory AS B
ON A.ParentProductCategoryID = B.ProductCategoryID
JOIN SalesLT.Product AS C
ON C.ProductCategoryID = A.ProductCategoryID;

-- 3.2
/*
SELECT A.AddressID, B.CustomerID
FROM SalesLT.Address AS A, SalesLT.Customer B
CROSS JOIN SalesLT.CustomerAddress AS C
ON A.AddressID = C.AddressID 
AND B.CustomerID = C.CustomerID;
*/
-- from SalesLT.Address, SalesLT.Customer

-- 3.3
SELECT A.EmailAddress, SUM(SubTotal), COUNT(C.SalesOrderDetailID)
FROM SalesLT.Customer AS A
JOIN SalesLT.SalesOrderHeader AS B
ON A.CustomerID = B.CustomerID
JOIN SalesLT.SalesOrderDetail AS C
ON B.SalesOrderID = C.SalesOrderID
GROUP BY A.EmailAddress;

-- 3.4
SELECT A.EmailAddress, B.SalesOrderID, COUNT(C.ProductID)
FROM SalesLT.Customer AS A
JOIN SalesLT.SalesOrderHeader AS B
ON A.CustomerID = B.CustomerID
JOIN SalesLT.SalesOrderDetail AS C
ON B.SalesOrderID = C.SalesOrderID
GROUP BY A.EmailAddress, B.SalesOrderID;

-- 3.5
SELECT CustomerID, COUNT(DISTINCT ProductID)
FROM SalesLT.SalesOrderHeader AS A
JOIN SalesLT.SalesOrderDetail AS B
ON A.SalesOrderID = B.SalesOrderID
GROUP BY CustomerID;

-- 3.6
SELECT CustomerID, COUNT(DISTINCT ProductID)
FROM SalesLT.SalesOrderHeader AS A
JOIN SalesLT.SalesOrderDetail AS B
ON A.SalesOrderID = B.SalesOrderID
WHERE CustomerID%2=0
GROUP BY CustomerID;

-- 3.7
SELECT CustomerID, ProductID, COUNT(DISTINCT ProductID)
FROM SalesLT.SalesOrderHeader AS A
JOIN SalesLT.SalesOrderDetail AS B
ON A.SalesOrderID = B.SalesOrderID
GROUP BY CustomerID, ProductID;

-- 3.8
SELECT CustomerID, ProductID, COUNT(DISTINCT ProductID)
FROM SalesLT.SalesOrderHeader AS A
JOIN SalesLT.SalesOrderDetail AS B
ON A.SalesOrderID = B.SalesOrderID
JOIN SalesLT.Customer AS C
ON A.CustomerID = C.CustomerID
JOIN SalesLT.Customer AS D
ON B.ProductID = D.ProductID
GROUP BY A.CustomerID, ProductID;

-- 3.9
SELECT CustomerID, ProductID, UnitPriceDiscount
FROM SalesLT.SalesOrderHeader AS A
JOIN SalesLT.SalesOrderDetail AS B
ON A.SalesOrderID = B.SalesOrderID;

-- 3.10
SELECT CustomerID, ProductID, UnitPriceDiscount
FROM SalesLT.SalesOrderHeader AS A
JOIN SalesLT.SalesOrderDetail AS B
ON A.SalesOrderID = B.SalesOrderID
WHERE UnitPriceDiscount > 0;