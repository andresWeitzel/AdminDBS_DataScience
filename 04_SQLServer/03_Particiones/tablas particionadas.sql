-- Create partition function
USE AdventureWorks
GO

CREATE PARTITION FUNCTION pf_OrderDate (datetime)
AS RANGE RIGHT
FOR VALUES ('01/01/2004', '01/01/2005')

-- Add filegroups and create partition scheme
ALTER DATABASE AdventureWorks ADD FILEGROUP fg1
ALTER DATABASE AdventureWorks ADD FILEGROUP fg2
ALTER DATABASE AdventureWorks ADD FILEGROUP fg3
ALTER DATABASE AdventureWorks ADD FILEGROUP fg4
GO

ALTER DATABASE AdventureWorks 
ADD FILE 
( NAME = data1,
  FILENAME = 'c:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\AWd1.ndf',
  SIZE = 1MB,
  MAXSIZE = 100MB,
  FILEGROWTH = 1MB)
TO FILEGROUP fg1
GO

ALTER DATABASE AdventureWorks 
ADD FILE 
( NAME = data2,
  FILENAME = 'c:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\AWd2.ndf',
  SIZE = 1MB,
  MAXSIZE = 100MB,
  FILEGROWTH = 1MB)
TO FILEGROUP fg2
GO

ALTER DATABASE AdventureWorks 
ADD FILE 
( NAME = data3,
  FILENAME = 'c:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\AWd3.ndf',
  SIZE = 1MB,
  MAXSIZE = 100MB,
  FILEGROWTH = 1MB)
TO FILEGROUP fg3
GO

ALTER DATABASE AdventureWorks 
ADD FILE 
( NAME = data4,
  FILENAME = 'c:\Program Files\Microsoft SQL Server\MSSQL.1\MSSQL\Data\AWd4.ndf',
  SIZE = 1MB,
  MAXSIZE = 100MB,
  FILEGROWTH = 1MB)
TO FILEGROUP fg4
GO

CREATE PARTITION SCHEME ps_OrderDate
AS PARTITION pf_OrderDate 
TO (fg1, fg2, fg3, fg4)
GO

-- Create partitioned table
CREATE TABLE dbo.PartitionedTransactions
(
	TransactionID int IDENTITY(1,1) NOT NULL,
	ProductID int NOT NULL,
	TransactionDate datetime NOT NULL DEFAULT (getdate()),
	TransactionType nchar(1) NOT NULL
)
ON ps_OrderDate(TransactionDate)
GO

-- Insert data
INSERT INTO dbo.PartitionedTransactions
SELECT	ProductID, TransactionDate, TransactionType
FROM Production.TransactionHistory
GO

INSERT INTO dbo.PartitionedTransactions
VALUES
(1, '01/01/2005', 'S')
GO

-- View partition metadata
SELECT * FROM sys.Partitions
WHERE [object_id] = OBJECT_ID('dbo.PartitionedTransactions')

-- View data with partition number
SELECT TransactionID, TransactionDate, $Partition.pf_OrderDate(TransactionDate) PartitionNo
FROM dbo.PartitionedTransactions

-- Verify lowest value in each partition
SELECT MIN(TransactionDate) FirstTran, $Partition.pf_OrderDate(TransactionDate) PartitionNo
FROM dbo.PartitionedTransactions
GROUP BY $Partition.pf_OrderDate(TransactionDate)
ORDER BY PartitionNo

-- Reset database
DROP TABLE dbo.PartitionedTransactions
DROP PARTITION SCHEME ps_OrderDate
DROP PARTITION FUNCTION pf_OrderDate
ALTER DATABASE AdventureWorks REMOVE FILE data1
ALTER DATABASE AdventureWorks REMOVE FILE data2
ALTER DATABASE AdventureWorks REMOVE FILE data3
ALTER DATABASE AdventureWorks REMOVE FILE data4
ALTER DATABASE AdventureWorks REMOVE FILEGROUP fg1
ALTER DATABASE AdventureWorks REMOVE FILEGROUP fg2
ALTER DATABASE AdventureWorks REMOVE FILEGROUP fg3
ALTER DATABASE AdventureWorks REMOVE FILEGROUP fg4