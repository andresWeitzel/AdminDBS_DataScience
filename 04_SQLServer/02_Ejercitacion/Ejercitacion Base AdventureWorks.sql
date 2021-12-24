/* POSICIONARME EN LA BASE AdventureWorks2008R2*/
USE AdventureWorks2008R2

---------------------------------------------------------------------------------------------------------
--SELECT - WHERE
---------------------------------------------------------------------------------------------------------

/* QUERY 1: MOSTRAR LOS EMPLEADOS QUE TIENEN MAS DE 90 HORAS DE VACACIONES */
SELECT *
FROM HumanResources.Employee
WHERE VacationHours>90

/* QUERY 2: MOSTRAR EL NOMBRE, PRECIO Y PRECIO CON IVA DE LOS PRODUCTOS FABRICADOS*/
SELECT	Name producto,
		ListPrice [precio de lista],
		ListPrice * 1.21[precio con IVA]
FROM	Production.Product

/* QUERY 3: MOSTRAR LOS DIFERENTES TITULOS DE TRABAJO QUE EXISTEN*/
SELECT DISTINCT(JobTitle) [tipo de trabajo]
FROM HumanResources.Employee

/*QUERY 4: MOSTRAR TODOS LOS POSIBLES COLORES DE PRODUCTOS */
SELECT DISTINCT color
FROM Production.Product

/*QUERY 5: MOSTRAR TODOS LOS TIPOS DE PESONAS QUE EXISTEN */
SELECT DISTINCT PersonType
FROM Person.Person

/* QUERY 6: MOSTRAR EL NOMBRE CONCATENADO CON EL APELLIDO DE LAS PERSONAS CUYO APELLIDO SEA JOHNSON*/
SELECT FirstName+' '+LastName "Nombre de Persona"
FROM Person.Person
WHERE LastName = 'Johnson'

/* QUERY 7: MOSTRAR TODOS LOS PRODUCTOS CUYO PRECIO SEA INFERIOR A 150$ DE COLOR ROJO O CUYO PRECIO SEA MAYOR A 500$ DE COLOR NEGRO*/
SELECT *
FROM Production.Product
WHERE (ListPrice <= 150 AND Color='red')OR (ListPrice >= 500 AND Color='black')

/* QUERY 8: MOSTRAR EL CODIGO, FECHA DE INGRESO Y HORAS DE VACACIONES DE LOS EMPLEADOS INGRESARON A PARTIR DEL AÑO 2000 */

SELECT	BusinessEntityID AS "codigo de Empleado", 
		HireDate as "fecha de ingreso", 
		VacationHours as "horas de vacaciones"
FROM HumanResources.Employee
WHERE HireDate > '01/01/2000' 

/* QUERY 9: MOSTRAR EL NOMBRE,NMERO DE PRODUCTO, PRECIO DE LISTA Y EL PRECIO DE LISTA INCREMENTADO EN UN 10% DE LOS PRODUSCTOS CUYA FECHA DE FIN DE VENTA SEA ANERIOR AL DIA DE HOY*/
SELECT Name, ProductNumber, ListPrice AS OldPrice, (ListPrice * 1.1) AS NewPrice,*
FROM Production.Product
WHERE SellEndDate < GETDATE()


---------------------------------------------------------------------------------------------------------
--BETWEEN & IN
---------------------------------------------------------------------------------------------------------



/* QUERY 10: MOSTRAR TODOS LOS PORDUCTOS CUYO PRECIO DE LISTA ESTE ENTRE 200 Y 300 */
SELECT * 
FROM Production.Product
WHERE ListPrice BETWEEN 200 AND 300

/* QUERY 11: MOSTRAR TODOS LOS EMPLEADOS QUE NACIERON ENTRE 1970 Y 1985 */
select *
FROM HumanResources.Employee
WHERE BirthDate BETWEEN '1970.01.01' AND '1985.12.31'

/* QUERY 12: MOSTRAR LOS CODIGOS DE VENTA Y PRODUCTO,CANTIDAD DE VENTA Y PRECIO UNITARIO DE LOS ARTICULOS 750,753 Y 770 */
SELECT SalesOrderID, OrderQty, ProductID, UnitPrice
FROM Sales.SalesOrderDetail
WHERE ProductID IN (750, 753, 770)

/* QUERY 13: MOSTRAR TODOS LOS PORDUCTOS CUYO COLOR SEA VERDE, BLANCO Y AZUL */
SELECT *
FROM Production.Product
WHERE Color IN ('green', 'white', 'blue')

/* QUERY 14: MOSTRAR EL LA FECHA,NUERO DE VERSION Y SUBTOTAL DE LAS VENTAS EFECTUADAS EN LOS AÑOS 2005 Y 2006 */
SET DATEFORMAT DMY
GO
SELECT OrderDate, AccountNumber "numero de version", SubTotal
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '01/01/2005' AND '31/12/2006'
ORDER BY 1 ASC


---------------------------------------------------------------------------------------------------------
--LIKE
---------------------------------------------------------------------------------------------------------

/* QUERY 15: MOSTRAR EL NOMBRE, PRECIO Y COLOR DE LOS ACCESORIOS PARA ASIENTOS DE LAS BICICLETAS CUYO PRECIO SEA  MAYOR A 100 PESOS*/
SELECT Name,ListPrice,Color
FROM Production.Product
WHERE Name like '%seat%' and ListPrice>100 

/* QUERY 16: MOSTRAR LAS BICICLETAS DE MONTAÑA QUE  CUESTAN ENTRE $1000 Y $1200 */
SELECT *
FROM Production.Product
WHERE ProductNumber like 'bk%' and ListPrice between 1000 and 1200

 
/* QUERY 17: MOSTRAR LOS NOMBRE DE LOS PRODUCTOS QUE TENGAN CUALQUIER COMBINACION DE MOUNTAIN BIKE */
SELECT Name,ListPrice
FROM Production.Product
WHERE Name LIKE '%Mountain Bike%'


