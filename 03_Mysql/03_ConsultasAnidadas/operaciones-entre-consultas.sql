create database operaciones;

use operaciones;

create table A (pais varchar(30));
create table B (pais varchar(30));

insert into A values('Argentina'),('Brasil'),('Uruguay');
insert into B values('Argentina'),('Colombia'),('Venezuela');

select * from A;
select * from B;


-- union
select 	pais from A
union
select 	pais from B;

-- union all
select 	pais from A
union all
select 	pais from B;

-- intersect

-- en SQL Server
/*
select 	pais from A
intersect
select 	pais from B;
*/

SELECT A.pais
FROM A
WHERE A.pais IN (SELECT B.pais FROM B);

-- except

-- en SQL Server
/*
select 	pais from A
except
select 	pais from B;
*/
-- A except B
SELECT 	DISTINCT *
FROM 	A
WHERE NOT EXISTS
		(
			SELECT NULL 
			FROM B
			WHERE A.pais = b.pais
		);

-- B except A
SELECT 	DISTINCT *
FROM 	B
WHERE NOT EXISTS
		(
			SELECT NULL 
			FROM A
			WHERE B.pais = A.pais
		);


-- 40. Listar todas las ciudades mencionadas en la base de datos.
use pubs;

select	city from stores
union
select	city from publishers
union
select	city from authors;

