-- group by

		
SELECT		max(ListPrice) AS "producto mas caro", 
			min(ListPrice) AS "producto mas barato",
			round(avg(ListPrice),2)promedio,
			count(ProductID)cantidad,
			sum(ListPrice)total
FROM		Production.Product


SELECT		productid "codigo de producto",
			sum(OrderQty) AS "total de productos vendidos" 
FROM		Sales.SalesOrderDetail 
GROUP BY	productid
		
		
SELECT		Color,
			max(ListPrice) AS "producto mas caro", 
			min(ListPrice) AS "producto mas barato",
			avg(ListPrice)promedio,
			count(ProductID)cantidad,
			sum(ListPrice)total
FROM		Production.Product
GROUP BY	color


--having

SELECT		Color,
			max(ListPrice) AS "producto mas caro", 
			min(ListPrice) AS "producto mas barato",
			avg(ListPrice)promedio,
			count(ProductID)cantidad,
			sum(ListPrice)total
FROM		Production.Product
WHERE		color not like 'b%'
GROUP BY	color
HAVING		avg(ListPrice)>100
ORDER BY	1


-- joins
create database relaciones

use relaciones

create table sucursales(suc_id int,suc_nombre varchar(40))
create table empleados(emp_id int,emp_nombre varchar(40),suc_id int)

insert into sucursales values(1,'Centro'),(2,'Congreso'),(3,'Palermo')
insert into empleados values(1,'Juan',1),(2,'Jose',2),(3,'Carlos',2),(4,'Maria',null)

select * from sucursales
select * from empleados
go



SELECT s.suc_nombre "nombre sucursal",e.emp_nombre "nombre empleado"
FROM sucursales s
INNER JOIN empleados e
ON s.suc_id=e.suc_id

SELECT s.suc_nombre "nombre sucursal",e.emp_nombre "nombre empleado"
FROM sucursales s
LEFT JOIN empleados e
ON s.suc_id=e.suc_id

SELECT s.suc_nombre "nombre sucursal",e.emp_nombre "nombre empleado"
FROM sucursales s
RIGHT JOIN empleados e
ON s.suc_id=e.suc_id
where s.suc_id is null

SELECT s.suc_nombre "nombre sucursal",e.emp_nombre "nombre empleado"
FROM sucursales s
FULL JOIN empleados e
ON s.suc_id=e.suc_id



select COUNT (emp_id),ISNULL(suc_nombre, 'sin sucursal asignada')
from empleados S
LEFT join sucursales E
on (S.suc_id=E.suc_id)
group by suc_nombre
order by suc_nombre

-- producto cartesiano nada que ver con joins

SELECT A.valor,B.valor
FROM A
CROSS JOIN B

--self join

--determinar cuantas bicicletas tienen el mismo precio y mostrar el detalle de dichas bicicletas
use [AdventureWorks2008R2]
SELECT		distinct p.Name nombre,
			p.Listprice precio,
			count(p.ProductID)cantidad
FROM		Production.Product p,Production.Product p1
where		p.Listprice=p1.Listprice and p.ProductNumber like 'bk%'
group by	p.name,p.Listprice
order by	p.Listprice desc



