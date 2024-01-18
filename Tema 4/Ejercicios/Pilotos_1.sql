USE Formula_1
GO

DROP TABLE IF EXISTS PilotoEscudería;
DROP TABLE IF EXISTS Escudería;
GO

CREATE TABLE Escudería (
	-- primero campos
	EscuderíaID INT,
	EscuderíaNombre NVARCHAR(50) NOT NULL,
	MarcaMotor NVARCHAR(50) NOT NULL,
	CampeonatosEscudería INT
	CONSTRAINT DF_Escudería_CampeonatosEscudería
	DEFAULT 0,
	AñoFundación INT NOT NULL,
	-- restricciones
	CONSTRAINT PK_Escudería_EscuderíaID
	PRIMARY KEY(EscuderíaID),
	-- restricciones
	CONSTRAINT CK_Escudería_CampeonatosEscudería
	CHECK(CampeonatosEscudería>=0),
	-- año de fundación por encima de 1950
	CONSTRAINT CK_Escudería_AñoFundación
	CHECK(AñoFundación>=1950),
);
GO

CREATE TABLE PilotoEscudería (
	PilotoID INT,
	EscuderíaID INT,
	TítulosGanados INT
	CONSTRAINT DF_PilotoEscudería_TítulosGanados
	DEFAULT 0,
	AñoEntrada INT NOT NULL,
	AñoSalida INT
	-- restricciones
	CONSTRAINT PK_PilotoEscudería_PilotoID_EscuderíaID
	PRIMARY KEY(PilotoID, EscuderíaID),
	CONSTRAINT FK_PilotoEscudería_Piloto_PilotoID
	-- mi PilotoID viene de la tabla Piloto, el campo Piloto
	FOREIGN KEY(PilotoID) REFERENCES Piloto(PilotoID)
	ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT FK_PilotoEscudería_Escudería_EscuderíaID
	FOREIGN KEY(EscuderíaID) REFERENCES Escudería(EscuderíaID)
	ON DELETE CASCADE ON UPDATE CASCADE
);
GO

