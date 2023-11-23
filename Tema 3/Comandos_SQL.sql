-- Me conecto a la base master 
USE master; -- acaba en ;
GO -- ejecuta lo anterior
 
/*Borro la base de datos Comandos en caso de que exista*/
DROP DATABASE IF EXISTS Comandos;
GO -- ejecuta...

-- Creo la base de datos --
CREATE DATABASE Comandos;
GO

-- Me conecto a Comandos
USE Comandos;

-- Tiro la tabla en caso de que exista
DROP TABLE IF EXISTS Tabla;

-- Hago una tabla: con un campo
CREATE TABLE Tabla(
	-- campos
	Dato INT -- nombre y tipo
);
GO