/* QUERY 18: MOSTRAR LAS PERSONAS QUE SU NOMBRE EMPIECE CON LA LETRA Y */
SELECT *
FROM Person.Person
WHERE FirstName LIKE 'y%'

/* QUERY 19: MOSTRAR LAS PERSONAS QUE LA SEGUNDA LETRA DE SU APELLIDO ES UNA S */
SELECT *
FROM Person.Person
WHERE LastName LIKE  '_s%'

/* QUERY 20: MOSTRAR EL NOMBRE CONCATENADO CON EL APELLIDO DE LAS PERSONAS CUYO APELLIDO TENGAN TERMINACION ESPAÑOLA (EZ)*/
SELECT	FirstName nombre,
		LastName apellido
FROM Person.Person
WHERE LastName LIKE '%ez'

/* QUERY 21: MOSTRAR LOS NOMBRES DE LOS PRODUCTOS QUE SU NOMBRE TERMINE EN UN NUMERO */
SELECT name
FROM Production.Product
WHERE name LIKE '%[0-9]' 


/* QUERY 22: MOSTRAR LAS PERSONAS CUYO  NOMBRE TENGA UNA C O c COMO PRIMER CARACTER, 
	CUALQUIER OTRO COMO SEGUNDO CARACTER, NI D NI d NI F NI g COMO TERCER CARACTER, CUALQUIERA 
	ENTRE J Y R O ENTRE S Y W COMO CUARTO CARACTER Y EL RESTO SIN RESTRICCIONES */

SELECT *
FROM Person.Person
WHERE FirstName LIKE'[C,c]_[^DdFg][J-W]%' 



---------------------------------------------------------------------------------------------------------
--UTILIZACION DE ORDER BY
---------------------------------------------------------------------------------------------------------

/* QUERY 23: MOSTRAR las personas ordernadas primero por su apellido y luego por su nombre*/
SELECT *
FROM Person.Person
ORDER BY  Lastname, Firstname


/* QUERY 24: MOSTRAR CINCO PRODUCTOS MAS CAROS Y SU NOMBRE ORDENADO EN FORMA ALFABETICA*/
SELECT top 5 *
FROM Production.Product
ORDER BY  ListPrice desc, name




---------------------------------------------------------------------------------------------------------
--FUNCIONES DE AGRUPACION
---------------------------------------------------------------------------------------------------------


/* QUERY 25: MOSTRAR LA FECHA MAS RECIENTE DE VENTA */
SELECT MAX(OrderDate)
FROM Sales.SalesOrderHeader

/* QUERY 26: MOSTRAR EL PRECIO MAS BARATO DE TODAS LAS BICICLETAS */
SELECT MIN(ListPrice)
FROM Production.Product
WHERE ProductNumber like 'bk%'


/* QUERY 27: MOSTRAR LA FECHA DE NACIMIENTO DEL EMPLEADO MAS JOVEN */
SELECT MIN( e.BirthDate ) as fecha_de_nacimiento
FROM HumanResources.employee e



---------------------------------------------------------------------------------------------------------
--NULL
---------------------------------------------------------------------------------------------------------

/* QUERY 28: MOSTRAR LOS REPRESENTANTES DE VENTAS (VENDEDORES) QUE NO TIENEN DEFINIDO EL NUMERO DE TERRITORIO*/
SELECT	*
FROM	Sales.SalesPerson
WHERE	TerritoryID IS NULL


/* QUERY 29: MOSTRAR EL PESO PROMEDIO DE TODOS LOS ARTICULOS. SI EL PESO NO ESTUVIESE DEFINIDO, REEMPLAZAR POR CERO*/
SELECT AVG(ISNULL(Weight,0)) AS 'AvgWeight'
FROM Production.Product


--UTILIZACION DE GROUP BY

/* QUERY 30: MOSTRAR EL CODIGO DE SUBCATEGORIA Y EL PRECIO DEL PRODUCTO MAS BARATO DE CADA UNA DE ELLAS */
SELECT		ProductSubcategoryID, min(ListPrice)
FROM		Production.Product p
GROUP BY	ProductSubcategoryID


/* QUERY 31: MOSTRAR LOS PRODUCTOS Y LA CANTIDAD TOTAL VENDIDA DE CADA UNO DE ELLOS*/
SELECT		ProductID producto,
			SUM(OrderQty) "cantidad de ventas por producto"
FROM		Sales.SalesOrderDetail
GROUP BY ProductID

/* QUERY 32: MOSTRAR LOS PRODUCTOS Y LA CANTIDAD TOTAL VENDIDA DE CADA UNO DE ELLOS, ORDENARLOS POR MAYOR CANTIDAD DE VENTAS*/
SELECT		ProductID producto,
			SUM(OrderQty) "cantidad de ventas por producto"
FROM		Sales.SalesOrderDetail
GROUP BY ProductID
ORDER BY 2 DESC


/* QUERY 33: MOSTRAR TODAS LAS FACTURAS REALIZADAS Y EL TOTAL FACTURADO DE CADA UNA DE ELLAS ORDENADO POR NRO DE FACT.*/
SELECT SalesOrderID, SUM(UnitPrice*OrderQty) AS SubTotal
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
ORDER BY SalesOrderID



---------------------------------------------------------------------------------------------------------
--UTILIZACION DE HAVING
---------------------------------------------------------------------------------------------------------

/* QUERY 34: MOSTRAR TODAS LAS FACTURAS REALIZADAS Y EL TOTAL FACTURADO DE CADA UNA DE ELLAS ORDENADO POR NRO DE FACTURA
 PERO SOLO DE AQUELLAS ORDENES SUPEREN UN TOTAL DE $10.000 */
