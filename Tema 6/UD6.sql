CREATE OR REPLACE FUNCTION esPar(valor int) RETURN INT AS
BEGIN
DBMS_OUTPUT.ENABLE;
    IF(MOD(valor,2)=0) THEN
        DBMS_OUTPUT.PUT_LINE('par');
    ELSE
        DBMS_OUTPUT.PUT_LINE('IMPAR');
     END IF;
END;
/

CREATE OR REPLACE FUNCTION modulof(valor INT) RETURN INT AS
BEGIN
    RETURN MOD(valor,2);
END;
/

CREATE TABLE Numeros (
    Valor INT
    ,CONSTRAINT PK_Numeros PRIMARY KEY (Valor));

BEGIN
    FOR i IN 1..50 LOOP
        INSERT INTO Numeros VALUES (i);
    END LOOP;
 
END;
/
    
SELECT Valor, modulof(valor)
FROM NUMEROS;

CREATE OR REPLACE FUNCTION cuenta1 RETURN INT AS
    cuenta INT;
BEGIN
    SELECT COUNT(*)
    FROM Numeros;
    RETURN cuenta;
END;
/

CREATE OR REPLACE FUNCTION cuenta2 RETURN INT AS
    contador INT := 0;
BEGIN
    FOR fila IN (SELECT * FROM Numeros) LOOP
        contador := contador+1;
    END LOOP;
    RETURN contador;
END;
/

SELECT cuenta1 FROM DUAL;
SELECT cuenta2 FROM DUAL;


CREATE TABLE Autor (
	dni CHAR(9) PRIMARY KEY,
	nombre VARCHAR(20) NOT NULL,
	apellido VARCHAR(40) NOT NULL,
	edad INT NOT NULL CHECK(edad BETWEEN 0 AND 120),
	departamento VARCHAR(20) NOT NULL
);

INSERT INTO Autor VALUES ('11111111H', 'David', 'Méndez', 38, 'Física');
INSERT INTO Autor VALUES ('22222222J', 'Spenser', 'Checchi', 56, 'Marketing');
INSERT INTO Autor VALUES ('33333333P', 'Hally', 'Ribchester', 28, 'Ventas');
INSERT INTO Autor VALUES ('44444444A', 'Roch', 'Cuttings', 24, 'Física');
INSERT INTO Autor VALUES ('55555555K', 'Benjie', 'Dougher', 53, 'Marketing');
INSERT INTO Autor VALUES ('66666666Q', 'Emmanuel', 'Hatzar', 21, 'Física');
INSERT INTO Autor VALUES ('77777777B', 'Adela', 'Buessen', 44, 'Ventas');
INSERT INTO Autor VALUES ('88888888Y', 'Vittoria', 'Iveson', 20, 'Administración');
INSERT INTO Autor VALUES ('99999999R', 'Carola', 'Kieff', 42, 'Física');
INSERT INTO Autor VALUES ('12345678Z', 'Binnie', 'Ianitti', 54, 'Ventas');

-- 3.5
CREATE OR REPLACE PROCEDURE ej3_5(departamento VARCHAR2) AS
    BEGIN
        DBMS_OUTPUT.ENABLE;
        FOR fila in ( 
            SELECT *
            FROM Autor
           
            ) LOOP
            IF(fila.departamento = departamento) THEN
                DBMS_OUTPUT.PUT_LINE(fila.Nombre || ' ' || fila.Departamento);
            END IF;
    END LOOP;
END;

BEGIN
    ej3_5('Marketing');
END;
/

-- 3.6
CREATE OR REPLACE PROCEDURE ej3_6(departamento VARCHAR2) AS
    BEGIN
        DBMS_OUTPUT.ENABLE;
        FOR fila in ( 
            SELECT *
            FROM Autor
            ) LOOP
            IF(INSTR(LOWER(fila.Departamento), LOWER(departamento))!=0) THEN
                DBMS_OUTPUT.PUT_LINE(fila.Nombre || ' ' || fila.Departamento);
            END IF;
    END LOOP;
END;

BEGIN
    ej3_6('ing');
END;

-- 3.8
