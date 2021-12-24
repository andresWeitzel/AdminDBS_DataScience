-- Variables

/* declaracion, inicializacion e impresion */
declare @nombre as nvarchar(20)
set @nombre = 'Juan'
--select @nombre /*muestra como resultado de query*/
print @nombre/*muestra como mensaje*/

/* condicional if */
declare @nombre as nvarchar(20)
set @nombre = 'Juan'
if (@nombre = 'Juan')
	begin
		print 'Es Juan'
	end
else
	begin
		print 'no es juan'
	end 
 
 /* bucle while */
declare @valor as int
set @valor = 1
while(@valor<=10) 
	begin
		print @valor
		set @valor=@valor+1
	 end
 
/* variable que almacena query */
use editoriales
go

declare @maximo as int
declare @minimo as int

select @maximo = max(precio),/* por ser mezcla entre query y variable debe ir select NO set*/
       @minimo = min (precio)
from libros

select @maximo
select @minimo

/* variables y funciones del sistema */
select @@servername /*variables del sistema*/

select @@max_connections

select getdate()/*funciones del sistema*/


/*
Ejecución de sentencias SQL:
•	Dinámicos
•	Batch
•	Transacción
•	Scripts
*/

--Dinámicos: son generadas durante la ejecución de un script. 
--por ejemplo se puede generar un store procedure con variables para construir una sentencia SELECT que incorpore esas variables

DECLARE @tabla varchar(20), @bd varchar(20)
SET @tabla = 'autores'
SET @bd = 'editoriales'
EXECUTE ('USE '+ @bd + ' SELECT * FROM ' + @tabla )

--Ejemplo:

DECLARE @tabla varchar(20), @bd varchar(20),@campo varchar(20),@funcion varchar (20)
set @funcion='avg(precio)'
set @campo='categoria'
SET @tabla = 'ventas'
SET @bd = 'editoriales'

if(@tabla = 'libros')
	begin
		EXECUTE ('USE '+ @bd + ' SELECT '+ @campo + @funcion +'promedio '  +' FROM ' + @tabla+' GROUP BY '+@campo )
	end
	
else
	begin
		set @funcion='sum(cantidad)'
		set @campo='tienda_id'
		SET @tabla = 'ventas'
		EXECUTE ('USE '+ @bd + ' SELECT '+ @campo+' tienda, '+@funcion +'ventas '  +' FROM ' + @tabla+' GROUP BY '+@campo )
	end



--Batch: ejecución de varias sentencias juntas.
--mejoran el performance de SQL Server debido a que compila y ejecuta todo junto


SELECT MAX(precio) AS 'Máximo precio'
FROM libros
PRINT ''
SELECT MIN(precio) AS 'Menor precio' 
FROM libros
PRINT ''
SELECT AVG(precio) AS 'Precio promedio'
FROM libros
GO

--Transacciones: se ejecutan como un bloque
--si alguna sentencia falla, no se ejecuta nada del bloque

BEGIN TRANSACTION
			update clientes
			set categoria=categoria+1
			where nombre='carlos'
COMMIT TRANSACTION --rollback transacction deshace la operacion


--Clausulas try catch:permite manejar de modo seguro transacciones

BEGIN TRY
			PRINT 'Continuo OK';
END TRY
BEGIN CATCH
			RAISERROR('mensaje de error',16,1)
			--Eleva un error a la aplicación o batch que lo llamo 
			--RAISERROR ( { msg_id | msg_str } { , severidad , estado }  ] 
			--msg_id: Número de error en la tabla sysmessages
			PRINT 'fallo el proceso'
END CATCH


--try catch con transacciones

create database dml
go
use dml


create table clientes(
						codigo int identity(1,1),
						nombre varchar(40) not null,
						dni int not null unique,
						sexo char(1) not null default 'F',
						categoria int not null check (categoria between 1 and 10) 
  
						);
						

select * from clientes

insert into clientes (nombre,dni,sexo,categoria)
values	('carlos',25765981,'M',6)

insert into clientes (nombre,dni,sexo,categoria)
values	('jose',24578965,'M',3)

insert into clientes (nombre,dni,categoria)
values	('maria',19653827,8)

insert into clientes (nombre,dni,categoria)
values	('mariana',20123456,5)


BEGIN TRY
		BEGIN TRAN
			update clientes
			set categoria=categoria+1
			where nombre='carlos'
		COMMIT TRAN