SELECT SalesOrderID, SUM(UnitPrice*OrderQty) AS SubTotal
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID
HAVING SUM(UnitPrice*OrderQty) > 10000
ORDER BY SalesOrderID

/* QUERY 35: MOSTRAR LA CANTIDAD DE FACTURAS QUE VENDIERON MAS DE 20 UNIDADES */
SELECT SalesOrderID, SUM(OrderQty) CANTIDAD
FROM SALES.SALESORDERDETAIL 
GROUP BY SalesOrderID
HAVING SUM(OrderQty)>20
ORDER BY 1

/* QUERY 36: MOSTRAR LAS SUBCATEGORIAS DE LOS PRODUCTOS QUE TIENEN DOS O MAS PRODUCTOS QUE CUESTAN MENOS DE $150 */
SELECT ProductSubcategoryID, COUNT(*) CANTIDAD
FROM Production.Product
WHERE ListPrice >150
GROUP BY ProductSubcategoryID
HAVING COUNT(*) >1

/* QUERY 37: MOSTRAR TODOS LOS CODIGOS DE CATEGORIAS EXISTENTES JUNTO CON LA CANTIDAD DE PRODUCTOS Y EL PRECIO DE LISTA PROMEDIO
POR CADA UNO DE AQUELLOS PRODUCTOS QUE CUESTAN MAS DE $70 Y EL PRECIO PROMEDIO ES MAYOR A $300 */
SELECT DISTINCT(ProductSubcategoryID),COUNT(ProductSubcategoryID) STOCK, AVG(ListPrice) PRECIO_PROMEDIO
FROM Production.Product
WHERE ListPrice>7
GROUP BY ProductSubcategoryID
HAVING AVG(ListPrice)>15




---------------------------------------------------------------------------------------------------------
--COMPUTE
---------------------------------------------------------------------------------------------------------

/* QUERY 38: MOSTRAR NUMERO DE FACTURA, EL MONTo VENDIDO Y AL FINAL TOTALIZAR LA FACTURACION */
SELECT SalesOrderID, (UnitPrice*OrderQty) AS SubTotalt
FROM Sales.SalesOrderDetail 
ORDER BY SalesOrderID 
COMPUTE  SUM(UnitPrice*OrderQty)






---------------------------------------------------------------------------------------------------------
--JOINS
---------------------------------------------------------------------------------------------------------

/* QUERY 39:MOSTRAR  LOS EMPLEADOS QUE TAMBIÉN SON VENDEDORES */

SELECT		e.*
FROM		HumanResources.Employee AS e
INNER JOIN	Sales.SalesPerson AS s
ON			e.BusinessEntityID = s.BusinessEntityID

/* QUERY 40: MOSTRAR  LOS EMPLEADOS ORDENADOS ALFABETICAMENTE POR APELLIDO Y POR NOMBRE */
SELECT		*
FROM		HumanResources.Employee AS e
INNER JOIN	Person.Person AS p
ON			e.BusinessEntityID = p.BusinessEntityID
ORDER BY	p.LastName,p.FirstName

/* QUERY 41: MOSTRAR EL CODIGO DE LOGUEO, NUMERO DE TERRITORIO Y SUELDO BASICO DE LOS VENDEDORES */
SELECT		e.LoginID,
			TerritoryID,
			Bonus
FROM		HumanResources.Employee AS e
INNER JOIN	Sales.SalesPerson AS s
ON			e.BusinessEntityID = s.BusinessEntityID

/* QUERY 42:MOSTRAR LOS PRODUCTOS QUE SEAN RUEDAS */
SELECT	*
FROM	Production.Product p
INNER JOIN Production.ProductSubcategory s on p.ProductSubcategoryID = s.ProductSubcategoryID
WHERE	s.Name = 'Wheels'


/* QUERY 43: MOSTRAR LOS NOMBRES DE LOS PRODUCTOS QUE NO SON BICICLETAS */
SELECT	p.Name producto
FROM	Production.Product p
INNER JOIN Production.ProductSubcategory s ON s.ProductSubcategoryID = p.ProductSubcategoryID
WHERE	  s.Name NOT LIKE '%Bikes'



/* QUERY 44:MOSTRAR LOS PRECIOS DE VENTA DE AQUELLOS  PRODUCTOS DONDE EL PRECIO DE VENTA SEA INFERIOR AL PRECIO DE LISTA RECOMENDADO 
PARA ESE PRODUCTO ORDENADOS POR NOMBRE DE PRODUCTO*/

SELECT		DISTINCT p.ProductID, 
			p.Name producto, 
			p.ListPrice [precio de lista], 
			sd.UnitPrice AS 'Precio de Venta recomendado'
FROM		Sales.SalesOrderDetail AS sd
INNER JOIN	Production.Product AS p 
ON			sd.ProductID = p.ProductID AND sd.UnitPrice < p.ListPrice



/* QUERY 45: MOSTRAR TODOS LOS PRODUCTOS QUE TENGAN IGUAL PRECIO. 
SE DEBEN MOSTRAR DE A PARES: CODIGO Y NOMBRE DE CADA UNO DE LOS DOS PRODUCTOS Y EL PRECIO DE AMBOS.ORDENAR POR PRECIO EN FORMA DESCENDENTE */
SELECT		distinct p1.name, p2.name, p1.ListPrice 
FROM		Production.Product p1
INNER JOIN	Production.Product p2
ON			p1.ListPrice = p2.ListPrice
WHERE		p1.ProductID > p2.ProductID
order by	p1.ListPrice desc

