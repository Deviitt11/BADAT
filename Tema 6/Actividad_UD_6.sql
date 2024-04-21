-- para crear el user y la contraseña
-- CREATE USER C##Actividad_UD_6 IDENTIFIED BY admin;
-- GRANT ALL PRIVILEGES TO C##Actividad_UD_6;

-- 1.a. 
CREATE OR REPLACE TRIGGER completa_log 
BEFORE INSERT ON LogEstudiante 
FOR EACH ROW 
BEGIN 
    :NEW.Instante := CURRENT_TIMESTAMP; 
END; 
/ 

-- 1.b. 
CREATE OR REPLACE PROCEDURE log_estudiante ( 
    nombrecompleto VARCHAR2 
) 
AS 
    encontrado BOOLEAN := false; 
BEGIN FOR fila IN (
    SELECT * FROM LogEstudiante 
    WHERE estudiantenombrecompleto = nombrecompleto) LOOP -- si ambos nombres coinciden, imprime toda la info
        DBMS_OUTPUT.PUT_LINE(fila.LogID || ' ' || fila.estudiantenombrecompleto || ' ' || fila.acción || ' ' || fila.instante); 
    END LOOP; 
    IF(NOT encontrado) THEN -- si no está presente, imprime mensaje
        DBMS_OUTPUT.PUT_LINE('No encuentro el estudiante: ' || nombrecompleto);
    END IF; 
END; 
/

-- 2.a
CREATE OR REPLACE FUNCTION mayor_de_edad(edad INT) RETURN VARCHAR2 AS -- se le da una edad
    resultado VARCHAR2(32); -- variable que contiene el resultado, longitud hasta 32 (reference)
BEGIN
    IF edad >= 18 THEN -- si es mayor o igual de 18
        resultado := 'Mayor de edad'; -- machaco var resultado con el mensaje
    ELSE
        resultado := 'Menor de edad'; -- si no lo es, machaco variable tmb
    END IF;
  
    RETURN resultado; -- devuelve la variable con el resultado
END;
/

-- 2.b
CREATE OR REPLACE TRIGGER completa_estudiante
BEFORE INSERT ON Estudiante -- al hacer la inserción, es decir antes
FOR EACH ROW
DECLARE
    resultado2 VARCHAR2(32); -- otra variable como en la función anterior
BEGIN
     -- llamo a la función anterior pasándole por parámetro la edad, el resultado lo almaceno en la var
    resultado2 := mayor_de_edad(:NEW.Edad); -- new con nuevos datos para la inserción
  
    -- si es mayor de edad, machaco el campo MayorDeEdad de la tabla Estudiante con 1, 0 si no lo es
    IF resultado2 = 'Mayor de edad' THEN
        :NEW.MayorDeEdad := 1;
    ELSE
        :NEW.MayorDeEdad := 0;
    END IF;
END;
/

-- 2.c
CREATE OR REPLACE TRIGGER estudiante_a_log
AFTER INSERT OR DELETE ON Estudiante -- interesa q se active después de la acción, asi que after
FOR EACH ROW
DECLARE
    accionEst VARCHAR2(32); -- variable para almacenar la acción que llevó a cabo el estudiante
BEGIN
    IF INSERTING THEN -- si se inserta, machacamos var accion con el mensaje pedido
        accionEst := 'se da de alta';
        
        INSERT INTO LogEstudiante (estudiantenombrecompleto, acción) -- e inserto el nombre del estu y la acción a pinchu en LogEstudiante
        VALUES (:NEW.estudiantenombrecompleto, accionEst); -- usando el new ya que es inserción
    ELSIF DELETING THEN -- si la acción realizada es borrar, lo mismo con su respectivo mensaje
        accionEst := 'se da de baja';
        
        INSERT INTO LogEstudiante (estudiantenombrecompleto, acción) -- lo mismo q en el apartado anterior
        VALUES (:OLD.estudiantenombrecompleto, accionEst); -- pero con el old ya que es borrado
    END IF;
END;
/

-- 2.d PARA REALIZAR INSERTS Y DELETES DE ESTA TABLA
CLEAR SCREEN
INSERT INTO Estudiante (estudianteid, estudiantenombrecompleto, edad) 
VALUES (1, 'Tony Stark', 28);

INSERT INTO Estudiante (estudianteid, estudiantenombrecompleto, edad) 
VALUES (2, 'Steve Rogers', 17);

INSERT INTO Estudiante (estudianteid, estudiantenombrecompleto, edad) 
VALUES (3, 'Natasha Romanoff', 16);

INSERT INTO Estudiante (estudianteid, estudiantenombrecompleto, edad) 
VALUES (4, 'Thor Odinson', 4000);

SELECT * FROM Estudiante;
SELECT * FROM LogEstudiante;

DELETE FROM Estudiante
WHERE MOD(EstudianteID, 2)=0;

SELECT * FROM LogEstudiante;
EXECUTE log_estudiante('Thor Odinson');
EXECUTE log_estudiante('Vi Sion');

-- 3.a
CREATE OR REPLACE PROCEDURE matricula ( 
    nombrecompleto VARCHAR2,
    codigoasignatura VARCHAR2
) AS
    year INT := EXTRACT(YEAR FROM CURRENT_TIMESTAMP);
BEGIN

    -- q se inserta aparte de idasignatura y el año? 
    INSERT INTO EstudianteAsignatura (asignaturaid, año) 
    VALUES (codigo_asignatura, year);
END;
/

-- 3.b
CREATE OR REPLACE PROCEDURE desmatricula (
    nombreestudiante VARCHAR2,
    codigoasignatura VARCHAR2
) 
AS
BEGIN
    DELETE FROM EstudianteAsignatura -- borro en la tabla EstAsig
    WHERE estudianteID = ( -- q pille el id coincidente con el nombre del estudiante
        SELECT estudianteID
        FROM estudiante -- empalmo con tabla estudiante para comparar nombres
        WHERE estudiantemombrecompleto = nombreestudiante
    ) 
    AND asignaturaID = ( -- y q pille la asignatura en función del código dado
        SELECT asignaturaID
        FROM asignatura -- empalmo con tabla asignatura para comparar codigos
        WHERE AsignaturaCodigo = codigoasignatura
    );
    
    -- mensaje para indicar que la desmatriculación salió bien
    DBMS_OUTPUT.PUT_LINE('El estudiante : ' || nombre_estudiante || ' en la asignatura: ' || codigo_asignatura || 'ha sido desmatriculado correctamente');

END;
/

-- 3.c
CREATE OR REPLACE TRIGGER estudianteasignatura_a_log
AFTER INSERT OR DELETE ON EstudianteAsignatura
FOR EACH ROW
DECLARE
    accion VARCHAR2(50);
BEGIN
    IF INSERTING THEN
        accion := 'se matricula de ' || :NEW.AsignaturaID;
    ELSIF DELETING THEN
        accion := 'se desmatricula de ' || :OLD.AsignaturaID;
    END IF;
    
    INSERT INTO EstudianteAsignatura (estudianteID, asignaturaID, año)
    VALUES (:NEW.EstudianteID, AsignaturaID, EXTRACT(YEAR FROM CURRENT_DATE));
END;
/
















