-- Acciones en la base Comandos
USE Comandos;
GO

-- Quiero crear un esquema
CREATE SCHEMA Esquema2;
GO

/* Muevo tabla al esquema2*/
ALTER SCHEMA Esquema2
TRANSFER dbo.Tabla;
GO