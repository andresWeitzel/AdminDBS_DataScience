-- Usuarios del sistema
/*
	El servidor de base de datos permite que más de un usuario pueda trabajar con los recursos del 
    servidor (registros, tablas, bases de datos, funciones, etc..).

	Si nosotros somos los únicos administradores del servidor (algo que muy pocas veces sucede) no 
    deberíamos tener problemas en seguir utilizando root, sin embargo, si más personas trabajan con 
    el servidor, será necesario que generemos nuevos usuarios y asignemos los permisos pertinentes.
*/

-- lista de usuarios
SELECT * FROM mysql.user;

-- Creando nuevos usuarios
 CREATE USER 'jorge'@'localhost' IDENTIFIED BY '123';
 
 -- verifico la creacion del nuevo usuario
 SELECT * FROM mysql.user;
 
 /*
 
 Estamos añadiendo una nueva fila a la tabla 'user' de la base de datos 'mysql', con nombre de usuario 
 'jorge' y password '123'.
 
 Si no ponemos la palabra clave 'IDENTIFIED BY' estaríamos creando un usuario sin contraseña, lo cual 
 no es recomendado.

 •	Si no indicamos el host, Mysql asignará el patrón '%' al mismo.
 Por ejemplo:
CREATE USER 'anonimo';

•	Nota: Es importante tener en cuenta el formato del usuario de la forma: 'usuario'@'host', ya que si 
ponemos esto: 'usuario@host' estaríamos creando un usuario de nombre 'usuario@host' que puede conectarse 
desde cualquier PC.

*/

-- •	Podemos 'obligar' a que un usuario cambie su contraseña cuando se conecta por primera vez
-- Poniendo la expresion 'PASSWORD EXPIRE':(mysql server)
CREATE USER 'jorge'@'localhost' IDENTIFIED BY '123' PASSWORD EXPIRE;


-- •	También podemos 'obligar' al usuario a que cambie de password cada cierto número de días:
CREATE USER 'jorge'@'localhost' IDENTIFIED BY '123' PASSWORD EXPIRE INTERVAL 60 DAY;

-- Ademas podemos modificar la fecha de expiracion de un usuario mediante el comando ALTER
ALTER USER 'jorge'@'localhost'  IDENTIFIED BY '123' PASSWORD EXPIRE INTERVAL 60 DAY;

-- En el ejemplo, deberá cambiar de password cada 60 días.

-- •	El resto de opciones indicarían:

-- •	NEVER: que el password nunca 'caduca'.
CREATE USER 'jorge'@'localhost' IDENTIFIED BY '123' PASSWORD EXPIRE NEVER;

-- •	DEFAULT: El password caducaría en el número de días indicado por la variable del sistema 
-- default_password_lifetime que es de 360 días en versiones anteriores a la 5.7.11 y 0 (no caduca) a 
-- partir de la versión anterior.
CREATE USER 'jorge'@'localhost' IDENTIFIED BY '123' PASSWORD EXPIRE DEFAULT;

-- ver el usuario actual
SELECT USER();

FLUSH PRIVILEGES;

-- ver privilegios de un usuario(mysql server)
SHOW CREATE USER 'jorge'@'localhost';

 -- version de mySQL
 SELECT @@version;-- las variables de sistema empiezan con @@
 
 -- ver todas las variables
 SHOW VARIABLES;
 

 -- Comando GRANT
-- Comando que permite conceder privilegios a un usuario

-- • ALL PRIVILEGES: se conceden todos los privilegios a este usuario. Los posibles
-- privilegios: SELECT, INSERT, UPDATE, DELETE, CREATE, DROP,REFERENCES,
-- INDEX, ALTER, CREATE_TMP_TABLE, LOCK_TABLES,
-- CREATE_VIEW,SHOW_VIEW, CREATE_ROUTINE, ALTER_ROUTINE, EXECUTE
-- y GRANT.

-- • ON: los objetos a los que se aplican los privilegios, el formato es
-- base_de_datos.tabla, *.* Otros ejemplos: ventas.*, contabilidad.polizas,

-- • TO: el usuario al que se le conceden los privilegios, el formato es
-- usuario@'equipo'. Otros ejemplos: user1@'%', sergio@'192.168.10.132'

-- • IDENTIFIED BY: la contraseña se indica en esta parte y se escribe en texto
-- plano.

-- • WITH GRANT OPTION: esta última parte es opcional, e indica que el usuario en
-- cuestión puede a la vez otorgar privilegios a otros usuarios

-- • REQUIRE: Opciones de seguridad en el acceso relacionadas con SSL
-- (Capa de conexión segura): Cifra una conexión a una instancia de base de datos.


-- Otorgar todos los permisos al usuario jorge
GRANT ALL PRIVILEGES ON *.* TO 'jorge'@'localhost' IDENTIFIED BY '123' WITH GRANT OPTION;

