
create database planEjecucion;

use planEjecucion;

create table a (
	x int,
	y int
);
 


delimiter //
create procedure cargardatos ()
begin

   declare cont int;

   set cont = 1;

   while cont <= 500 do
		insert into a values (rand()*100,rand()*100);
		set cont = cont + 1;
   end while;

end; //
delimiter ;


call cargardatos();

select * from a;

select * from a where x= 100;-- 0.578 seg.

explain select * from a where x= 100;

create index a_unique_index on a (x);

select * from a where x= 100;-- 0.015 seg.


explain select * from a where x= 100;

-- id: muestra el número secuencial que identificará cada una de las tablas que se procesan 
-- en la consulta realizada.

-- select_type: muestra el tipo de SELECT que se ha ejecutado. En función del tipo de SELECT 
-- nos permitirá identificar qué tipo de consulta se trata. Existen varios tipos distintos: 
-- SIMPLE, PRIMARY, UNION, DERIVED…

-- table: muestra el nombre de la tabla a la que se refiere la información de la fila. También,
 -- puede ser alguno de los siguientes valores:

-- : tabla resultante de la unión de las tablas cuyos campos id son M y N.

-- : tabla resultante de una tabla derivada cuyo id es N. Una tabla derivada puede ser, por 
-- ejemplo, una subconsulta en la cláusula FROM.

-- type: muestra el tipo de unión que se ha empleado.

-- possible_keys: muestra qué índices puede escoger MySQL para buscar las filas de la tabla. 
-- Si esta columna es NULL, significa que no hay índices que puedan ser usados para mejorar 
-- la consulta. En este caso, podría ser interesante examinar las columnas empleadas en el 
-- WHERE para analizar si hay alguna columna que pueda emplearse para construir un índice.

-- key: muestra el índice que MySQL ha decido usar para ejecutar la consulta. 

-- key_len: muestra el tamaño del índice que MySQL ha decidido usar para ejecutar la consulta.

-- ref: muestra qué columnas o constantes son comparadas con el índice especificado en la 
-- columna key.

-- rows: muestra el número de filas que MySQL cree que deben ser examinadas para ejecutar la 
-- consulta. Este número es un número aproximado.

-- filtered: muestra el porcentaje estimado de filas que serán filtradas por la condición de la 
-- consulta. Esta columna sólo se muestra cuando se emplea EXPLAIN EXTENDED.

-- Extra: muestra información adicional sobre cómo MySQL ejecuta la consulta.