/* QUERY 46:MOSTRAR TODOS LOS PRODUCTOS QUE TENGAN IGUAL PRECIO. 
SE DEBEN MOSTRAR DE A PARES: CODIGO Y NOMBRE DE CADA UNO DE LOS DOS PRODUCTOS Y EL PRECIO DE AMBOS 
MAYOES A $15*/
SELECT		distinct p1.name, p2.name, p1.ListPrice 
FROM		Production.Product p1
INNER JOIN	Production.Product p2
ON			p1.ListPrice = p2.ListPrice
WHERE		p1.ProductID > p2.ProductID
AND			p1.ListPrice > $15 
ORDER BY	p1.ListPrice DESC

/* QUERY 47:MOSTRAR EL NOMBRE DE LOS PRODUCTOS Y DE LOS PROVEEDORES CUYA SUBCATEGORIA ES 15 ORDENADOS POR NOMBRE 
DE PROVEEDOR */

SELECT		p.Name producto, 
			v.Name proveedor
FROM		Production.Product p
INNER JOIN	Purchasing.ProductVendor pv
ON			p.ProductID = pv.ProductID
INNER JOIN	Purchasing.Vendor v
ON			pv.BusinessEntityID = v.BusinessEntityID
WHERE		ProductSubcategoryID = 15
ORDER BY	v.Name

/* QUERY 48:MOSTRAR TODAS LAS PERSONAS (NOMBRE Y APELLIDO) Y EN EL CASO QUE SEAN EMPLEADOS MOSTRAR TAMBIEN EL LOGIN ID, SINO MOSTRAR NULL */
SELECT	p.FirstName, p.LastName, e.LoginID
FROM	Person.Person p
LEFT OUTER JOIN HumanResources.Employee e on e.BusinessEntityID = p.BusinessEntityID


/* QUERY 49: MOSTRAR LOS VENDEDORES (NOMBRE Y APELLIDO) Y EL TERRITORIO ASIGNADO A C/U(IDENTIFICADOR Y NOMBRE DE TERRITORIO).
EN LOS CASOS EN QUE UN TERRITORIO NO TIENE VENDEDORES MOSTRAR IGUAL LOS DATOS DEL TERRITORIO UNICAMENTE SIN DATOS DE VENDEDORES*/
SELECT	t.TerritoryID, t.name, pe.firstname, pe.lastname
FROM	Sales.SalesPerson p
RIGHT OUTER JOIN Sales.SalesTerritory t on p.TerritoryID = t.TerritoryID
INNER JOIN Person.Person pe on p.BusinessEntityID = pe.BusinessEntityID
ORDER BY t.TerritoryID

/*
--La consulta anterior no muestra territorios sin vendedores. Osea en la base no existen territorios que no
--tengan vendedores asignados. En la siguiente consulta se muestra esto (solo para profesores)

select * from Sales.SalesTerritory t 
where not exists( select 1 from Sales.SalesPerson p where p.TerritoryID = t.TerritoryID )
*/



/* QUERY 50:MOSTRAR EL PRODUCTO CARTESIANO ENTE LA TABLA DE VENDEDORES CUYO NUMERO DE IDENTIFICACION DE NEGOCIO 
SEA 280 Y EL TERRITORIO DE VENTA SEA EL DE FRANCIA */
SELECT		p.BusinessEntityID codigo, 
			t.Name territorio
FROM		Sales.SalesPerson p
CROSS JOIN	Sales.SalesTerritory t
WHERE		p.BusinessEntityID=280 AND t.Name='france'


---------------------------------------------------------------------------------------------------------
--SUBCONSULTAS
---------------------------------------------------------------------------------------------------------

/* QUERY 51:LISTAR TODOS LAS PRODUCTOS CUYO PRECIO SEA INFERIOR AL PRECIO PROMEDIO DE TODOS LOS PRODUCTOS */ 
SELECT	 *
FROM	 Production.Product
WHERE	 ListPrice<(SELECT	AVG(ListPrice)
					FROM	Production.Product)
ORDER BY ListPrice DESC,name


/* QUERY 52:LISTAR EL NOMBRE, PRECIO DE LISTA, PRECIO PROMEDIO Y DIFERENCIA DE PRECIOS ENTRE CADA PRODUCTO Y EL VALOR 
PROMEDIO GENERAL */
SELECT	Name producto, 
		ListPrice [precio de lista], 
		(SELECT AVG(ListPrice) FROM Production.Product) promedio, 
		ListPrice - (SELECT AVG(ListPrice) FROM Production.Product)[diferencia de precio]
FROM	Production.Product

/* QUERY 53: MOSTRAR EL O LOS CODIGOS DEL PRODUCTO MAS CARO */
SELECT ProductID,ListPrice
FROM Production.Product 
WHERE ListPrice = ( SELECT MAX(ListPrice) MAX_PRICE FROM Production.Product )

/* QUERY 54: MOSTRAR EL PRODUCTO MAS BARATO DE CADA SUBCATEGORÍA. MOSTRAR SUBCATEROGIA, CODIGO DE PRODUCTO 
Y EL PRECIO DE LISTA MAS BARATO ORDENADO POR SUBCATEGORIA */
SELECT		p1.ProductSubcategoryID, p1.ProductID, p1.ListPrice
FROM		Production.Product p1
WHERE		ListPrice = (	SELECT	MIN (ListPrice)
							FROM		Production.Product p2
							WHERE		p2.ProductSubcategoryID = p1.ProductSubcategoryID	)
ORDER BY	p1.ProductSubcategoryID
---------------------------------------------------------------------------------------------------------
--SUBCONSULTAS CON EXISTS
---------------------------------------------------------------------------------------------------------


/* QUERY 55:MOSTRAR LOS NOMBRES DE TODOS LOS PRODUCTOS PRESENTES EN LA SUBCATEGORÍA DE RUEDAS */

