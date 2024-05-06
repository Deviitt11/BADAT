--------------------------------------------------------
-- Archivo creado  - lunes-mayo-06-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type ATAQUE_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."ATAQUE_TYPE" as object 
( 
    -- atributos cuentan como públicos (como campos en una tabla)
    nombre VARCHAR2(50),
    daño INT,
    
    -- métodos no estáticos: MEMBER
    -- todos los métodos tienen como primer argumento
    -- implícito SELF (como el this del objeto)
    MEMBER FUNCTION getNombre RETURN VARCHAR2,
    MEMBER PROCEDURE muestra(SELF ataque_type)
    -- función de tipo MAP para comparar
    , MAP MEMBER FUNCTION getDaño RETURN INT
    -- MEMBER PROCEDURE muestra
    -- constructores
    -- uno con un parámetro por atributo
    , CONSTRUCTOR FUNCTION Ataque_type(nombre VARCHAR2, daño INT)
        RETURN SELF AS RESULT
    -- con el nombre y daño 5
    , CONSTRUCTOR FUNCTION Ataque_type(nombre VARCHAR2)
        RETURN SELF AS RESULT
)
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##MISCO"."ATAQUE_TYPE" as

  member function getnombre return varchar2 as
  begin
    return SELF.nombre;
  end getnombre;

  member procedure muestra(self ataque_type) as
  begin
    null;
  end muestra;

  constructor function ataque_type(nombre varchar2, daño int)
        return self as result as
  begin
    SELF.nombre := nombre;
    SELF.daño := daño;
    return;
  end ataque_type;

  constructor function ataque_type(nombre varchar2)
        return self as result as
  begin
    -- SELF := ataque_type(nombre,2)
    SELF.nombre := nombre;
    SELF.daño := 5; -- patatas
    return;
  end ataque_type;

  map member function getdaño return int as
  begin
    -- TAREA: Se necesita implantación para FUNCTION ATAQUE_TYPE.getDaño
    return SELF.Daño;
  end getdaño;

end;

/
--------------------------------------------------------
--  DDL for Type CÍRCULO_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."CÍRCULO_TYPE" as object 
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
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##MISCO"."CÍRCULO_TYPE" as

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
    return;
  end círculo_type;

end;

/
--------------------------------------------------------
--  DDL for Type VEHICULO_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."VEHICULO_TYPE" as object 
( 
    -- atributos
    velocidad NUMBER(4,1)
    , matricula VARCHAR2(10)
    -- métodos
    , MEMBER PROCEDURE acelera(SELF IN OUT vehiculo_type, incremento FLOAT)
    , MEMBER PROCEDURE frena(SELF IN OUT vehiculo_type, decremento FLOAT)
    , ORDER MEMBER FUNCTION compara(SELF vehiculo_type, otro vehiculo_type)
    RETURN INT
    -- constructor
    , CONSTRUCTOR FUNCTION vehiculo_type(matricula VARCHAR2)
    RETURN SELF AS RESULT
)
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##MISCO"."VEHICULO_TYPE" as

  member procedure acelera(self IN OUT vehiculo_type, incremento float) as
  begin
    SELF.velocidad := SELF.velocidad + incremento;
    DBMS_OUTPUT.PUT_LINE('La nueva velocidad es ' || SELF.velocidad || ' km/h ');
  end acelera;

  member procedure frena(self IN OUT vehiculo_type, decremento float) as
  begin
    SELF.acelera(-decremento);
  end frena;

  order member function compara(self vehiculo_type, otro vehiculo_type)
    return int as
  begin
    return (SELF.velocidad-otro.velocidad)*10;
  end compara;

  constructor function vehiculo_type(matricula varchar2)
    return self as result as
  begin
    SELF.matricula := matricula;
    SELF.velocidad := 0;
    return;
  end vehiculo_type;

end;

/
--------------------------------------------------------
--  DDL for Table CIRCULO_TABLE
--------------------------------------------------------

  CREATE TABLE "C##MISCO"."CIRCULO_TABLE" OF "C##MISCO"."CÍRCULO_TYPE" 
 OIDINDEX  ( PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ) 
 SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into C##MISCO.CIRCULO_TABLE
SET DEFINE OFF;
Insert into C##MISCO.CIRCULO_TABLE (RADIO,COLOR) values ('5','Azul');
Insert into C##MISCO.CIRCULO_TABLE (RADIO,COLOR) values ('2','Azul');
--------------------------------------------------------
--  Constraints for Table CIRCULO_TABLE
--------------------------------------------------------

  ALTER TABLE "C##MISCO"."CIRCULO_TABLE" ADD UNIQUE ("SYS_NC_OID$") RELY
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
