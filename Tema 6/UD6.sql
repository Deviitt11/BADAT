-- 3.2
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

-- 3.3
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
CREATE FUNCTION edad(nacimiento DATE) RETURN INT AS
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
    DBMS_OUTPUT.ENABLE;
    IF(vuelta<0) THEN
        DBMS_OUTPUT.PUT_LINE('Qué gracioso...');
        RETURN 0;
    ELSE 
        RETURN vuelta;
    END IF;
END;

-- 4.3
-- PEGAR COSAS
CREATE OR REPLACE PROCEDURE reponer (
    id INT,
    cantidad INT
) AS
BEGIN
    UPDATE inventario
    SET Existencias := Existencias + cantidad
    WHERE productoid = id;
END;
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

SELECT * FROM Factura;

SELECT * FROM Inventario;

-- factura 1 compra 10 de de enviro
EXECUTE compra(1, 'Enviro', 10);

-- 4.1
create or replace TRIGGER actualizaDiscos
AFTER DELETE OR INSERT OR UPDATE on Canción
FOR EACH ROW
DECLARE
    suma FLOAT;
BEGIN
    IF (DELETING) THEN
        -- borro canción y bajo tiempo
        UPDATE Disco
        SET disco.discoduración = disco.discoduración - :OLD.canciónduración
        WHERE disco.discoid = :OLD.discoID;
    ELSIF(INSERTING) THEN
        UPDATE Disco
        SET disco.discoduración = disco.discoduración + :NEW.canciónduración
        WHERE disco.discoid = :NEW.discoID;
    ELSE
        -- descuento del viejo
        UPDATE Disco
        SET disco.discoduración = disco.discoduración - :OLD.canciónduración
        WHERE disco.discoid = :OLD.discoID;

        -- sumo en el nuevo
        UPDATE Disco
        SET disco.discoduración = disco.discoduración + :NEW.canciónduración
        WHERE disco.discoid = :NEW.discoID;
    END IF;
END;

CREATE OR REPLACE TRIGGER completa_log
BEFORE INSERT ON LogEstudiante
FOR EACH ROW
BEGIN
    :NEW.Instante := CURRENT_TIMESTAMP;
END;

CREATE OR REPLACE PROCEDURE log_estudiante(nombre VARCHAR2)
AS
    encontrado BOOLEAN := false;
BEGIN
    DBMS_OUTPUT.ENABLE;
    FOR fila IN (
    
        SELECT EstudianteNombreCompleto, Accion
        FROM LogEstudiante
        WHERE EstudianteNombreCompleto = nombre
        ) LOOP
        encontrado := true;
        DBMS_OUTPUT.PUT_LINE(fila.EstudianteNombreCompleto || ' ' || fila.Accion);
    END LOOP;
    
    IF NOT encontrado THEN
        DBMS_OUTPUT.PUT_LINE('NO EXISTE' || nombre);
    END IF;
END;
/

CREATE OR REPLACE FUNCTION mayor_de_edad(edad INT)
RETURN BOOLEAN AS
BEGIN
    RETURN edad >= 18;
END;
/

CREATE OR REPLACE TRIGGER completa_estudiante
BEFORE INSERT ON Estudiante
BEGIN
    IF(mayor_de_edad(:NEW.Edad)) THEN
        :NEW.MayorDeEdad := 1;
    ELSE
        :NEW.MayorDeEdad := 0;
    END IF;
END;
/

CREATE OR REPLACE TRIGGER estudiante_log_a
AFTER INSERT OR DELETE ON Estudiante
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO LogEstudiante(estudiantenombrecompleto, acción)
        VALUES (:NEW.estudiantenombrecompleto, 'se da de alta');
    ELSIF DELETING THEN
        INSERT INTO LogEstudiante(estudiantenombrecompleto, acción)
        VALUES (:OLD.estudiantenombrecompleto, 'se da de alta');
    END IF;
END;
/

CREATE OR REPLACE PROCEDURE matricula(nombre VARCHAR2, codigo VARCHAR2)
AS
    estudianteIDvar INT := 0;
    asignaturaIDvar INT := 0;
BEGIN
    DBMS_OUTPUT.ENABLE;
    
    SELECT estudianteid INTO estudianteidvar 
    FROM estudiante
    WHERE estudiantenombrecompleto = nombre;
    
    SELECT asignatura INTO asignaturaidvar
    FROM asignatura
    WHERE asignaturacodigo = codigo;
    
    INSERT INTO EstudianteAsignatura
    VALUE (estudianteidvar, asignaturaidvar, EXTRACT(YEAR FROM CURRENT_DATE));
END;
/


CREATE OR REPLACE PROCEDURE desmatricula(nombre VARCHAR2, codigo VARCHAR2)
AS
    estudianteIDvar INT := 0;
    asignaturaIDvar INT := 0;
BEGIN
    DBMS_OUTPUT.ENABLE;
    
    SELECT estudianteid INTO estudianteidvar
    FROM estudiante
    WHERE estudiantenombrecompleto = nombre;
    
    SELECT asignaturaid INTO asignaturaidvar
    FROM asignatura
    WHERE asignaturacodigo = codigo;
    
    DELETE INTO EstudianteAsignatura
    WHERE estudianteid = estudianteidvar AND asignaturaid = asignaturaidvar;
    DBMS_OUTPUT.PUT_LINE('TO CORRECTO');
END;
/