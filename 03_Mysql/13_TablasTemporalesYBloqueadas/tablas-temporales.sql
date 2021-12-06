/*
TABLAS TEMPORALES

Son aquellas que solo existen mientras una sesión se mantiene viva en tu servidor de 
bases de datos, perdiéndose una vez cerrada la misma.

¿POR QUÉ USAR UNA TABLA TEMPORAL?

Cuando la cantidad de resultados que obtengas una query sea demasiado pesada para 
ejecutarla una y otra vez y se vuelve mas conveniente tenerlas almacenadas en una 
tabla temporal que como ya se dijo mas arriba estará mientras la sesión no se cierre;
pudiendo consultar los resultados de esta tabla temporal que ya los tiene almacenados 
y que por ende existen en memoria.

PARA CREAR UNA TABLA TEMPORAL

Se usa la sintaxis de

CREATE TEMPORARY TABLE tableName

Las tablas temporales no deben tener el mismo nombre entre ellas.
Las tablas temporales solo será visibles para el usuario que las creó.
Una tabla temporal puede tener el mismo nombre que una permanente, pero es importante 
mencionar que si esto pasa, entonces automáticamente las consultas irán a la tabla 
temporal y no a la permanente.

Es necesario que para crear estas tablas tengas (en MySQL al menos) el permiso de 
CREATE TEMPORARY TABLES
*/


use pubs;

-- clona la tabla original sin registros
CREATE TEMPORARY TABLE tmp_employee SELECT * FROM employee LIMIT 0;

-- clona la tabla original con todos los registros
CREATE TEMPORARY TABLE tmp_employee2 
SELECT * FROM employee;

select * from tmp_employee;
select * from tmp_employee2;