SELECT *
FROM Production.Product
WHERE EXISTS (	SELECT * 
				FROM Production.ProductSubcategory
				WHERE ProductSubcategoryID = Production.Product.ProductSubcategoryID AND Name like '%Wheels%')

/* QUERY 56:MOSTRAR TODOS LOS PRODUCTOS QUE NO FUERON VENDIDOS*/
SELECT		p.ProductID,
			p.Name producto
FROM		Production.Product p
WHERE		not exists( select 1 from Sales.SalesOrderDetail sod where p.ProductID = sod.ProductID )


/* QUERY 57: MOSTRAR LA CANTIDAD DE PERSONAS QUE NO SON VENDEDORRES */
SELECT COUNT(*) 
FROM Person.Person p
WHERE not exists( select 1 from Sales.SalesPerson s where p.BusinessEntityID  = s.BusinessEntityID )

/* QUERY 58:MOSTRAR TODOS LOS VENDEDORES (NOMBRE Y APELLIDO) QUE NO TENGAN ASIGNADO UN TERRITORIO DE VENTAS */
SELECT		sp.BusinessEntityID codigo,
			p.LastName apellido,
			p.FirstName nombre
FROM		Sales.SalesPerson AS sp 
INNER JOIN  HumanResources.Employee AS e  ON (e.BusinessEntityID = sp.BusinessEntityID)
INNER JOIN	Person.Person AS p ON (e.BusinessEntityID = p.BusinessEntityID)  
WHERE		not exists( select 1 from Sales.SalesTerritory st where st.TerritoryID = sp.TerritoryID )

---------------------------------------------------------------------------------------------------------
--SUBCONSULTAS CON IN Y NOT IN
---------------------------------------------------------------------------------------------------------

/* QUERY 59: MOSTRAR LAS ORDENES DE VENTA QUE SE HAYAN FACTURADO EN TERRITORIO DE ESTADO UNIDOS UNICAMENTE 'US' */
SELECT		*
FROM		Sales.SalesOrderHeader s
WHERE		s.TerritoryID IN ( SELECT t.TerritoryID FROM Sales.SalesTerritory t WHERE CountryRegionCode = 'US' )

/* QUERY 60: AL EJERCICIO ANTERIOR AGREGAR ORDENES DE FRANCIA E INGLATERRA */
SELECT		*
FROM		Sales.SalesOrderHeader s
WHERE		s.TerritoryID IN ( SELECT t.TerritoryID FROM Sales.SalesTerritory t WHERE CountryRegionCode IN ('US', 'FR', 'GB' ) )

/* QUERY 61:MOSTRAR LOS NOMBRES DE LOS DIEZ PRODUCTOS MAS CAROS */
SELECT	*
FROM	Production.Product
where	ListPrice IN (	SELECT TOP 10	ListPrice
						FROM			Production.Product
						ORDER BY		1 DESC)

/* QUERY 62:MOSTRAR AQUELLOS PRODUCTOS CUYA CANTIDAD DE PEDIDOS DE VENTA SEA IGUAL O SUPERIOR A 20 */
SELECT		Name producto 
FROM		Production.Product 
WHERE		ProductID IN (	SELECT	ProductID 
							FROM	Sales.SalesOrderDetail 
							WHERE	OrderQty >=20 )
ORDER BY	Name


/* QUERY 63: LISTAR EL NOMBRE Y APELLIDO DE LOS EMPLEADOS QUE TIENEN UN SUELDO BASICO DE 5000 PESOS. 
NO UTILIZAR RELACIONES  PARA SU RESOLUCION */
SELECT DISTINCT p.LastName apellido, p.FirstName 
FROM Person.Person p JOIN HumanResources.Employee e
ON e.BusinessEntityID = p.BusinessEntityID
WHERE 5000.00 IN  ( SELECT Bonus FROM Sales.SalesPerson sp WHERE e.BusinessEntityID = sp.BusinessEntityID);


---------------------------------------------------------------------------------------------------------
--SUBCONSULTAS CON ALL Y ANY
---------------------------------------------------------------------------------------------------------

/*QUERY 64:MOSTRAR LOS NOMBRES DE TODOS LOS PRODUCTOS DE RUEDAS QUE FABRICA ADVENTURE WORKS CYCLES */

SELECT Name producto
FROM Production.Product
WHERE ProductSubcategoryID =ANY (	SELECT	ProductSubcategoryID
									FROM	Production.ProductSubcategory
									WHERE	Name = 'Wheels')
    
    
/* QUERY 65:MOSTRAR LOS CLIENTES UBICADOS EN UN TERRITORIO NO CUBIERTO POR NINGÚN VENDEDOR */
SELECT *
FROM Sales.Customer
WHERE TerritoryID <> ALL (SELECT TerritoryID
						  FROM	 Sales.SalesPerson)

--QUERY 66: LISTAR LOS PRODUCTOS CUYOS PRECIOS DE VENTA SEAN MAYORES O IGUALES QUE EL PRECIO DE VENTA MÁXIMO 
--DE CUALQUIER SUBCATEGORÍA DE PRODUCTO.


SELECT Name producto
FROM Production.Product
WHERE ListPrice >= ANY (SELECT		ProductSubcategoryID,MAX (ListPrice)
						FROM		Production.Product
						GROUP BY	ProductSubcategoryID)
 
---------------------------------------------------------------------------------------------------------
--USO DE LA EXPRESION CASE
---------------------------------------------------------------------------------------------------------


/* QUERY 67:LISTAR EL NOMBRE DE LOS PRODUCTOS, EL NOMBRE DE LA SUBCATEGORIA A LA QUE PERTENECE JUNTO A SU CATEGORÍA DE PRECIO.
LA CATEGORÍA DE PRECIO SE CALCULA DE LA SIGUIENTE MANERA: 
	-SI EL PRECIO ESTÁ ENTRE 0 Y 1000 LA CATEGORÍA ES ECONÓMICA.
	-SI LA CATEGORÍA ESTÁ ENTRE 1000 Y 2000, NORMAL 
	-Y SI SU VALOR ES MAYOR A 2000 LA CATEGORÍA ES CARA. */

