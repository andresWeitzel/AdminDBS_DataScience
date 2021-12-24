create database PartitionEjer
go

use PartitionEjer
go

create partition function pf_sexo (char(1)) --creamos ppartition function
as range right --right es a la dercha de la letra m incluyendola
for values ('m') --valores de corte
go

ALTER DATABASE PartitionEjer ADD FILEGROUP masculino --crear filegroup
ALTER DATABASE PartitionEjer ADD FILEGROUP femenino

create partition scheme ps_sexo --crear esquema
as partition pf_sexo
to ([masculino], [femenino])--esquemas
go

/*
drop table dbo.personas

drop partition scheme ps_sexo

drop partition function pf_sexo
*/

create table dbo.personas
	(
	ID int identity (1,1) not null,
	Nombre varchar(100),
	Sexo char(1)
	)
ON PS_SEXO (sexo) --la tabla se crea asignando el esquema al objeto sexo
go

EXEC master.sys.xp_create_subdir 'C:\a'

ALTER DATABASE PartitionEjer --creamos un archivo por filegroup
ADD FILE 
( NAME = masculino,
  FILENAME = 'c:\a\masc.ndf',
  SIZE = 1MB,
  MAXSIZE = 100MB,
  FILEGROWTH = 1MB)
TO FILEGROUP masculino
GO

ALTER DATABASE PartitionEjer 
ADD FILE 
( NAME = femenino,
  FILENAME = 'c:\a\fem.ndf',
  SIZE = 1MB,
  MAXSIZE = 100MB,
  FILEGROWTH = 1MB)
TO FILEGROUP femenino
GO

insert into dbo.personas values ('Juan','m')
insert into dbo.personas values ('Juana','f')
insert into dbo.personas values ('Juno','m')
insert into dbo.personas values ('Juna','f')

select * from dbo.personas

SELECT nombre, $Partition.pf_sexo(sexo) PartitionNo --para ver en que particion asigna valores
FROM dbo.personas