-- Consultas relacionadas 
-- Ejercitacion Base PUBS Parte 3


-- 31.  Seleccionar todos los libros junto a todos los datos de la editorial 
-- la cual lo publicó. 
-- tablas relacionadas: libros(titles) y editoriales(publishers)
-- inner join(coincidencias en los pub_id de ambas tablas)
select		t.*, p.*
from		publishers p
inner join	titles t
on			t.pub_id = p.pub_id;


-- 32.  Mostrar el nombre del libro y el nombre de la editorial la cual lo 
-- publicó sólo de las editoriales que tengan residencia en USA. Mostrar un 
-- apodo para cada columna. 
-- tablas relacionadas: libros(titles) y editoriales(publishers)
-- inner join(coincidencias en los pub_id de ambas tablas)
select		t.title as libro, 
			p.pub_name as editorial
from		publishers p
inner join	titles t
on			t.pub_id = p.pub_id
where		country = 'usa';


-- 33.  Listar los autores que residan en el mismo estado que las tiendas. 
-- Mostrar el nombre y apellido del autor en una columna y el nombre de la 
-- tienda en otra. Apodar ambas columnas. Ordenar por la columna 1.
-- tablas relacionadas: authors y stores
-- inner join --> busco coincidencias en los valores de los campos state de ambas tablas
select		concat(au_fname,' ',au_lname) autor,
			stor_name as tienda
from		stores s
inner join	authors a
on			(a.state = s.state)
order by	1;

-- 34 Mostrar el nombre y apellido del autor y el nombre de los libros publicados por el mismo. 
-- Mostrar un apodo para cada columna. Ordenar por la primera columna de la consulta. 
select		concat(au_fname,' ',au_lname) autor,
			title libro
from		authors a 
inner join titleauthor ta on a.au_id = ta.au_id
inner join	titles t on (t.title_id = ta.title_id)
order by	1;-- orden alfabetico


-- 35.  Mostrar los libros junto a su autor y su editorial. 
-- Se debe mostrar los datos en una unica columna de la siguiente manera con los siguientes 
-- textos literales: 
-- 'El libro XXXXXXXXXXXXX fue escrito por XXXXXXXXXXXXX y publicado por la editorial 
-- XXXXXXXXXXXXX' 
select		concat('El libro ',t.title,' fue escrito por ', a.au_fname, ' ', a.au_lname, ' y publicado por la editorial ',p.pub_name) as info
from		authors a 
inner join titleauthor ta on (a.au_id = ta.au_id)
inner join titles t on (t.title_id = ta.title_id)
inner join publishers p on (p.pub_id = t.pub_id);

-- 36. Mostrar el nombre de las editoriales que no hayan publicado ningún libro. 
-- tablas relacionadas: publishers y titles(se relacionan por el pub_id)
-- outer join --> tabla ppal: publishers
select		p.pub_name as editorial
			-- , t.*
from		publishers p left outer join titles t
on			p.pub_id = t.pub_id
where		t.title_id is null;