-- Siempre que se realice un cambio relacionado con el usuario o el privilegio, debemos enviar un 
-- FLUSH PRIVILEGES para instruir a MySQL que debe recargar la memoria caché de la información de la cuenta. 
-- Se mantiene para que las actualizaciones puedan tener efecto. De lo contrario, los cambios pueden pasar 
-- desapercibido hasta que se reinicie MySQL:
 
 FLUSH PRIVILEGES;

-- veo los permisos otorgados al usuario jorge
SHOW GRANTS FOR 'jorge'@'localhost';

-- Los asteriscos indican que los permisos serán asignados a todas las bases de datos y a todas las tablas 
-- (primer asteriscos bases de datos, segundo asterisco tablas).

-- Si queremos asignar permisos para ciertas acciones, la sentencia quedaría de la siguiente manera. 
-- Reemplazamos ALL PRIVILEGES y colocamos las acciones que queremos asignar.

GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON pubs.* TO 'jorge'@'localhost';

FLUSH PRIVILEGES;
	
-- En esta ocasión estamos indicando que el nuevo usuario podrá consultar, crear, actualizar y eliminar 
-- registros, así cómo podrá crear o eliminar elementos (tablas, índices, columnas, funciones, stores, etc).

-- Todos estos permisos serán válidos únicamente en la base de datos pubs y se aplicarán a todas las tablas.

-- Si queremos asignar permisos únicamente a una tabla, reemplazamos el asteriscos por el nombre de la tabla.
-- Por ejemplo: pubs.titles


-- Comando REVOKE
-- La revocación se hará al mismo nivel de privilegios otorgados con el comando GRANT
-- Los privilegios pueden ser revocados con una sentencia REVOKE, cuya sintaxis es idéntica a la de GRANT:
 
 REVOKE SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON pubs.*  FROM 'jorge'@'localhost';
 
 -- agregar permiso para hacer select en base negocio en forma grafica y luego revocar por codigo dicho permiso
 -- revoke select on negocio.* FROM 'jorge'@'localhost';
 
 FLUSH PRIVILEGES;
 
 -- Si quiero revocar todos los privilegios:
 
 REVOKE ALL PRIVILEGES ON *.* FROM 'jorge'@'localhost';
 
 FLUSH PRIVILEGES;

-- veo los privilegios del usuario jorge
SHOW GRANTS FOR 'jorge'@'localhost';



-- PERMISOS
-- Aquí un listado de algunos permisos que podemos asignar.

-- CREATE permite crear nuevas tablas o bases de datos.
-- DROP permite eliminar tablas o bases de datos.
-- DELETE permite eliminar registros de tablas.
-- INSERT permite insertar registros en tablas.
-- SELECT permite leer registros en las tablas.
-- UPDATE permite actualizar registros en las tablas.
-- GRANT OPTION permite remover permisos de usuarios.

-- Privilegios Nivel de Base de Datos

-- GRANT ALL ON db_name.* y REVOKE ALL ON db_name.* otorgan y quitan sólo permisos de bases de datos.

GRANT all privileges on pubs.* to 'jorge'@'localhost' identified by '123' with grant option;
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'jorge'@'localhost';

REVOKE all privileges on pubs.* FROM 'jorge'@'localhost' identified by '123';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'jorge'@'localhost';



-- Privilegios Nivel de Tabla

-- GRANT ALL ON db_name. tbl_name y REVOKE ALL ON db_name. tbl_name otorgan y quitan permisos sólo de tabla.

GRANT all privileges on pubs.titles to 'jorge'@'localhost' identified by '123' with grant option;
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'jorge'@'localhost';

REVOKE all privileges on pubs.titles FROM 'jorge'@'localhost' identified by '123';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'jorge'@'localhost';


-- Privilegios Nivel de Columna

GRANT SELECT(title,price) on pubs.titles to 'jorge'@'localhost' identified by '*D96E731673EA31A4CFEE43FD938E3DA944506737' with grant option;
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'jorge'@'localhost';


REVOKE SELECT(title,price) on pubs.titles FROM 'jorge'@'localhost' identified by '123';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'jorge'@'localhost';


-- Eliminar un usuario
DROP USER 'jorge'@'localhost';

select * from mysql.user;


-- Cambiar contraseña de usuario
SHOW GRANTS FOR CURRENT_USER();


-- Sólo los usuarios tales como root con acceso de modificación para la base de datos mysql
-- puede cambiar la contraseña de otro usuario.
SET PASSWORD FOR 'jorge'@'localhost' = PASSWORD('user11');


-- Puede usar el comando GRANT USAGE globalmente (ON *.*) para asignar una contraseña
-- a una cuenta sin afectar los permisos actuales de la cuenta.
GRANT USAGE ON *.* TO 'jorge'@'localhost' IDENTIFIED BY 'user12';


-- Aunque generalmente es preferible asignar contraseñas usando uno de los métodos
-- precedentes, se puede hacer modificando la tabla mysql. user directamente
UPDATE 	mysql.user 
SET 	Password = PASSWORD('user13') 
WHERE 	Host = 'localhost' AND User = 'jorge'; 

FLUSH PRIVILEGES;



