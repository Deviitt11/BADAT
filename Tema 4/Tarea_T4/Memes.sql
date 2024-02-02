USE Apellidos_Nombre_Memes
GO
 
DROP TABLE IF EXISTS Meme, Matrícula, Asignatura;
GO
 
-- tabla asignatura
CREATE TABLE Asignatura(
	-- metemos los campos
	AsignaturaID INT,
	NombreAsignatura VARCHAR(70) NOT NULL,
	ProfesorID INT NOT NULL,
	Créditos FLOAT NOT NULL,
	Web VARCHAR(70),
 
	-- restricciones

	-- restricción PK
	CONSTRAINT PK_AsignaturaID
	PRIMARY KEY(AsignaturaID), 

	-- restricción NombreAsignatura
	CONSTRAINT CK_Asignatura_NombreAsignatura
	CHECK(NombreAsignatura CONTAINS ('%Meme%')),

	-- restricción Créditos
	CONSTRAINT CK_Asignatura_Créditos
	CHECK(Créditos > 0), 
);
GO -- siempre entra
 
CREATE TABLE Matrícula(
	-- metemos los campos
	MatrículaID INT,
	AsignaturaID INT NOT NULL,
	AlumnoID INT NOT NULL,
	Convocatorias INT NOT NULL,
	NotaFinal FLOAT,
);

-- restricciones

ALTER TABLE Matrícula
-- restricción PK
ADD CONSTRAINT PK_MatrículaID
PRIMARY KEY(MatrículaID);

ALTER TABLE Matrícula
-- restricción Convocatorias 1
ADD CONSTRAINT CK_Matrícula_Convocatorias1
DEFAULT 1;

ALTER TABLE Matrícula
-- restricción Convocatorias 2
ADD CONSTRAINT CK_Matrícula_Convocatorias2
CHECK(Convocatorias >= 1);

ALTER TABLE Matrícula
-- restricción NotaFinal
ADD CONSTRAINT CK_Matrícula_NotaFinal
CHECK(NotaFinal BETWEEN 0 AND 10);
 
CREATE TABLE Meme(
	-- metemos los campos
	MemeID INT,
	MatrículaID INT NOT NULL,
	TítuloMeme VARCHAR(70) NOT NULL,
	Nota NCHAR(1) NOT NULL,
	Rating FLOAT NOT NULL,

	-- restricciones
	CONSTRAINT CK_Meme_Nota
	DEFAULT
);
 
 
