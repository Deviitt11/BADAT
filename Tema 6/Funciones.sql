CLEAR SCREEN -- limpia salida de script (consultas...)
BEGIN
    BEGIN
        DBMS_OUTPUT.ENABLE;
        DBMS_OUTPUT.PUT('Hola');
        DBMS_OUTPUT.PUT('mundo');
        DBMS_OUTPUT.put_line('!');
    END;
 
    DECLARE
        a INT := 3;
        b FLOAT := -2.7;
        c BOOLEAN := true;
    BEGIN
        DBMS_OUTPUT.put_line(a);
        DBMS_OUTPUT.put_line(b);
        --DBMS_OUTPUT.put_line(c);
    END;
    DECLARE
        a int := 17;
        b INT := 5;
    BEGIN
        DBMS_OUTPUT.put_line(a/b); -- division "real"
        DBMS_OUTPUT.put_line(TRUNC(a/b, 0)); -- division por enteros
    END;
    
    DECLARE
        cadena VARCHAR2(5) := 'misco';
    BEGIN 
        DBMS_OUTPUT.put_line(length(cadena));
        -- saco el primer caracter
        DBMS_OUTPUT.put_line(substr(cadena, 0, 1));
        SELECT CURRENT_DATE FROM dual;
        SELECT CURRENT_TIMESTAMP FROM dual;
    END;
    
    DECLARE
        a BOOLEAN := true;
    BEGIN
        --DBMS_OUTPUT.PUT_LINE(a); -- no se puede
        IF(a) THEN
            DBMS_OUTPUT.PUT_LINE('true');
        ELSE
            DBMS_OUTPUT.PUT_LINE('false');
        END IF;
    END;
END;