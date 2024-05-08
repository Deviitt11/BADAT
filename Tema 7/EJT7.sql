-- 1.1
create or replace type c�rculo_type as object 
( /* TODO enter attribute and method declarations here */ 

    -- atributos
    radio FLOAT,
    color VARCHAR2(50),
    
    -- function
    MEMBER FUNCTION longitud RETURN FLOAT,
    MEMBER FUNCTION �rea RETURN FLOAT,
    MEMBER PROCEDURE muestra(SELF c�rculo_type),
    MAP MEMBER FUNCTION getRadio RETURN FLOAT,
    
    -- constructores
    CONSTRUCTOR FUNCTION c�rculo_type(radio FLOAT, color VARCHAR2)
        RETURN SELF AS RESULT,
    CONSTRUCTOR FUNCTION c�rculo_type(radio FLOAT)
        RETURN SELF AS RESULT
    
)
/

-- CUERPO
create or replace type body "C�RCULO_TYPE" as

  member function longitud return float as
  begin
    return 2*3.14192*SELF.radio;
  end longitud;

  member function �rea return float as
  begin
    -- TAREA: Se necesita implantaci�n para FUNCTION C�RCULO_TYPE.�rea
    return 3.1415*POWER(SELF.radio,2);
  end �rea;

  member procedure muestra(self c�rculo_type) as
  begin
    DBMS_OUTPUT.PUT_LINE('C�rculo de radio ' || SELF.radio || ' y color ' || SELF.color);
  end muestra;

  map member function getradio return float as
  begin
    return SELF.radio;
  end getradio;

  constructor function c�rculo_type(radio float, color varchar2)
        return self as result as
  begin
    SELF.radio := radio;
    SELF.color := color;
    return;
  end c�rculo_type;

  constructor function c�rculo_type(radio float)
        return self as result as
  begin
    SELF := NEW c�rculo_type(radio, 'Azul');
  end c�rculo_type;

end;
/

DECLARE
    c1 c�rculo_type := NEW c�rculo_type(-2); -- (color Azul)
    c2 c�rculo_type := NEW c�rculo_type(3, 'Rojo'); -- (color Azul)
BEGIN
    DBMS_OUTPUT.ENABLE;
    c1.color := 'Amarillo'; -- atributo p�blico
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
    c1 c�rculo_type := NEW C�rculo_type(5);
    c2 c�rculo_type := NEW C�rculo_type(2, 'Azul');
BEGIN
    DBMS_OUTPUT.ENABLE;
   -- CREATE TABLE circulo_table of c�rculo_type;
    DELETE FROM Circulo_table;
    INSERT INTO Circulo_table VALUES (c1);
    INSERT INTO Circulo_table VALUES (c2);
    c1.radio := -2;
    --SELECT * FROM c�rculo_table;
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
    
    DBMS_OUTPUT.PUT_LINE(vehiculos.LIMIT()); -- 2 ELEMENTOS M�X
    DBMS_OUTPUT.PUT_LINE(vehiculos.COUNT()); -- 0 posiciones desbloqueadas
    vehiculos.EXTEND(); -- desbloqueo la 1� posi
    
    -- indexaci�n comienza en 1
    vehiculos(1) := v1; -- primer veh�culo
    
    -- meter otro vehiculo
    vehiculos.EXTEND();
    vehiculos(2) := v2;
    
    -- recorrer un varray
    FOR i IN 1..vehiculos.LIMIT() LOOP
        DBMS_OUTPUT.PUT_LINE(vehiculos(1).velocidad);
    END LOOP;
    
END;



