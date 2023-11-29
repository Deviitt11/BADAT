-- me conecto a master
USE master;
GO

--tiro abajo Prueba C si existe
DROP DATABASE IF EXISTS PruebaC;
GO

-- creo la base de datos
CREATE DATABASE PruebaC;
GO

-- me conecto a mi nueva base
USE PruebaC;
GO

DROP DATABASE IF EXISTS Table_1;
-- creo una tabla en dbo
CREATE TABLE [dbo].[Table_1](
	Dato INT
);

-- inserto algún valor
INSERT INTO dbo.Table_1 VALUES(1);
INSERT INTO dbo.Table_1 VALUES(NULL);
GO

-- miro que todo va bien
SELECT *
from dbo.Table_1;

-- creo un usuario asociado al login1
CREATE USER user1
FOR LOGIN login1;
GO

USE PruebaC;
GO

ALTER ROLE db_owner
ADD MEMBER user1;
GO