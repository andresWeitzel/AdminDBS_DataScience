/*Los bloqueos de tablas pueden ser una herramienta importante para ENGINE=MyISAM , pero rara vez son 
útiles para ENGINE=InnoDB . Si está tentado a utilizar bloqueos de tabla con InnoDB, debe reconsiderar 
cómo está trabajando con las transacciones.

MySQL permite que las sesiones de los clientes adquieran bloqueos de tablas explícitamente con el fin de 
cooperar con otras sesiones para acceder a las tablas, o para evitar que otras sesiones modifiquen las 
tablas durante los períodos en que una sesión requiere acceso exclusivo a ellas. Una sesión puede adquirir 
o liberar bloqueos solo para sí misma. Una sesión no puede adquirir bloqueos para otra sesión o liberar 
bloqueos mantenidos por otra sesión.

Comando: LOCK TABLES table_name READ|WRITE;

puede asignar solo el tipo de bloqueo a una sola tabla;

Ejemplo (READ LOCK):

LOCK TABLES table_name READ;

Ejemplo (BLOQUEO DE ESCRITURA):

LOCK TABLES table_name WRITE;
Para ver si el bloqueo está aplicado o no, use el siguiente comando
*/

SHOW OPEN TABLES;

-- Para limpiar / eliminar todos los bloqueos, use el siguiente comando:

UNLOCK TABLES;

-- EJEMPLO:

use pubs;

LOCK TABLES sales READ, titles WRITE;
SELECT SUM(price) FROM titles;
UPDATE titles SET title = 'Marshmallow' WHERE title_id = 13;
UNLOCK TABLES;

SELECT * FROM pubs.titles;

-- otro ejemplo:

LOCK TABLES titles WRITE;  
INSERT INTO titles(title_id,title) values(80,'Nuggets');
UNLOCK TABLES;

describe titles;

-- En el ejemplo anterior, cualquier conexión externa no puede escribir datos en la tabla de productos 
-- hasta que se desbloquee el producto de la tabla

-- EJEMPLO:

LOCK TABLES titles READ;
INSERT INTO titles(title_id,title) values(81,'Icecreams');
UNLOCK TABLES;

SELECT * FROM pubs.titles;

-- En el ejemplo anterior, cualquier conexión externa no puede leer ningún dato de la tabla de productos 
-- hasta que se desbloquee el producto de la tabla.