use [AdventureWorks2008R2]
-- explicar SELECT y FROM, explicar el *
    SELECT * FROM Production.Product

-- explicar campos en lugar de *
    SELECT	Name ,color,ListPrice FROM	Production.Product

-- explicar columnas autocalculables
	SELECT	Name ,ListPrice ,ListPrice * 1.21 FROM	Production.Product

-- explicar alias
    SELECT	Name producto,
			ListPrice "precio de lista",
			ListPrice * 1.21[precio con IVA]
	FROM	Production.Product

-- explicar columnas agregadas
    SELECT	21 as iva,
			Name producto,
			ListPrice "precio de lista",
			ListPrice * 1.21[precio con IVA]
	FROM	Production.Product
	

-- explicar operadores numericos y uso de comilla simple
    SELECT * FROM Sales.SalesOrderHeader WHERE SalesOrderNumber = 'SO43700'
    SELECT * FROM Sales.SalesOrderHeader WHERE SalesOrderNumber !='SO43700'
    SELECT * FROM Sales.SalesOrderHeader WHERE SalesOrderNumber <> 'SO43700'
    SELECT  * FROM Production.Product WHERE ListPrice > 2000
    SELECT  * FROM Production.Product WHERE color is null
    SELECT  * FROM Production.Product WHERE color is not null
	
    SELECT	Name producto,
			ListPrice "precio de lista",
			ListPrice * 1.21[precio con IVA],
			ISNULL(color,'sin color') AS color
	FROM    Production.Product
 
   
 -- explicar operadores logicos
   SELECT  * FROM Production.Product WHERE ListPrice >= 1500 and ListPrice <= 2000
   SELECT  * FROM Production.Product Where ListPrice > 1000 and ListPrice < 1500 or ListPrice > 2000 and ListPrice < 2500 
   SELECT  * FROM  Production.Product Where ListPrice = 25 or ListPrice = 120
  
-- explicar BETWEEN y NOT BETWEEN
    SELECT  * FROM Production.Product Where ListPrice BETWEEN 1500 AND 2000
    SELECT  * FROM Production.Product Where ListPrice NOT BETWEEN 1500 AND 2000
    SELECT  * FROM Production.Product Where ListPrice NOT BETWEEN 1500 AND 2000

-- explicar IN y NOT IN
    SELECT  * FROM  Production.Product Where ListPrice IN (25,120)
    SELECT  * FROM  Production.Product Where ListPrice NOT IN (25,120)

-- explicar LIKE  %  _
    SELECT * FROM Person.Person WHERE LastName LIKE '%ez'
	SELECT * FROM Person.Person WHERE LastName NOT LIKE '%ez'
    SELECT * FROM Person.Person WHERE FirstName  LIKE 'm_r%'
	SELECT * FROM HumanResources.Employee WHERE HireDate LIKE '%2004%'
    SELECT * FROM HumanResources.Employee WHERE HireDate LIKE '%200[3,4]%' 
	SELECT * FROM HumanResources.Employee WHERE HireDate LIKE '%200[2-4]%'
	SELECT * FROM HumanResources.Employee WHERE HireDate LIKE '%200[^4]%'
	SELECT * FROM Person.Person WHERE FirstName LIKE 'a[^z]%'

 
-- explicar ORDER BY

    SELECT  * FROM Production.Product ORDER BY ListPrice ASC
    SELECT  * FROM Production.Product ORDER BY ListPrice DESC
    SELECT  * FROM Production.Product ORDER BY ListPrice 
	SELECT * FROM Production.Product WHERE color not like '%red%' ORDER BY  ListPrice DESC
	SELECT * FROM Production.Product WHERE color not like '%red%' ORDER BY  ListPrice DESC,name

	SELECT		Name ,
				color,
				ListPrice 
	FROM		Production.Product 
	WHERE		color not like '%red%' 
	ORDER BY	3 DESC,1

-- explicar DISTINCT

SELECT JobTitle
FROM HumanResources.Employee

SELECT DISTINCT(JobTitle)
FROM HumanResources.Employee
ORDER BY 1

SELECT	count(DISTINCT(JobTitle))
FROM	HumanResources.Employee


-- funciones de agrupacion

SELECT count(*) FROM Production.Product

SELECT count(color) FROM Production.Product -- las funciones no cuentan los NULL

SELECT avg(ListPrice) AS "precio promedio" FROM Production.Product

SELECT sum(OrderQty) AS "total de productos vendidos" FROM Sales.SalesOrderDetail 


SELECT max(ListPrice) AS "producto mas caro", min(ListPrice) AS "producto mas barato" FROM Production.Product 

SELECT max(Weight) AS "producto mas pesado", min(Weight) AS "producto mas liviano" FROM Production.Product 


SELECT	avg(Weight) AS "precio promedio" , 
		sum(Weight)/count(Weight) AS "precio promedio 2" ,
		sum(Weight)/count(*) AS "precio promedio 3"
FROM	Production.Product

--compute y compute by

select	* 
from	Production.Product
compute avg(ListPrice)


SELECT		*
FROM		Production.Product
ORDER BY	color 
COMPUTE		avg(ListPrice),count(ProductID)
BY			color
