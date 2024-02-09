USE Hogwarts;
GO

DROP TABLE IF EXISTS 
	Alumno.Casa,
	CasaEstudiante,
	CasaPrefecto,
	Profesor.Asigna,
	Administraci�n.EstudianteProfesor,
	Profesor, Puntuaci�n;

CREATE TABLE Profesor(
	ProfesorID INT,
	ProfesorNombre VARCHAR(50) NOT NULL,
	Especialidad VARCHAR(50) NOT NULL,

	-- restricciones
	CONSTRAINT PK_Profesor
	PRIMARY KEY (ProfesorID),

	-- id siempre +
	CONSTRAINT CK_Profesor_ProfesorID
	CHECK(ProfesorID > 0),

	-- nombre empieza por mayus y tiene espacio
	CONSTRAINT CK_Profesor_ProfesorNombre
	CHECK(LEFT(ProfesorNombre,1) =
	UPPER(LEFT(ProfesorNombre,1))
	AND ProfesorNombre LIKE '% %')
	-- '[A-Z]%[a-z] [A-Z]%' --A0z M
);

CREATE TABLE Administraci�n.EstudianteProfesor(
	ProfesorID INT,
	EstudianteID INT,

	CONSTRAINT PK_EstudianteProfesor
	PRIMARY KEY (EstudianteID, ProfesorID),

	CONSTRAINT FK_EstudianteProfesor_Profesor_ProfesorID
	FOREIGN KEY (ProfesorID) REFERENCES
	Profesor(ProfesorID)
	ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT FK_EstudianteProfesor_Estudiante_EstudianteID
	FOREIGN KEY (EstudianteID) REFERENCES
	Administraci�n.Estudiante(EstudianteID)
);

CREATE TABLE Puntuaci�n(
	Puntuaci�nID INT,
	Valor INT NOT NULL,
	Motivo VARCHAR(50) NOT NULL,

	CONSTRAINT PK_Puntuaci�n
	PRIMARY KEY (Puntuaci�nID),

	CONSTRAINT CK_Puntuaci�n_Puntuaci�nID
	CHECK (Puntuaci�nID > 0),

	CONSTRAINT CK_Puntuaci�n_Motivo
	CHECK(Motivo LIKE 'El estudiante%'),

	CONSTRAINT CK_Puntuaci�n_Valor
	CHECK (Valor BETWEEN -100 AND 200),
);

CREATE TABLE Profesor.Asigna(
	AsignaID INT,
	EstudianteID INT NOT NULL,
	ProfesorID INT NOT NULL,
	Puntuaci�nID INT NOT NULL,

	CONSTRAINT PK_Asigna PRIMARY KEY(AsignaID),

	CONSTRAINT FK_Asigna_EstudianteProfesor_EstudianteID_ProfesorID
	FOREIGN KEY (EstudianteID, ProfesorID)
	REFERENCES Administraci�n.EstudianteProfesor
	(EstudianteID, ProfesorID)
	ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT FK_Asigna_Puntuaci�n_Puntuaci�nID
	FOREIGN KEY (Puntuaci�nID)
	REFERENCES Puntuaci�n(Puntuaci�nID)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Alumno.Casa(
	CasaID INT,
	CasaNombre VARCHAR(50) NOT NULL,
	Puntos INT NOT NULL CONSTRAINT DF_Casa_Puntos DEFAULT 0,

	CONSTRAINT PK_Casa PRIMARY KEY(CasaID),

	CONSTRAINT CK_Casa_CasaID 
	CHECK(CasaID BETWEEN 1 AND 4),

	CONSTRAINT AK_Casa_CasaNombre
	UNIQUE(CasaNombre),

	CONSTRAINT CK_Casa_Puntos
	CHECK(Puntos >= 0)
);

CREATE TABLE CasaEstudiante (
	CasaID INT,
	EstudianteID INT,
	CONSTRAINT PK_CasaEstudiante
	PRIMARY KEY(CasaID, EstudianteID),
	CONSTRAINT FK_CasaEstudiante_Casa_CasaID
	FOREIGN KEY (CasaID)
	REFERENCES Alumno.Casa(CasaID)
	ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT FK_CasaEstudiante_Estudiante_EstudianteID
	FOREIGN KEY (EstudianteID)
	REFERENCES Administraci�n.Estudiante(EstudianteID)
	ON DELETE CASCADE ON UPDATE CASCADE,
);