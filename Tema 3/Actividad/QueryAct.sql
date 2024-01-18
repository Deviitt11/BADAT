-- Primero nos conectamos a la base de datos master
USE master;
GO 

/* En caso de que exista ya, borramos la base de datos
Apellidos_Nombre_Actividad (si no existe, no se hace nada) */
DROP DATABASE IF EXISTS ColladosBlanco_David_Actividad;
GO

CREATE DATABASE ColladosBlanco_David_Actividad; -- Creamos la base de datos
GO

-- Nos conectamos a la base de datos
USE ColladosBlanco_David_Actividad;
GO

-- Creamos el Esquema2 en la base
CREATE SCHEMA Esquema2;
GO

-- Creamos la tabla 'B' con un campo llamado 'DatoB' de tipo int
CREATE TABLE B(
	DatoB INT
)
GO

-- Se añade el dato
INSERT INTO B VALUES(1);
GO

-- Se comprueba que los datos han sido insertados
SELECT *
FROM B;

-- Modificamos el Esquema1 para transferirle la TablaB
ALTER SCHEMA Esquema1
TRANSFER dbo.B;
GO

-- Nos conectamos a la base de datos
USE ColladosBlanco_David_Actividad;
GO

/* Creamos la 'TablaC' con un campo llamado 'DatoC' de tipo int 
directamente en el Esquema2 */
CREATE TABLE Esquema2.C (
	DatoC INT
)
GO






