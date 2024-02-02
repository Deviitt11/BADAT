USE Apellidos_Nombre_Memes
GO
 
DROP TABLE IF EXISTS Meme, Matr�cula, Asignatura;
GO
 
-- tabla asignatura
CREATE TABLE Asignatura(
	-- metemos los campos
	AsignaturaID INT,
	NombreAsignatura VARCHAR(70) NOT NULL,
	ProfesorID INT NOT NULL,
	Cr�ditos FLOAT NOT NULL,
	Web VARCHAR(70),
 
	-- restricciones

	-- restricci�n PK
	CONSTRAINT PK_AsignaturaID
	PRIMARY KEY(AsignaturaID), 

	-- restricci�n NombreAsignatura
	CONSTRAINT CK_Asignatura_NombreAsignatura
	CHECK(NombreAsignatura CONTAINS ('%Meme%')),

	-- restricci�n Cr�ditos
	CONSTRAINT CK_Asignatura_Cr�ditos
	CHECK(Cr�ditos > 0), 
);
GO -- siempre entra
 
CREATE TABLE Matr�cula(
	-- metemos los campos
	Matr�culaID INT,
	AsignaturaID INT NOT NULL,
	AlumnoID INT NOT NULL,
	Convocatorias INT NOT NULL,
	NotaFinal FLOAT,
);

-- restricciones

ALTER TABLE Matr�cula
-- restricci�n PK
ADD CONSTRAINT PK_Matr�culaID
PRIMARY KEY(Matr�culaID);

ALTER TABLE Matr�cula
-- restricci�n Convocatorias 1
ADD CONSTRAINT CK_Matr�cula_Convocatorias1
DEFAULT 1;

ALTER TABLE Matr�cula
-- restricci�n Convocatorias 2
ADD CONSTRAINT CK_Matr�cula_Convocatorias2
CHECK(Convocatorias >= 1);

ALTER TABLE Matr�cula
-- restricci�n NotaFinal
ADD CONSTRAINT CK_Matr�cula_NotaFinal
CHECK(NotaFinal BETWEEN 0 AND 10);
 
CREATE TABLE Meme(
	-- metemos los campos
	MemeID INT,
	Matr�culaID INT NOT NULL,
	T�tuloMeme VARCHAR(70) NOT NULL,
	Nota NCHAR(1) NOT NULL,
	Rating FLOAT NOT NULL,

	-- restricciones
	CONSTRAINT CK_Meme_Nota
	DEFAULT
);
 
 
