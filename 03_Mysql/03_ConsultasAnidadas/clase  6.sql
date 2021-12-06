-- Mostrar el nombre de las editoriales que no hayan publicado ningún libro.
-- tabla ppal:  publishers , tabla secundaria: titles
select 	p.pub_name
		-- ,t.*
-- from 	publishers p left join titles t
from 	titles t right outer join publishers p 
on 		p.pub_id = t.pub_id
where 	t.title_id is null;-- clave ppal de tabla secundaria q sea NULL

-- listar los libros que no fueron vendidos
-- tabla ppal: titles, tabla secundaria: sales
select 	t.title as libro
		-- ,s.*
from 	titles t left join sales s 
on 		t.title_id = s.title_id
where 	s.ord_num is null;

-- Consultas Anidadas
-- listar todos los datos del ultimo empleado q ingreso
select * from employee;

select 	* 
from 	employee
where	hire_date = (select max(hire_date) from employee);
-- where	hire_date = '1998-06-01';

-- listar todos los datos del libro mas caro
select *
from titles
where price = (select max(price) from titles);-- 22.95

select 	* 
		, max(price) as 'titulo mas caro' -- columna agregada
from 	titles;

-- uso de tabla virtual dual
select now() as fecha from dual;
select curdate() as fecha from dual;

-- uso de predicados
create database predicados;

use predicados;

create table productos(numero int, precio int);
create table facturas(numero int, monto int);

insert into productos values (1,100),(2,200),(3,300),(4,1000);
insert into facturas values (1,300),(2,500),(3,600),(4,200);

select * from productos;
select * from facturas;

-- listar todos los productos cuyo precio supere todos los 
-- montos facturados
select	*
from	productos
where	precio > all 	(	select 	monto
							from	facturas
						);
                        
-- listar todos los productos cuyo precio supere algun
-- monto facturado
select	*
from	productos
where	precio > any 	(	select 	monto
							from	facturas
						);
                        
-- listar los productos cuyo precio coincida con montos facturados.
select	*
from	productos
-- where	precio = any (select monto from	facturas);
where	precio in (select monto from facturas);

-- listar los productos cuyo precio NO coincida con montos facturados.
select	*
from	productos
-- where	precio <> all (select monto from	facturas);
where	precio not in (select monto from facturas);

-- Ejercitacion sobre base pubs
/*
Listar el nombre de los libros junto a su categoría de precio. 
La categoría de precio se calcula de la siguiente manera: Si el 
precio está entre 0 y 10 la categoría es Económica. Si la categoría 
está entre 10 Y 20, Normal y si su valor es mayor a 20 la categoría 
es Caro. Colocar un apodo a las dos columnas.
*/
select	title as libro,
		price precio,
		case
			when price < 10 then 'Economica'
            when price between 10 and 20 then 'Normal'
            when price > 20 then 'Cara'
		end as categoria
from 	titles;

-- Mostrar el nombre de los libros junto a su categoría de precio de 
-- aquellos libros que son categorizados como "Normal". La categoría 
-- de los precios es la misma del ejercicio anterior
SELECT	*
FROM	(
			select	title as libro,
					price precio,
					case
						when price < 10 then 'Economica'
						when price between 10 and 20 then 'Normal'
						when price > 20 then 'Cara'
					end as categoria
			from 	titles
		) as miTabla
WHERE	miTabla.categoria = 'Normal';

-- Listar la cantidad de libros vendidos por cada tienda, sólo de aquellas tiendas que su 
-- cantidad de venta sea mayor al promedio de venta general
select		st.stor_name libreria,
			sum(s.qty) 'ventas x libreria'
from		stores st
inner join	sales s on (st.stor_id = s.stor_id)
group by	st.stor_name
having		sum(s.qty) > (select sum(s.qty) / count(distinct s.stor_id) from sales s)
order by	2 desc;
        










