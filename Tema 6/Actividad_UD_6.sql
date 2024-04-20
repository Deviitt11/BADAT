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
    nombrecompleto VARCHAR2 -- variable para el nombre del estudiante
) 
AS 
    encontrado BOOLEAN := false; -- variabl booleana para saber si encuentro el estudiante o no
BEGIN FOR fila IN (
    SELECT * FROM LogEstudiante 
    WHERE EstudianteNombreCompleto = nombrecompleto) LOOP -- si ambos nombres coinciden, imprime toda la info
        DBMS_OUTPUT.PUT_LINE(fila.LogID || ' ' || fila.EstudianteNombreCompleto || ' ' || fila.Accion || ' ' || fila.Instante); 
    END LOOP; 
    IF(NOT encontrado) THEN -- si no está presente, imprime mensaje
        DBMS_OUTPUT.PUT_LINE('No encuentro el estudiante: ' || nombrecompleto);
    END IF; 
END log_estudiante; 
/

-- 2.a
CREATE OR REPLACE FUNCTION mayor_de_edad(edad INT) RETURN VARCHAR2 AS -- se le da una edad
    resultado VARCHAR2(32); -- variable que contiene el resultado, longitud hasta 32 (reference)
BEGIN
    IF edad >= 18 THEN -- si es mayor o igual de 18
        resultado := 'Mayor de edad'; -- machacamos var resultado con el mensaje
    ELSE
        resultado := 'Menor de edad'; -- si no lo es, machacamos variable
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
    resultado2 := mayor_de_edad(:NEW.Edad);
  
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
    ELSIF DELETING THEN -- si la acción realizada es borrar, lo mismo con su respectivo mensaje
        accionEst := 'se da de baja';
    END IF;

    INSERT INTO LogEstudiante (accion, instante)
    VALUES (accionEst, CURRENT_TIMESTAMP);
END;
/

-- REALIZAR INSERTS Y DELETES DE ESTA TABLA

-- 3.a
CREATE OR REPLACE PROCEDURE matricula(
    p_nombre_estudiante VARCHAR2,
    p_codigo_asignatura VARCHAR2
) AS
    v_id_estudiante estudiante.estudiante_id%TYPE;
BEGIN
    -- Obtener el ID del estudiante dado su nombre completo
    SELECT estudiante_id INTO v_id_estudiante
    FROM estudiante
    WHERE nombre_completo = p_nombre_estudiante;

    -- Insertar en la tabla EstudianteAsignatura
    INSERT INTO EstudianteAsignatura(estudiante_id, asignatura_codigo, anio)
    VALUES (v_id_estudiante, p_codigo_asignatura, EXTRACT(YEAR FROM CURRENT_DATE));
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Matrícula realizada exitosamente para ' || p_nombre_estudiante || ' en la asignatura ' || p_codigo_asignatura || ' para el año ' || EXTRACT(YEAR FROM CURRENT_DATE));
END matricula;
/

-- 3.b
CREATE OR REPLACE PROCEDURE desmatricula (
    nombre_estudiante VARCHAR2,
    codigo_asignatura VARCHAR2
) 
AS
BEGIN
    DELETE FROM EstudianteAsignatura
    WHERE EstudianteID = (
        SELECT EstudianteID
        FROM Estudiante
        WHERE EstudianteNombreCompleto = nombre_estudiante
    ) AND AsignaturaID = (
        SELECT AsignaturaID
        FROM Asignatura
        WHERE AsignaturaCodigo = codigo_asignatura
    );
    
    DBMS_OUTPUT.PUT_LINE('Se ha realizado la desmatriculación para : ' || nombre_estudiante || ' en la asignatura: ' || codigo_asignatura);
END desmatricula;
/

-- 3.c
CREATE OR REPLACE TRIGGER estudianteasignatura_a_log
AFTER INSERT OR DELETE ON EstudianteAsignatura
FOR EACH ROW
DECLARE
    accion VARCHAR2(100);
BEGIN
    IF INSERTING THEN
        accion := 'se matricula de ' || :NEW.AsignaturaID;
    ELSIF DELETING THEN
        accion := 'se desmatricula de ' || :OLD.AsignaturaID;
    END IF;
    
    INSERT INTO EstudianteAsignatura (EstudianteID, AsignaturaID, fecha)
    VALUES (:NEW.EstudianteID, AsignaturaID, SYSDATE);
END;
/
















