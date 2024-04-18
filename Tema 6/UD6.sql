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
CREATE FUNCTION edad(nacimiento DATE)
          RETURN INT
          AS
              actual DATE := CURRENT_DATE;
              diferencia INT;
          BEGIN
              diferencia := EXTRACT(YEAR from actual)-EXTRACT(YEAR from nacimiemto);
              -- si el mes todavía no fue: resto
              IF (EXTRACT(MONTH from nacimiento)>EXTRACT(MONTH from actual)) THEN
                RETURN diferencia-1;
              END IF;
              -- si el mes igual pero el día todavía no fue: resto
              IF (EXTRACT(MONTH from nacimiento)=EXTRACT(MONTH from actual) 
              AND EXTRACT(DAY from nacimiento)>EXTRACT(DAY from actual)) THEN
                RETURN diferencia-1;
              END IF;
              RETURN diferencia;
          END edad;
/

-- pruebas
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE(edad('18/03/2000'));
END;

-- 3.11
CREATE OR REPLACE FUNCTION cuenta(cadena VARCHAR2, caracter VARCHAR2)
RETURN INT
AS
    contador INT := 0;
BEGIN
    FOR pos IN 1..LENGTH(cadena) LOOP
    IF(SUBSTR(cadena, pos, 1)=caracter) THEN
        contador := contador + 1;
    END IF;
    END LOOP;
    RETURN contador;
END cuenta;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE(cuenta('¿Quién es John Galt?', ' '));
END;

-- 3.12
CREATE OR REPLACE PROCEDURE alveres(cadena VARCHAR2) AS
    caracter VARCHAR2(1); 
BEGIN
    FOR pos IN REVERSE 2..LENGTH(cadena) LOOP
        caracter := SUBSTR(cadena, pos, 1);
        DBMS_OUTPUT.PUT(caracter);
    END LOOP;
    caracter := SUBSTR(cadena, 1, 1);
    DBMS_OUTPUT.PUT_LINE(caracter);
END;

BEGIN
    alveres('Quien es John Galt?');
END;

-- 3.13
CREATE OR REPLACE FUNCTION YEAR(fecha DATE) RETURN INT AS
BEGIN
    RETURN EXTRACT(YEAR FROM fecha);
END;

SELECT YEAR('20/10/1990');
FROM DUAL;

-- 3.14
CREATE OR REPLACE PROCEDURE cambio(precio FLOAT, pago FLOAT) AS
    vuelta FLOAT := pago-precio;
BEGIN
    IF(vuelta<0) THEN
        DBMS_OUTPUT.PUT_LINE('Qué gracioso...');
        RETURN;
    END IF;
    
    -- pagó bien
    
END;

-- 4.3
-- PEGAR COSAS
create or replace PROCEDURE reponer 
(
  ID INT
  ,CANTIDAD INT 
) AS 
BEGIN
  UPDATE inventario
  SET Existencias = EXISTENCIAS + cantidad
  WHERE productoid = id;
END reponer;
/

create or replace PROCEDURE COMPRA
(

    IDFactura INT,
    Nombre VARCHAR2,
    cantidad INT,
)
AS
    -- comprobar parámetros
    facturaCorrecta INT := 0;
    nombreCorrecto BOOLEAN := false;
    IDProducto INT;
BEGIN
    -- miro si está la factura
  SELECT COUNT(*) INTO facturaCorrecta
  FROM factura
  WHERE facturaID = IDFactura;
  -- miro si está el producto
  FOR fila IN (
    SELECT *
    FROM Inventario
    ) LOOP
    IF (fila.ProductoNombre = Nombre) THEN
        nombreCorrecto := true;
        IDProducto := fila.ProductoID;
    END IF;
    END LOOP;
    -- si son ambos correctos: inserto
    IF(numFacturas>0 AND nombreCorrecto) THEN
        INSERT INTO LineaDeFactura (FacturaID, ProductoID, ProductoNombre, Cantidad)
            VALUES(IDFactura, Nombre, cantidad);
    END IF;
END COMPRA;
/

BEGIN
    compra(1, 'Oxygen', 1);
END;

SELECT *
FROM "LINEADEFACTURA";