SELECT		p.Name producto, 
			ListPrice [precio de lista],
			psc.Name subcategoria,
			(CASE  
				WHEN ListPrice BETWEEN 0 AND 1000 THEN 'Economica'
				WHEN ListPrice BETWEEN 1000 AND 2000 THEN 'Normal'
				ELSE 'Cara' 
			END) AS categoria
FROM		Production.Product p
INNER JOIN	Production.ProductSubcategory psc
ON			(p.ProductSubcategoryID=psc.ProductSubcategoryID)



/* QUERY 68:TOMANDO EL EJERCICIO ANTERIOR, MOSTRAR UNICAMENTE AQUELLOS PRODUCTOS CUYA CATEGORIA SEA "ECONOMICA"*/
SELECT  *
FROM	(	SELECT		p.Name producto, 
						ListPrice [precio de lista],
						psc.Name subcategoria,
						(CASE  
							WHEN ListPrice BETWEEN 0 AND 1000 THEN 'Economica'
							WHEN ListPrice BETWEEN 1000 AND 2000 THEN 'Normal'
							ELSE 'Cara' 
						END) AS categoria
			FROM		Production.Product p
			INNER JOIN	Production.ProductSubcategory psc
			ON			(p.ProductSubcategoryID=psc.ProductSubcategoryID)
		) mitabla
WHERE	mitabla.categoria = 'Economica'
ORDER BY 2 DESC



---------------------------------------------------------------------------------------------------------
---- INSERT, UPDATE Y DELETE
---------------------------------------------------------------------------------------------------------
/* QUERY 69:AUMENTAR UN 20% EL PRECIO DE LISTA DE TODOS LOS PRODUCTOS  */
UPDATE	Production.Product
SET		ListPrice = ListPrice * 1.2

					
/* QUERY 70:AUMENTAR UN 20% EL PRECIO DE LISTA DE LOS PRODUCTOS DEL PROVEEDOR 1540 */
UPDATE	p 
SET		ListPrice = ListPrice * 1.2
FROM	Production.Product p
INNER JOIN Purchasing.ProductVendor v ON p.ProductID = v.ProductID 
WHERE	 v.BusinessEntityID = 1540

/* QUERY 71:AGREGAR UN DIA DE VACACIONES A LOS 10 EMPLEADOS CON MAYOR ANTIGUEDAD.*/
UPDATE HumanResources.Employee
SET VacationHours = VacationHours + 24
FROM (SELECT TOP 10 BusinessEntityID FROM HumanResources.Employee
     ORDER BY HireDate ASC) AS th
WHERE HumanResources.Employee.BusinessEntityID = th.BusinessEntityID;

--verificacion
SELECT TOP 10	VacationHours,*
FROM			HumanResources.Employee e
ORDER BY		HireDate 

/* QUERY 72: ELIMINAR LOS DETALLES DE COMPRA (PURCHASEORDERDETAIL) CUYAS FECHAS DE 
VENCIMIENTO PERTENEZCAN AL TERCER TRIMESTRE DEL AÑO 2006 */
DELETE  
FROM Purchasing.PurchaseOrderDetail
WHERE MONTH(DueDate) between 7 and 9 and YEAR(DueDate)=2006; 

/* QUERY 73:QUITAR REGISTROS DE LA TABLA SALESPERSONQUOTAHISTORY CUANDO LAS VENTAS DEL AÑO HASTA LA FECHA 
--ALMACENADAS EN LA TABLA SALESPERSON SUPERE EL VALOR DE 2500000*/

DELETE FROM Sales.SalesPersonQuotaHistory 
FROM		Sales.SalesPersonQuotaHistory AS spqh
INNER JOIN	Sales.SalesPerson AS sp
ON			spqh.BusinessEntityID = sp.BusinessEntityID
WHERE		sp.SalesYTD > 2500000.00;


---------------------------------------------------------------------------------------------------------
---- BULK COPY
--------------------------------------------------------------------------------------------------------

/* QUERY 74: CLONAR ESTRUCTURA Y DATOS DE LOS CAMPOS NOMBRE ,COLOR Y PRECIO DE LISTA 
DE LA TABLA PRODUCTION.PRODUCT EN UNA TABLA LLAMADA PRODUCTOS */

SELECT	Color,Name,ListPrice
INTO	productos
FROM	Production.Product


/* QUERY 75: CLONAR SOLO ESTRUCTURA DE LOS CAMPOS IDENTIFICADOR ,NOMBRE Y 
APELLIDO DE LA TABLA PERSON.PERSON EN UNA TABLA LLAMADA PRODUCTOS */

SELECT	BusinessEntityID,FirstName,LastName
INTO	personas
FROM	Person.Person
WHERE 1=2

drop table dbo.personas
drop table dbo.productos

/* QUERY 76:INSERTAR UN PRODUCTO DENTRO DE LA TABLA PRODUCTOS.TENER EN CUENTA LOS SIGUIENTES 
DATOS: EL COLOR DE PRODUCTO DEBE SER ROJO, EL NOMBRE DEBE SER "BICICLETA MOUNTAIN BIKE" 
Y EL PRECIO DE LISTA DEBE SER DE 4000 PESOS.*/

INSERT INTO		productos(Color,Name,ListPrice)
VALUES			('Rojo','Bicicleta Mountain Bike',4000)


/* QUERY 77: COPIAR LOS REGISTROS DE LA TABLA PERSON.PERSON A LA TABLA PERSONAS CUYO 
IDENTIFICADOR ESTE ENTRE 100 Y 200 */

