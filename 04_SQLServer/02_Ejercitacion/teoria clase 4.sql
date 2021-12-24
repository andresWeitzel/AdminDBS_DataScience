use editoriales
go

-- operaciones entre consultas

SELECT	ciudad
FROM	editoriales

SELECT	ciudad
FROM	autores

-- union evita repeticiones

SELECT	ciudad
FROM	editoriales
UNION
SELECT	ciudad
FROM	autores

-- union all no evita repeticiones

SELECT	ciudad
FROM	editoriales
UNION ALL
SELECT	ciudad
FROM	autores

-- interseccion de conjuntos queda solo berkeley

SELECT	ciudad
FROM	editoriales
INTERSECT
SELECT	ciudad
FROM	autores

-- trae todos las ciudades de las editoriales salvo berkeley la cual es compartida con la tabla de autores

SELECT	ciudad
FROM	editoriales
EXCEPT
SELECT	ciudad
FROM	autores


-- MOSTRAR LOS TITULOS DE LOS LIBROS QUE FUERON ESCRITOS O PUBLICADOS EN CALIFORNIA 

SELECT  titulo,ciudad "ciudad editorial", NULL "ciudad autor"
FROM libros l
INNER JOIN editoriales e ON l.editorial_id=e.editorial_id AND provincia = 'CA'
UNION
SELECT titulo ,NULL "ciudad editorial", ciudad "ciudad autor"
FROM libros l
INNER JOIN libroautor la ON la.libro_id=l.libro_id
INNER JOIN autores a ON a.autor_id=la.autor_id AND provincia = 'CA'

--variante
SELECT  titulo,'escrito en: '+ciudad 
FROM libros l
INNER JOIN editoriales e ON l.editorial_id=e.editorial_id AND provincia = 'CA'
UNION
SELECT titulo , 'publicado en: '+ciudad
FROM libros l
INNER JOIN libroautor la ON la.libro_id=l.libro_id
INNER JOIN autores a ON a.autor_id=la.autor_id AND provincia = 'CA'

-- subqueries

-- subconsulta en el SELECT

use AdventureWorks2008R2
go

SELECT	Name producto, 
		ListPrice [precio de lista], 
		(SELECT AVG(ListPrice) FROM Production.Product) promedio, 
		ListPrice - (SELECT AVG(ListPrice) FROM Production.Product)[diferencia de precio]
FROM	Production.Product

-- subconsulta en el WHERE devuelve escalar

SELECT	 *
FROM	 Production.Product
WHERE	 ListPrice<(SELECT	AVG(ListPrice)
					FROM	Production.Product)
ORDER BY ListPrice DESC,name

-- subconsulta en el WHERE devuelve lista

use editoriales
go

SELECT * FROM autores 
WHERE provincia IN (SELECT provincia FROM editoriales)

--uso de otros predicados (usar tablas facturas y productos)


-- case estatico

	
SELECT	nombre +' '+apellido nombre_autor,
telefono,
contrato,
		(CASE  provincia
			WHEN 'CA'THEN 'California'
			WHEN 'KS'THEN 'Kansas'
			ELSE 'otro estado' 
		END) AS estado
FROM autores

-- case dinamico

SELECT		Name producto, 
			ListPrice [precio de lista],
			Name subcategoria,
			(CASE  
				WHEN ListPrice BETWEEN 0 AND 1000 THEN 'Economica'
				WHEN ListPrice BETWEEN 1000 AND 2000 THEN 'Normal'
				ELSE 'Cara' 
			END) AS categoria
FROM		Production.Product 

--test de existencia con exists

SELECT *
FROM libros
WHERE   EXISTS(SELECT *
FROM editoriales 
WHERE provincia='CA')

SELECT *
FROM libros
WHERE  NOT EXISTS(SELECT *
FROM editoriales 
WHERE provincia='CA')

-- clausula TOP

SELECT TOP 5 *
FROM libros

SELECT TOP 50 PERCENT *
FROM libros

--clausulas OFFSET Y FETCH (solo sql server 2012)

-- Saltea los primeros 5 registros pero el resto de los registros(rows) los devuelve.

SELECT DepartmentID, Name,GroupName
FROM HumanResources.Department
ORDER BY DepartmentID OFFSET 5 ROWS;

-- No saltea ninguno de los primeros registros pero solo muestra 10
registros.
SELECT DepartmentID, Name,GroupName
FROM HumanResources.Department
ORDER BY DepartmentID
OFFSET 0 ROWS
FETCH NEXT 10 ROWS ONLY;
