-- 21.Contar la cantidad de autores que su estado de residencia sea California (CA).
--  Poner un apodo al nombre de columna.
select	count(au_id) 'cantidad de autores' 
from 	authors
where	state = 'ca';-- 15 de los 23 autores son de california

select * from authors;

/*
	22. Mostrar la fecha de inicio de facturación y el último 
    número de comprobante emitido. Poner un apodo a cada columna. 
*/
select		min(ord_date) 'inicio de facturación',
			max(ord_num) 'ultimo comprobante'
from		sales;

-- 23.Contar la cantidad de países que residen alguna editorial. 
select 	count(country) from publishers;-- 8

select 	 count(distinct country) from publishers;-- 3(usa, germany, france)

select * from publishers;

-- 24. Listar las categorías de libros y el valor promedio para cada 
-- tipo de libro. 
select 		type categoria,
			round(avg(price), 2) promedio
from		titles
group by	type;

-- 25. ldem ejercicio 24 pero no incluir dentro de la lista los libros 
-- que no tienen decidida una categoría. 
select 		type categoria,
			round(avg(price), 2) promedio
from		titles
where		type is not null
group by	type
order by	2 desc;

-- 25. ldem ejercicio 24 pero no incluir dentro de la lista los libros 
-- que no tienen decidido un precio. 
select 		type categoria,
			round(avg(price), 2) promedio
from		titles
where		price is not null
group by	type
order by	2 desc;

select * from titles;

-- 26.  Listar los locales que hayan vendido más de 100 libros. 
select		stor_id,
			sum(qty) 'ventas por tienda'
from 		sales 
group by	stor_id
having		sum(qty) > 100;

-- 27.Listar la cantidad de ejemplares vendidos de cada libro en cada tienda. 
-- Poner apodos a las columnas. 
select		stor_id libreria,
			title_id titulo,
            sum(qty) ventas
from		sales
group by	stor_id, title_id;

-- 28. Listar el valor promedio de los libros agrupados por tipo de libro 
-- cuyo promedio esté entre 12 y 14. Poner alias a los encabezados. Ordenar 
-- la consulta por promedio. 
select 		type Tipo,
			round(avg(price),2) 'Valor Promedio'
from 		titles  
group by 	type
having 		round(avg(price),2) between 12 and 14
order by 	2 desc;

-- 29.Listar las categorías de libros junto con el precio del libro más caro, 
-- el más barato y la cantidad de libros existentes para esa categoría. Mostrar 
-- solo aquellas categorías de libros cuyo precio de los libros económicos sea 
-- inferior a $10 Y cuya cantidad de libros pertenecientes sean mayor a 2. 
select		type as categoria,
			max(price) 'titulo mas caro',
            min(price) 'titulo mas barato',
            count(title_id) cantidad
from		titles
group by	type
having		min(price) < 10 and count(title_id) > 2
-- order by	categoria desc;
-- order by	type desc;
order by	1 desc;

-- 30.  Contar la cantidad de empleados que trabajen en la compañía.
select count(emp_id) as 'cantidad de empleados' from employee;






-- 10. Listar las ciudades y estados de residencia de los autores. 
-- Evitar las repeticiones.
select	distinct(city) ciudad, state as estado from authors;

select	distinct(state) estado, city ciudad from authors;


            





            








			




