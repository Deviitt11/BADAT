-- Conexión a master
USE master;
GO

-- Tiro la base si existe
DROP DATABASE IF EXISTS Libreria;
GO

-- Creo la base de datos
CREATE DATABASE Libreria;
GO

-- me conecto a ella
USE Libreria;
GO

-- tiro las tablas
DROP TABLE IF EXISTS Autor, Libro, Editorial;
GO

-- Tabla autor
CREATE TABLE Autor(
	-- defino los campos
	-- AutorID empieza en 1, incrementa en 1
	AutorID INT IDENTITY (1,1),
	AutorNombre NVARCHAR(50) NOT NULL,
	AutorApellido NVARCHAR(50),
	AñoDeNacimiento INT, 
	Nación NVARCHAR(50) NOT NULL,

	-- restricciones
	-- CONSTRAINT nombre restricción
	CONSTRAINT PK_Autor PRIMARY KEY(AutorID),
	CONSTRAINT CK_AñoDeNacimiento CHECK(AñoDeNacimiento<=YEAR(GETDATE()))
);

CREATE TABLE Libro(
	-- defino los campos
	LibroID INT IDENTITY(1,1),
	AutorID INT NOT NULL,
	Título NVARCHAR(50) NOT NULL,
	NúmeroPáginas INT NOT NULL,
	AñoPublicación INT,
	Precio MONEY NOT NULL,

	-- restricciones
	CONSTRAINT PK_Libro PRIMARY KEY(LibroID),
	CONSTRAINT FK_Libro_Autor_AutorID
		FOREIGN KEY (AutorID) REFERENCES Autor(AutorID),
	CONSTRAINT CK_NúmeroPáginas
		CHECK(NúmeroPáginas > 0),
	CONSTRAINT CK_Precio
		CHECK(Precio > 0),
	CONSTRAINT CK_AñoPublicación
		CHECK(AñoPublicación<=YEAR(GETDATE()))
);

CREATE TABLE Editorial (
	-- defino campos
	EditorialID INT IDENTITY (1,1),
	EditorialNombre NVARCHAR(50) NOT NULL,
	Nación NVARCHAR(50) NOT NULL,
	AñoDeFundación INT

	-- restricciones
	CONSTRAINT PK_Editorial PRIMARY KEY (EditorialID),
	CONSTRAINT CK_Editorial_AñoDeFundacion
		CHECK(AñoDeFundación <= YEAR(GETDATE()))
);

CREATE TABLE LibroEditorial(
	LibroID INT,
	EditorialID INT,
	CONSTRAINT PK_LibroEditorial
		PRIMARY KEY(LibroID, EditorialID),
	CONSTRAINT FK_LibroEditorial_Libro_LibroID
		FOREIGN KEY(LibroID) REFERENCES Libro(LibroID),
	CONSTRAINT FK_LibroEditorial_Editorial_EditorialID
		FOREIGN KEY(EditorialID) REFERENCES Editorial(EditorialID)
);