END TRY
BEGIN CATCH
		ROLLBACK TRAN
		PRINT 'fallo el proceso'
END CATCH

--Funciones
--funciones escalares

-- devolver todos los libros cuyo precio sea mayor al promedio

use editoriales
go

SELECT *
FROM libros
WHERE precio>(SELECT avg(precio) FROM libros)

CREATE FUNCTION promedio()
returns money
as
BEGIN
		declare @promedio money
		select @promedio=avg(precio) from libros
		return @promedio
END

select * from libros where precio >dbo.promedio()

drop function promedio

--funcion escalar con pasaje por parametros

CREATE FUNCTION promedio_2(@categoria varchar(30))
returns money
as
BEGIN

		declare @promedio money
		select @promedio=avg(precio) from libros where categoria=@categoria
		return @promedio
END

select * from libros where precio > dbo.promedio_2(type)

drop function promedio_2


-- funciones de tabla en linea

CREATE FUNCTION autoresLibros(@cat varchar(30))
returns table
as
	return (SELECT		a.autor_id,
						a.nombre,
						a.apellido,
						a.provincia,
						l.libro_id,
						l.categoria,
						l.precio,
						l.editorial_id

			FROM		autores a
			INNER JOIN	libroautor la
			ON			a.autor_id=la.autor_id
			INNER JOIN	libros l
			ON			la.libro_id=l.libro_id)


SELECT * FROM autoresLibros('business')

drop function autoresLibros

--variables de tipo tabla

declare @t table(codigo int,nombre varchar(200))

insert into @t
select 1,'juan'

insert into @t
select 2,'pepe'

select * from @t


--funciones de multisentencia

CREATE FUNCTION fnMultisentencia()
returns @t table(codigo int,nombre varchar(200))
as
BEGIN

		insert into @t
		select 1,'juan'

		insert into @t
		select 2,'pepe'

		insert into @t
		select 3,'martin'

		return
END

select * from dbo.fnMultisentencia()

drop function fnMultisentencia

--otro ejemplo: totaliza y promedia el precio de una determinada categoria

 CREATE FUNCTION fnMultisentencia2(@cat varchar (30))
 returns @t table(titulo varchar(200), precio money)
  
    BEGIN 
		   insert into @t
		   select titulo, precio
		   from libros 
		   where categoria = @cat
		   
		   insert into @t
		   select 'Promedio', avg(precio) from @t
		   		   
		   insert into @t 
           select 'Total', sum(precio) from @t
           return		   
    END 

select * from dbo.fnMultisentencia2('business')

drop function fnMultisentencia2


--Procedimientos Almacenados

CREATE PROCEDURE listarLibros
as
BEGIN
	select *
	from libros
END

exec listarLibros

drop procedure listarLibros

--otro
use AdventureWorks2008R2
go

--El siguiente ejemplo muestra como se puede crear un procedimiento que devuelve un
--conjunto de registros de todos los productos que llevan más de un día de fabricación.
CREATE PROC Production.LongLeadProducts
AS
  SELECT Name, ProductNumber, DaysToManufacture
  FROM Production.Product
  WHERE DaysToManufacture >= 1
  ORDER BY DaysToManufacture DESC, Name
GO


--procedimiento con parametros

--El siguiente código agrega un parametro @MinimumLength al procedimiento
--LongLeadProducts Esto permite que la cáusula WHERE sea más flexible, permitiendo a la
--aplicación llamante, definir el tiempo mínimo de fabricación apropiado.

ALTER PROC Production.LongLeadProducts
@MinimumLength int = 1 -- valor por defecto
AS
  IF (@MinimumLength < 0) -- validación
    BEGIN
         RAISERROR('Invalid lead time.', 14, 1)
         RETURN
    END

  SELECT Name, ProductNumber, DaysToManufacture
  FROM Production.Product
  WHERE DaysToManufacture >= @MinimumLength
  ORDER BY DaysToManufacture DESC, Name


/*Metadatos*/

/*para ver el diccionario de datos de la base*/
select *
from sys.tables

/*muestra todos los procedimientos generados en la BD*/
select *
from sys.procedures

/*muestra las bases*/
select *
from sys.databases

/*muestra todos los mensajes de la base*/
select *
from sys.messages

/*muestra todos los objetos de la base*/
select *
from sys.objects