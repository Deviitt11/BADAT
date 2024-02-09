USE Hogwarts;

-- Rematamos estudiante
ALTER TABLE Administraci�n.Estudiante
ADD EstudianteID INT NOT NULL;

ALTER TABLE Administraci�n.Estudiante
ADD CONSTRAINT PK_Estudiante
PRIMARY KEY (EstudianteID);

ALTER TABLE Administraci�n.Estudiante
ADD EstudianteNombre VARCHAR(50) NOT NULL;

ALTER TABLE Administraci�n.Estudiante
ADD Edad INT NOT NULL;

ALTER TABLE Administraci�n.Estudiante
ADD CONSTRAINT DF_Estudiante_Edad
DEFAULT 11 For Edad;

ALTER TABLE Administraci�n.Estudiante
ADD CONSTRAINT CK_Estudiante_Edad
CHECK(Edad BETWEEN 11 AND 20);

ALTER TABLE Administraci�n.Estudiante
ADD CURSO INT NOT NULL;

ALTER TABLE Administraci�n.Estudiante
ADD CONSTRAINT DF_Estudiante_Curso
DEFAULT 1 FOR Curso;

ALTER TABLE Administraci�n.Estudiante
ADD CONSTRAINT CK_Estudiante_Curso
CHECK(Curso BETWEEN 1 AND 7);

ALTER TABLE Administraci�n.Estudiante
DROP COLUMN Dato;