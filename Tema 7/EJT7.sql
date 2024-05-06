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
BEGIN
    -- velocidad 0?
    DBMS_OUTPUT.PUT_LINE(v1.velocidad);
    v1.acelera(5,2);
    DBMS_OUTPUT.PUT_LINE(v1.compara(v2));
END;