INSERT INTO	personas
SELECT		BusinessEntityID,FirstName,LastName
FROM		Person.Person
WHERE		BusinessEntityID BETWEEN 100 AND 200


/* QUERY 78: AUMENTAR EN UN 15% EL PRECIO DE LOS PEDALES DE BICICLETA */

 UPDATE productos 
 SET ListPrice=ListPrice*1.15
 WHERE name like'%pedal%'
 
 -- verificacion  
 SELECT	* 
 FROM	productos 
 WHERE	name like'%pedal%'
 
 
 /* QUERY 79: ELIMINAR DE LAS PERSONAS CUYO NOMBRE EMPIECEN CON LA LETRA M*/

DELETE	FROM personas 
WHERE	firstname like 'm%'

--verificacion
select	*
FROM	personas 
WHERE	FirstName like 'm%'


/* QUERY 80: BORRAR TODO EL CONTENIDO DE LA TABLA PRODUCTOS */

DELETE	
FROM	productos

--verificacion
SELECT	*
FROM	productos

/* QUERY 81: BORRAR TODO EL CONTENIDO DE LA TABLA PERSONAS SIN UTILIZAR LA INSTRUCCIÓN DELETE.*/

TRUNCATE TABLE personas


 
---------------------------------------------------------------------------------------------------------
-- PROCEDIMIENTOS ALMACENADOS
---------------------------------------------------------------------------------------------------------


/*QUERY 82: CREAR UN PROCEDIMIENTO ALMACENADO QUE DADA UNA DETERMINADA INICIAL ,DEVUELVA CODIGO, NOMBRE,APELLIDO Y DIRECCION DE
 CORREO DE LOS EMPLEADOS CUYO NOMBRE COINCIDA CON LA INICIAL INGRESADA*/

CREATE PROCEDURE InformarEmpleadosPorInicial(@inicial char(1))
AS
	BEGIN
		SELECT		BusinessEntityID, FirstName, LastName, EmailAddress
		FROM		HumanResources.vEmployee
		WHERE		FirstName LIKE @inicial + '%'
		ORDER BY	FirstName
	END

GO
EXECUTE InformarEmpleadosPorInicial @inicial='j'


/*QUERY 83: CREAR UN PROCEDIMIENTO ALMACENADO QUE DEVUELVA LOS PRODUCTOS QUE LLEVEN DE FABRICADO LA CANTIDAD DE DIAS QUE LE 
PASEMOS COMO PARAMETRO*/

CREATE PROC TiempoDeFabricacion(@dias int = 1)
AS
  SELECT	Name, ProductNumber, DaysToManufacture
  FROM		Production.Product
  WHERE		DaysToManufacture = @dias
  ORDER BY	DaysToManufacture DESC, Name
  
GO
EXECUTE TiempoDeFabricacion @dias=2

/*QUERY 84: CREAR UN PROCEDIMIENTO ALMACENADO QUE PERMITA ACTUALIZAR Y VER LOS PRECIOS DE UN DETERMINADO 
PRODUCTO QUE RECIBA COMO PARAMETRO*/

CREATE PROCEDURE ActualizarPrecios
(@cantidad as float,@codigo as int)
AS
	BEGIN
		UPDATE Production.Product
		SET price = price*@cantidad
		WHERE ProductID=@codigo

		SELECT Name,ListPrice
		FROM Production.Product
		WHERE ProductID=@codigo
	END

GO
EXECUTE ActualizarPrecios 1.1, 886


/*QUERY 85: ARMAR UN PROCEDIMINETO ALMACENADO QUE DEVUELVA LOS PROVEEDORES QUE PROPORCIONAN EL PRODUCTO 
ESPECIFICADO POR PARAMETRO. */

CREATE PROCEDURE Proveedores(@producto varchar(30)='%')
AS
    
    SELECT		v.Name proveedor,
				p.Name producto 
    
    FROM		Purchasing.Vendor AS v 
    INNER JOIN	Purchasing.ProductVendor AS pv
    ON			v.BusinessEntityID = pv.BusinessEntityID 
    INNER JOIN	Production.Product AS p 
    ON			pv.ProductID = p.ProductID 
    WHERE		p.Name LIKE @producto
    ORDER BY	v.Name 
GO    

EXECUTE Proveedores 'r%'
GO
EXECUTE Proveedores 'reflector'


/*QUERY 86: CREAR UN PROCEDIMIENTO ALMACENADO QUE DEVUELVA NOMBRE,APELLIDO Y SECTOR DEL EMPLEADO QUE LE 
PASEMOS COMO ARGUMENTO.NO ES NECESARIO PASAR EL NOMBRE Y APELLIDO EXACTOS AL PROCEDIMIENTO.*/
 
CREATE PROCEDURE empleados
    @apellido nvarchar(50)='%', 
    @nombre nvarchar(50)='%' 
AS 
	SELECT FirstName, LastName,Department
    FROM HumanResources.vEmployeeDepartmentHistory
    WHERE FirstName LIKE @nombre AND LastName LIKE @apellido
GO

EXECUTE empleados  'eric%' 



---------------------------------------------------------------------------------------------------------
--FUNCIONES ESCALARES
---------------------------------------------------------------------------------------------------------


/*QUERY 87:ARMAR UNA FUNCION QUE DEVUELVA LOS PRODUCTOS QUE ESTAN POR ENCIMA DEL PROMEDIO DE PRECIOS GENERAL*/

CREATE FUNCTION promedio()
RETURNS MONEY
AS
BEGIN
		DECLARE @promedio MONEY
		SELECT @promedio=AVG(ListPrice) FROM Production.Product
		RETURN @promedio
END


--uso de la funcion
SELECT	* 
FROM	Production.Product 
WHERE	ListPrice >dbo.promedio()

