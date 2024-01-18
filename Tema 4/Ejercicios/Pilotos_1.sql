USE Formula_1
GO

DROP TABLE IF EXISTS PilotoEscuder�a;
DROP TABLE IF EXISTS Escuder�a;
GO

CREATE TABLE Escuder�a (
	-- primero campos
	Escuder�aID INT,
	Escuder�aNombre NVARCHAR(50) NOT NULL,
	MarcaMotor NVARCHAR(50) NOT NULL,
	CampeonatosEscuder�a INT
	CONSTRAINT DF_Escuder�a_CampeonatosEscuder�a
	DEFAULT 0,
	A�oFundaci�n INT NOT NULL,
	-- restricciones
	CONSTRAINT PK_Escuder�a_Escuder�aID
	PRIMARY KEY(Escuder�aID),
	-- restricciones
	CONSTRAINT CK_Escuder�a_CampeonatosEscuder�a
	CHECK(CampeonatosEscuder�a>=0),
	-- a�o de fundaci�n por encima de 1950
	CONSTRAINT CK_Escuder�a_A�oFundaci�n
	CHECK(A�oFundaci�n>=1950),
);
GO

CREATE TABLE PilotoEscuder�a (
	PilotoID INT,
	Escuder�aID INT,
	T�tulosGanados INT
	CONSTRAINT DF_PilotoEscuder�a_T�tulosGanados
	DEFAULT 0,
	A�oEntrada INT NOT NULL,
	A�oSalida INT
	-- restricciones
	CONSTRAINT PK_PilotoEscuder�a_PilotoID_Escuder�aID
	PRIMARY KEY(PilotoID, Escuder�aID),
	CONSTRAINT FK_PilotoEscuder�a_Piloto_PilotoID
	-- mi PilotoID viene de la tabla Piloto, el campo Piloto
	FOREIGN KEY(PilotoID) REFERENCES Piloto(PilotoID)
	ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT FK_PilotoEscuder�a_Escuder�a_Escuder�aID
	FOREIGN KEY(Escuder�aID) REFERENCES Escuder�a(Escuder�aID)
	ON DELETE CASCADE ON UPDATE CASCADE
);
GO

