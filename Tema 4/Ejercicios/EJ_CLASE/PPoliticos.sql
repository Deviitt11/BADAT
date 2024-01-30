USE master
GO

DROP DATABASE IF EXISTS PartidosPolíticos;
GO

CREATE DATABASE PartidosPolíticos
GO

Use PartidosPolíticos;

-- tablas
DROP TABLE IF EXISTS PresidentePartido, Presidente, País, PartidoPolítico;

CREATE TABLE País(
	PaísID INT IDENTITY(1,1)
);

ALTER TABLE País
ADD CONSTRAINT PK_País PRIMARY KEY(PaísID);

ALTER TABLE País
ADD PaísNombre NVARCHAR(50) NOT NULL;

ALTER TABLE País
ADD CONSTRAINT AK_País_PaísNombre UNIQUE(PaísNombre)
GO

ALTER TABLE País
ADD Continente NVARCHAR(50) NOT NULL;

ALTER TABLE País
ADD NumHabitantes INT NOT NULL;

ALTER TABLE País
ADD CONSTRAINT DF_País_NumHabitantes
DEFAULT 1 FOR NumHabitantes;

ALTER TABLE País
ADD Capital NVARCHAR(50) NOT NULL;

CREATE TABLE Presidente(
	PresidenteID INT IDENTITY(1,1)
);

ALTER TABLE Presidente
ADD CONSTRAINT PK_Presidente
PRIMARY KEY(PresidenteID);

ALTER TABLE Presidente
ADD PresidenteNombre NVARCHAR(50) NOT NULL;

ALTER TABLE Presidente
ADD PaísID INT NOT NULL;

ALTER TABLE Presidente
ADD CONSTRAINT FK_Presidente_País_PaísID
FOREIGN KEY (PaísID) REFERENCES 
País(PaísID)
ON DELETE CASCADE ON UPDATE CASCADE;
GO

ALTER TABLE Presidente
ADD Edad INT NULL;

ALTER TABLE Presidente
ADD CONSTRAINT DF_Presidente_Edad
DEFAULT 18 FOR Edad;
GO

ALTER TABLE Presidente
ADD CONSTRAINT CK_Presidente_Edad
CHECK(Edad IS NULL OR Edad >= 18);

CREATE TABLE PartidoPolítico(
	PartidoPolíticoID INT IDENTITY(1,1)
);

ALTER TABLE PartidoPolítico
ADD CONSTRAINT PK_PartidoPolítico
PRIMARY KEY(PartidoPolíticoID);

ALTER TABLE PartidoPolítico
ADD PartidoPolíticoNombre NVARCHAR(50) NOT NULL;

ALTER TABLE PartidoPolítico
ADD AñoFundación INT NOT NULL;

-- siglo XX y defecto 1901
ALTER TABLE PartidoPolítico
ADD CONSTRAINT DF_PartidoPolítico_AñoFundación
DEFAULT 1901 FOR AñoFundación;

ALTER TABLE PartidoPolítico
ADD CONSTRAINT CK_PartidoPolítico_AñoFundación
CHECK(AñoFundación BETWEEN 1901 AND 2000);

CREATE TABLE PresidentePartido(
	PresidentePartidoID INT IDENTITY(1,1)
);

ALTER TABLE PresidentePartido
ADD CONSTRAINT PK_PresidentePartido
PRIMARY KEY(PresidentePartidoID);

ALTER TABLE PresidentePartido
ADD PresidenteID INT;

ALTER TABLE PresidentePartido
ADD CONSTRAINT FK_PresidentePartido_Presidente_PresidenteID
FOREIGN KEY(PresidenteID)
REFERENCES Presidente(PresidenteID)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE PresidentePartido
ADD PartidoPolíticoID INT;

ALTER TABLE PresidentePartido
ADD CONSTRAINT FK_PresidentePartido_PartidoPolítico_PartidoPolíticoID
FOREIGN KEY(PartidoPolíticoID)
REFERENCES PartidoPolítico(PartidoPolíticoID)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE PresidentePartido
ADD AñoEntrada INT NOT NULL;

ALTER TABLE PresidentePartido
ADD CONSTRAINT CK_PresidentePartido_AñoEntrada
CHECK(AñoEntrada>=1901);

ALTER TABLE PresidentePartido
ADD AñoSalida INT;

ALTER TABLE PresidentePartido
ADD CONSTRAINT CK_PresidentePartido_AñoSalida
CHECK(AñoSalida IS NULL OR AñoSalida >= AñoEntrada);

ALTER TABLE PresidentePartido
ADD AñosGobierno INT;

ALTER TABLE PresidentePartido
ADD CONSTRAINT DF_PresidentePartido_AñosGobierno
DEFAULT 0 FOR AñosGobierno;







