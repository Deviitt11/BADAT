USE master
GO

DROP DATABASE IF EXISTS PartidosPol�ticos;
GO

CREATE DATABASE PartidosPol�ticos
GO

Use PartidosPol�ticos;

-- tablas
DROP TABLE IF EXISTS PresidentePartido, Presidente, Pa�s, PartidoPol�tico;

CREATE TABLE Pa�s(
	Pa�sID INT IDENTITY(1,1)
);

ALTER TABLE Pa�s
ADD CONSTRAINT PK_Pa�s PRIMARY KEY(Pa�sID);

ALTER TABLE Pa�s
ADD Pa�sNombre NVARCHAR(50) NOT NULL;

ALTER TABLE Pa�s
ADD CONSTRAINT AK_Pa�s_Pa�sNombre UNIQUE(Pa�sNombre)
GO

ALTER TABLE Pa�s
ADD Continente NVARCHAR(50) NOT NULL;

ALTER TABLE Pa�s
ADD NumHabitantes INT NOT NULL;

ALTER TABLE Pa�s
ADD CONSTRAINT DF_Pa�s_NumHabitantes
DEFAULT 1 FOR NumHabitantes;

ALTER TABLE Pa�s
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
ADD Pa�sID INT NOT NULL;

ALTER TABLE Presidente
ADD CONSTRAINT FK_Presidente_Pa�s_Pa�sID
FOREIGN KEY (Pa�sID) REFERENCES 
Pa�s(Pa�sID)
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

CREATE TABLE PartidoPol�tico(
	PartidoPol�ticoID INT IDENTITY(1,1)
);

ALTER TABLE PartidoPol�tico
ADD CONSTRAINT PK_PartidoPol�tico
PRIMARY KEY(PartidoPol�ticoID);

ALTER TABLE PartidoPol�tico
ADD PartidoPol�ticoNombre NVARCHAR(50) NOT NULL;

ALTER TABLE PartidoPol�tico
ADD A�oFundaci�n INT NOT NULL;

-- siglo XX y defecto 1901
ALTER TABLE PartidoPol�tico
ADD CONSTRAINT DF_PartidoPol�tico_A�oFundaci�n
DEFAULT 1901 FOR A�oFundaci�n;

ALTER TABLE PartidoPol�tico
ADD CONSTRAINT CK_PartidoPol�tico_A�oFundaci�n
CHECK(A�oFundaci�n BETWEEN 1901 AND 2000);

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
ADD PartidoPol�ticoID INT;

ALTER TABLE PresidentePartido
ADD CONSTRAINT FK_PresidentePartido_PartidoPol�tico_PartidoPol�ticoID
FOREIGN KEY(PartidoPol�ticoID)
REFERENCES PartidoPol�tico(PartidoPol�ticoID)
ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE PresidentePartido
ADD A�oEntrada INT NOT NULL;

ALTER TABLE PresidentePartido
ADD CONSTRAINT CK_PresidentePartido_A�oEntrada
CHECK(A�oEntrada>=1901);

ALTER TABLE PresidentePartido
ADD A�oSalida INT;

ALTER TABLE PresidentePartido
ADD CONSTRAINT CK_PresidentePartido_A�oSalida
CHECK(A�oSalida IS NULL OR A�oSalida >= A�oEntrada);

ALTER TABLE PresidentePartido
ADD A�osGobierno INT;

ALTER TABLE PresidentePartido
ADD CONSTRAINT DF_PresidentePartido_A�osGobierno
DEFAULT 0 FOR A�osGobierno;