SELECT AVG(ListPrice) FROM Production.Product --438.6662


/*QUERY 88:ARMAR UNA FUNCIÓN QUE DADO UN CÓDIGO DE PRODUCTO DEVUELVA EL TOTAL DE VENTAS PARA DICHO PRODUCTO.
LUEGO, MEDIANTE UNA CONSULTA, TRAER CODIGO, NOMBRE Y TOTAL DE VENTAS ORDENADOS POR ESTA ULTIMA COLUMNA*/

CREATE FUNCTION VentasProductos(@codigoProducto int) 
RETURNS int
AS
 BEGIN
   DECLARE @total int
   SELECT @total = SUM(OrderQty)
   FROM Sales.SalesOrderDetail WHERE ProductID = @codigoProducto
   IF (@total IS NULL)
      SET @total = 0
   RETURN @total
 END
 
--uso de la funcion
SELECT		ProductID "codigo producto",
			Name nombre,
			dbo.VentasProductos(ProductID) AS "total de ventas"
FROM		Production.Product
ORDER BY	3 DESC



---------------------------------------------------------------------------------------------------------
--FUNCIONES DE TABLA EN LINEA
---------------------------------------------------------------------------------------------------------

/*QUERY 89:ARMAR UNA FUNCIÓN QUE DADO UN AÑO , DEVUELVA NOMBRE Y  APELLIDO DE LOS EMPLEADOS 
QUE INGRESARON ESE AÑO */

CREATE FUNCTION AñoIngresoEmpleados (@año int)
RETURNS TABLE
AS
	RETURN
	(
		SELECT FirstName, LastName,HireDate
		FROM Person.Person p
		INNER JOIN HumanResources.Employee e
		ON e.BusinessEntityID= p.BusinessEntityID
		WHERE year(HireDate)=@año
	)
	
--uso de la funcion
SELECT * FROM dbo.AñoIngresoEmpleados(2004)

/*QUERY 90:ARMAR UNA FUNCIÓN QUE DADO EL CODIGO DE NEGOCIO CLIENTE DE LA FABRICA, DEVUELVA EL CODIGO, NOMBRE Y LAS VENTAS DEL 
AÑO HASTA LA FECHA PARA CADA PRODUCTO VENDIDO EN EL NEGOCIO ORDENADAS POR ESTA ULTIMA COLUMNA. */

CREATE FUNCTION VentasNegocio (@codNegocio int)
RETURNS TABLE
AS
RETURN 
(
    SELECT P.ProductID, P.Name, SUM(SD.LineTotal) AS 'Total'
    FROM Production.Product AS P 
    JOIN Sales.SalesOrderDetail AS SD ON SD.ProductID = P.ProductID
    JOIN Sales.SalesOrderHeader AS SH ON SH.SalesOrderID = SD.SalesOrderID
    JOIN Sales.Customer AS C ON SH.CustomerID = C.CustomerID
    WHERE C.StoreID = @codNegocio
    GROUP BY P.ProductID, P.Name
    
)

--uso de la funcion
SELECT		* 
FROM		dbo.VentasNegocio (1340)
ORDER BY	3 DESC;


---------------------------------------------------------------------------------------------------------
--FUNCIONES DE MULTI SENTENCIA
---------------------------------------------------------------------------------------------------------
	
/*QUERY 91: CREAR UNA  FUNCIÓN LLMADA "OFERTAS" QUE RECIBA UN PARÁMETRO CORRESPONDIENTE A UN PRECIO Y NOS RETORNE UNA 
TABLA CON CÓDIGO,NOMBRE, COLOR Y PRECIO DE TODOS LOS PRODUCTOS CUYO PRECIO SEA INFERIOR AL PARÁMETRO INGRESADO*/


 CREATE FUNCTION ofertas(@minimo decimal(6,2))
 RETURNS @oferta table
 (codigo int,
  nombre varchar(40),
  color varchar(30),
  precio decimal(6,2)
 )
 AS
	 BEGIN
	    INSERT @oferta
		SELECT	ProductID,Name,Color,ListPrice
		FROM	Production.Product
		WHERE	ListPrice<@minimo
	    RETURN
	 END

--uso de la funcion

 SELECT *
 FROM	dbo.ofertas(5000)

--OTROS EJEMPLOS

 Create Function f ()
 returns @t table(codigo int, nombre varchar (20))
  
    begin 
		   insert into @t
		   select 1, 'juan' 
		   
		   insert into @t
		   select 2, 'pedro'
			
		    insert into @t 
            (codigo, nombre)
			values (3, 'martin')			 
		
		return	 
			
 end     

-------------------------------------------------- 

Select * from dbo.f()

--------------------------------------------------

 Create Function f2(@cat int )
 returns @t table(titulo varchar(200), precio money)
  
    begin 
		   insert into @t
		   select name, listprice
		   from Production.Product  
		   where ProductSubcategoryID=@cat
		   
		   insert into @t
		   select 'promedio', avg(precio) from @t
		   		   
		   insert into @t 
           select 'total', sum(precio) from @t
        return		   
			 
					
 end     

----------------------------------------------------

Select * from dbo.f2(14)


---------------------------------------------------------------------------------------------------------
-- DATETIME
---------------------------------------------------------------------------------------------------------

/*QUERY 92: MOSTRAR LA CANTIDAD DE HORAS QUE TRANSCURRIERON DESDE EL COMIENZO DEL AÑO*/

SELECT DATEDIFF(HOUR, '01-01-2012',GETDATE())


/*QUERY 93: MOSTRAR LA CANTIDAD DE DIAS TRANSCURRIDOS ENTRE LA PRIMER Y LA ULTIMA VENTA */

SELECT	DATEDIFF(DAY,(SELECT MIN(OrderDate)FROM Sales.SalesOrderHeader),
					 (SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader))