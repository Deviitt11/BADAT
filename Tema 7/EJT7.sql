-- 1.1
create or replace type círculo_type as object 
( /* TODO enter attribute and method declarations here */ 

    -- atributos
    radio FLOAT,
    color VARCHAR2(50),
    
    -- function
    MEMBER FUNCTION longitud RETURN FLOAT,
    MEMBER FUNCTION área RETURN FLOAT,
    MEMBER PROCEDURE muestra(SELF círculo_type),
    MAP MEMBER FUNCTION getRadio RETURN FLOAT,
    
    -- constructores
    CONSTRUCTOR FUNCTION círculo_type(radio FLOAT, color VARCHAR2)
        RETURN SELF AS RESULT,
    CONSTRUCTOR FUNCTION círculo_type(radio FLOAT)
        RETURN SELF AS RESULT
    
)
/

-- CUERPO
create or replace type body "CÍRCULO_TYPE" as

  member function longitud return float as
  begin
    return 2*3.14192*SELF.radio;
  end longitud;

  member function área return float as
  begin
    -- TAREA: Se necesita implantación para FUNCTION CÍRCULO_TYPE.área
    return 3.1415*POWER(SELF.radio,2);
  end área;

  member procedure muestra(self círculo_type) as
  begin
    DBMS_OUTPUT.PUT_LINE('Círculo de radio ' || SELF.radio || ' y color ' || SELF.color);
  end muestra;

  map member function getradio return float as
  begin
    return SELF.radio;
  end getradio;

  constructor function círculo_type(radio float, color varchar2)
        return self as result as
  begin
    SELF.radio := radio;
    SELF.color := color;
    return;
  end círculo_type;

  constructor function círculo_type(radio float)
        return self as result as
  begin
    SELF := NEW círculo_type(radio, 'Azul');
  end círculo_type;

end;
/

DECLARE
    c1 círculo_type := NEW círculo_type(-2); -- (color Azul)
    c2 círculo_type := NEW círculo_type(3, 'Rojo'); -- (color Azul)
BEGIN
    DBMS_OUTPUT.ENABLE;
    c1.color := 'Amarillo'; -- atributo público
    c1.muestra();
    -- apartado d)
    -- DBMS_OUTPUT.PUT_LINE(c1>c2); no puedo imprimir booleanos
    IF (c1>c2) THEN
        DBMS_OUTPUT.PUT_LINE('c1 mayor');
    ELSE
        DBMS_OUTPUT.PUT_LINE('c1 MENOR');
    END IF;
END;
/

DECLARE
    c1 círculo_type := NEW Círculo_type(5);
    c2 círculo_type := NEW Círculo_type(2, 'Azul');
BEGIN
    DBMS_OUTPUT.ENABLE;
   -- CREATE TABLE circulo_table of círculo_type;
    DELETE FROM Circulo_table;
    INSERT INTO Circulo_table VALUES (c1);
    INSERT INTO Circulo_table VALUES (c2);
    c1.radio := -2;
    --SELECT * FROM círculo_table;
    DBMS_OUTPUT.PUT_LINE(c1.radio);
END;
/

-- 1.2
DECLARE
    v1 vehiculo_type := NEW vehiculo_type('1234');
    v2 vehiculo_type := NEW vehiculo_type('5678');
    valor FLOAT := 5.2;
    vehiculos vehiculos_varray := new vehiculos_varray();
BEGIN
    -- velocidad 0?
    DBMS_OUTPUT.PUT_LINE(v1.velocidad);
    v1.acelera(15);
    v2.frena(10);
    DBMS_OUTPUT.PUT_LINE(v1.compara(v2));
    
    DBMS_OUTPUT.PUT_LINE(vehiculos.LIMIT()); -- 2 ELEMENTOS MÁX
    DBMS_OUTPUT.PUT_LINE(vehiculos.COUNT()); -- 0 posiciones desbloqueadas
    vehiculos.EXTEND(); -- desbloqueo la 1ª posi
    
    -- indexación comienza en 1
    vehiculos(1) := v1; -- primer vehículo
    
    -- meter otro vehiculo
    vehiculos.EXTEND();
    vehiculos(2) := v2;
    
    -- recorrer un varray
    FOR i IN 1..vehiculos.LIMIT() LOOP
        DBMS_OUTPUT.PUT_LINE(vehiculos(1).velocidad);
    END LOOP;
    
END;

-- 1.4
CREATE OR REPLACE TYPE BOLA_TYPE AS OBJECT 
( --atributos
    nombre VARCHAR2(50)
    ,velocidad int
    --METODOS
    ,MEMBER FUNCTION quieta RETURN BOOLEAN
    ,MEMBER PROCEDURE muestra(SELF IN OUT bola_type)
    ,MEMBER PROCEDURE golpea(SELF IN OUT bola_type, otra bola_type)
    --CONSTRUCTORES
    ,CONSTRUCTOR FUNCTION bola_type(nombre VARCHAR2, velocidad INT)
    return self as result
    ,CONSTRUCTOR FUNCTION bola_type(nombre VARCHAR2)
    return self as result
)
/

create or replace type body bola_type as
 
  member function quieta return boolean as
  begin
    RETURN SELF.velocidad=0;
  end quieta;
 
  member procedure muestra(self in out bola_type) as
  begin
    -- TAREA: Se necesita implantación para PROCEDURE BOLA_TYPE.muestra
    null;
  end muestra;
 
  member procedure golpea(self in out bola_type, otro bola_type) as
  begin
    -- TAREA: Se necesita implantación para PROCEDURE BOLA_TYPE.golpea
    null;
  end golpea;
 
  constructor function bola_type(nombre varchar2, velocidad int)
    return self as result as
  begin
    -- TAREA: Se necesita implantación para FUNCTION BOLA_TYPE.bola_type
    return null;
  end bola_type;
 
  constructor function bola_type(nombre varchar2)
    return self as result as
  begin
    -- TAREA: Se necesita implantación para FUNCTION BOLA_TYPE.bola_type
    return null;
  end bola_type;
 
end;
/

DECLARE
    b1 bola_type := NEW bola_type('Frenando', 20);
    b2 bola_type := NEW bola_type('Alonso');
BEGIN
    b1.golpea(b2);
END;
/

-- EJ 1.5
CREATE TYPE v_varchar IS VARRAY(50) OF VARCHAR2(50);

DECLARE
    v v_varchar := NEW v_varchar(); -- ('a', 'b', 'c');
    s seleccionador_type; -- := NEW seleccionador_type(v);
BEGIN
    v.EXTEND(); v(1) := 'a';
    v.EXTEND(); v(2) := 'b';
    v.EXTEND(); v(3) := 'c';
    v.EXTEND();
    s := NEW seleccionador_type(v);
    DBMS_OUTPUT.PUT_LINE(s.respuesta());
    DBMS_OUTPUT.PUT_LINE(s.respuesta());
    DBMS_OUTPUT.PUT_LINE(s.respuesta());
END;
/

DECLARE
    p password_type := new password_type('ABC');
BEGIN
    DBMS_OUTPUT.PUT_LINE(p.cuentacaracteresnoespeciales);
END;

DECLARE
    p1 password_type := new password_type('1234');
BEGIN
    DBMS_OUTPUT.PUT_LINE(p1.essegura);
    DBMS_OUTPUT.PUT_LINE(password_type.generador());
END;



