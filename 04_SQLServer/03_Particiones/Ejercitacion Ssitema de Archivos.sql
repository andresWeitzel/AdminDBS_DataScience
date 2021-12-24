CREATE DATABASE ARCHIVOS_CARLOS

-- 1- Crear un tipo de dato que contenga la capacidad de contener al CUIT.
USE ARCHIVOS_CARLOS

CREATE TYPE CUIT
FROM char(11) null

/*
2- Crear una tabla  llamada “clientes” con los siguientes atributos: id, nombre, CUIT con
       sus respectivos tipos de datos. El identificador debe ser auto-numico empezando 
	desde cero e incrementando de a dos neros.
*/
CREATE TABLE CLIENTES
(
ID int PRIMARY KEY NOT NULL IDENTITY (0,2),
nombre varchar(40) NOT NULL,
Cuit CUIT NOT NULL
)

-- 3- Insertar dos clientes a la tabla generada en el punto 2.
insert into clientes
values ('Omar',23251485296)
insert into clientes
values ('Aurora',25248264752)

/*
4- Crear una tabla llamada “nuevos_clientes” que posea los siguientes atributos: 
id, nombre, CUIT. El identificador debe guardar neros secuenciales.
*/
CREATE TABLE NUEVOS_CLIENTES
(
ID int PRIMARY KEY NOT NULL IDENTITY (1,1),
nombre varchar(40) NOT NULL,
Cuit CUIT NOT NULL
)

/*
5- Insertar los registros de la tabla del punto 2 dentro de la tabla generada en el punto 4.
*/
INSERT INTO NUEVOS_CLIENTES
SELECT NOMBRE,CUIT
FROM CLIENTES

/* 6- Eliminar las tablas anteriormente generadas. */
DROP TABLE CLIENTES
DROP TABLE NUEVOS_CLIENTES

/*
Crear una base de datos llamada “Datos” que contenga dos archivos de datos: Dato_a  tipo MDF 
con un tamaño inicial de 2048kb y un crecimiento de  1024kb.
El registro de transacción debe iniciar con un tamaño de 1024kb e incrementar  en  1024kb .

Todos estos deben estar ubicados en la carpeta donde residen los archivos de datos. 
Los archivos deben pertenecer al grupo de archivo primario. 

*/

/* creacion de carpetas */
EXEC master.sys.xp_create_subdir 'c:\data\'

CREATE DATABASE DATOS_COB
ON PRIMARY
	(
	NAME = N'DATOS_COB_A',
	FILENAME = N'C:\DATA\DATOS_COB_A.MDF',
	SIZE = 3 MB,
	FILEGROWTH = 10%
	
	),
	(
	NAME = N'DATOS_COB_B',
	FILENAME = N'C:\DATA\DATOS_COB_B.NDF',
	SIZE = 2 MB,
	FILEGROWTH = 10%
	)
LOG ON
	(
	NAME = N'DATOS_COB_Log',
	FILENAME = N'C:\DATA\DATOS_COB_Log.LDF',
	SIZE = 1 MB,
	FILEGROWTH = 10%
	)


/* 8
Crear una base de datos llamada “BaseL2” que contenga dos archivos de datos: BaseL2_a  	
tipo MDF con un tamaño inicial de 4096kb y un crecimiento de  1024kb.
BaseL2_b tipo NDF con un tamaño inicial de 2048kb y un crecimiento de 1024kb .
El registro de transacción debe iniciar con un tamaño de 1024kb e incrementar  en  1024kb. 
Todos estos deben estar ubicados en la carpeta donde residen los archivos de datos. 
El primer archivo debe pertenecer al grupo de archivo primario autogenerado por SQL Server y 
el segundo a un grupo de archivo llamado SECONDARY.
*/
CREATE DATABASE BaseL2
ON PRIMARY
	(
	NAME = N'BaseL2_A',
	FILENAME = N'C:\DATA\BaseL2_A.MDF',
	SIZE = 4 MB,
	FILEGROWTH = 25%
	
	),
FILEGROUP [SECONDARY]
	(
	NAME = N'BaseL2_B',
	FILENAME = N'C:\DATA\BaseL2_B.NDF',
	SIZE = 2 MB,
	FILEGROWTH = 50%
	)
LOG ON
	(
	NAME = N'BaseL2_Log',
	FILENAME = N'C:\DATA\BaseL2_Log.LDF',
	SIZE = 1 MB,
	FILEGROWTH = 100%
	)


/* 9
Normalizar
*/

/*10
Normalizar
*/

/*11
Crear una  función de partición llamada PF_Sexo para cada sexo ‘M’ y ‘F’.
*/
CREATE DATABASE SEXOS

USE SEXOS 


CREATE PARTITION FUNCTION PF_SEXO (CHAR(1))
AS RANGE RIGHT
FOR VALUES ('M')


/*12
Crear un esquema de partición para que los datos de sexo ‘M’ los guarde dentro del grupo de archivo PRIMARY 
y ‘F’ dentro de SECONDARY.
*/
-- Add filegroups and create partition scheme
ALTER DATABASE sEXOS ADD FILEGROUP PRIMARIO
ALTER DATABASE Sexos ADD FILEGROUP SECUNDARIO

GO

CREATE PARTITION SCHEME ps_sexo
AS PARTITION pf_sexo 
TO (PRIMARIO,SECUNDARIO)
GO

/*
DROP TABLE DBO.PERSONAS

DROP PARTITION SCHEME PS_SEXO

DROP PARTITION FUNCTION PF_SEXO
*/

/*13
Crear una tabla llamada “personas” con los siguientes atributos: nombre y sexo bajo el esquema 
de partición generado en el punto anterior.
*/
CREATE TABLE dbo.Personas
(
	ID_Persona int IDENTITY(1,1) NOT NULL,
	Nombre Varchar(50) NOT NULL,
	Sexo char(1) NOT NULL
)
ON ps_sexo(Sexo)
GO

ALTER DATABASE sEXOS 
ADD FILE 
( NAME = 'MASCULINO',
  FILENAME = 'C:\A\M.NDF',
  SIZE = 1MB,
  MAXSIZE = 100MB,
  FILEGROWTH = 1MB)
TO FILEGROUP PRIMARIO
GO

ALTER DATABASE sEXOS 
ADD FILE 
( NAME = 'FEMENINO',
  FILENAME = 'C:\A\F.NDF',
  SIZE = 1MB,
  MAXSIZE = 100MB,
  FILEGROWTH = 1MB)
TO FILEGROUP SECUNDARIO
GO

/*14
Insertar 4 personas, dos de cada sexo. Verificar que los registros se hayan almacenado 
en las particiones correspondientes.
*/

insert into dbo.personas values ('Juan','m')
insert into dbo.personas values ('Juana','f')
insert into dbo.personas values ('Juno','m')

SELECT * FROM DBO.PERSONAS

SELECT NOMBRE, $PARTITION.PF_SEXO(SEXO) PARTICION
FROM DBO.PERSONAS


-- View partition metadata
SELECT * FROM sys.Partitions
WHERE [object_id] = OBJECT_ID('dbo.Personas')

-- View data with partition number
SELECT ID_persona, Nombre, Sexo, $Partition.pf_sexo(Sexo) PartitionNo
FROM dbo.Personas

-- Verify lowest value in each partition
SELECT MIN(Sexo) FirstTran, $Partition.pf_Sexo(Sexo) PartitionNo
FROM dbo.Personas
GROUP BY $Partition.pf_sexo(sexo)
ORDER BY PartitionNo
