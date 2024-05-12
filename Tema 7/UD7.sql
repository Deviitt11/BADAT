--------------------------------------------------------
-- Archivo creado  - viernes-mayo-10-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type ATAQUE_TYPE
--------------------------------------------------------

CREATE USER C##Misco IDENTIFIED BY admin;
GRANT ALL PRIVILEGES TO C##Misco;

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
--  DDL for Type BOLA_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."BOLA_TYPE" AS OBJECT 
( --atributos
    nombre VARCHAR2(50)
    ,velocidad int
    --METODOS
    ,MEMBER FUNCTION quieta RETURN BOOLEAN
    ,MEMBER PROCEDURE muestra(SELF IN OUT bola_type)
    ,MEMBER PROCEDURE golpea(SELF IN OUT bola_type, otra IN OUT bola_type)
    --CONSTRUCTORES
    ,CONSTRUCTOR FUNCTION bola_type(nombre VARCHAR2, velocidad INT)
    return self as result
    ,CONSTRUCTOR FUNCTION bola_type(nombre VARCHAR2)
    return self as result
)
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##MISCO"."BOLA_TYPE" as

  member function quieta return boolean as
  begin
    -- TAREA: Se necesita implantación para FUNCTION BOLA_TYPE.quieta
    return null;
  end quieta;

  MEMBER PROCEDURE muestra(SELF IN OUT Bola_type) AS
  cadena VARCHAR2(50) := 'Bola ' || SELF.nombre || ' con ' || SELF.velocidad || ' de velocidad.';
  BEGIN
    -- si está quieta...
    IF (self.quieta()) THEN
        cadena := cadena || ' Está quieta.';
    END IF;
    DBMS_OUTPUT.PUT_LINE(cadena);
  END muestra;

  member procedure golpea(self in out bola_type, otra in out bola_type) as
  begin
    SELF.muestra;
    DBMS_OUTPUT.PUT_LINE('golpea a');
    otra.muestra();
    otra.velocidad := otra.velocidad + SELF.velocidad-1;
    SELF.velocidad := 0;
    otra.muestra;
  end golpea;

  constructor function bola_type(nombre varchar2, velocidad int)
    return self as result as
  begin
    SELF.nombre := nombre;
    SELF.velocidad := velocidad;
    RETURN;
  end bola_type;

  constructor function bola_type(nombre varchar2)
    return self as result as
  begin
    -- SELF.nombre := nombre;
    -- SELF.velocidad := 0;
    SELF := new BOLA_TYPE(nombre,0);
    RETURN;
  end bola_type;

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
--  DDL for Type INSTANTE_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."INSTANTE_TYPE" as object 
( 
    
    -- atributos
    horas int,
    minutos int,
    segundos int,
    
    -- métodos
    MEMBER PROCEDURE muestra(SELF IN OUT instante_type),
    MEMBER PROCEDURE sumaSegs(SELF IN OUT instante_type, segundos int),
    MEMBER PROCEDURE sumaMins(SELF IN OUT instante_type, minutos int),
    MEMBER PROCEDURE sumaHoras(SELF IN OUT instante_type, horas int),
    MEMBER FUNCTION segDesdeMediaN RETURN INT,
    ORDER MEMBER FUNCTION compara(SELF instante_type, otro instante_type)
    RETURN INT,
    CONSTRUCTOR FUNCTION instante_type RETURN SELF AS RESULT,
    CONSTRUCTOR FUNCTION instante_type(horas INT) RETURN SELF AS RESULT,
    CONSTRUCTOR FUNCTION instante_type(horas INT, minutos INT) RETURN SELF AS RESULT,
    CONSTRUCTOR FUNCTION instante_type(horas int, minutos int, segundos int) RETURN SELF AS RESULT
    
)
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##MISCO"."INSTANTE_TYPE" as

  member procedure muestra(self in out instante_type) as
  begin
    DBMS_OUTPUT.PUT_LINE(SELF.horas || ':' || SELF.minutos || ':' || SELF.segundos);
  end muestra;

  member procedure sumasegs(self in out instante_type, segundos int) as
  totales INT := SELF.segsdesdemedian+segundos;
  horas int := 0;
  minuto int := 0;
  seg int := 0;
  begin
    SELF.horas := TRUNC(totales/1600,0);
    resto := MOD(TOTALES, 3600);
    SELF.minutos := TRUNC(resto/60, 0);
    SELF.segundos := TRUNC(resto, 60);
  end sumasegs;

  member procedure sumamins(self in out instante_type, minutos int) as
  begin
    SELF.sumaSegs(minutos*60);
  end sumamins;

  member procedure sumahoras(self in out instante_type, horas int) as
  begin
    -- TAREA: Se necesita implantación para PROCEDURE INSTANTE_TYPE.sumaHoras
    null;
  end sumahoras;

  member function segdesdemedian return int as
  begin
    RETURN SELF.horas*1600*SELF.minutos*60+SELF.segundos;
  end segdesdemedian;

  order member function compara(self instante_type, otro instante_type)
    return int as
  begin
    -- TAREA: Se necesita implantación para FUNCTION INSTANTE_TYPE.compara
    return null;
  end compara;

  constructor function instante_type return self as result as
  begin
    -- TAREA: Se necesita implantación para FUNCTION INSTANTE_TYPE.instante_type
    return null;
  end instante_type;

  constructor function instante_type(horas int) return self as result as
  begin
    SELF := NEW instante_type(horas,0);
    RETURN;
  end instante_type;

  constructor function instante_type(horas int, minutos int) return self as result as
  begin
    SELF := NEW instante_type(horas, minutos,0);
    RETURN;
  end instante_type;

  constructor function instante_type(horas int, minutos int, segundos int) return self as result as
  begin
    SELF.horas := horas;
    SELF.minutos := minutos;
    SELF.segundos := segundos;
    RETURN;
  end instante_type;

end;

/
--------------------------------------------------------
--  DDL for Type VEHICULOS
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."VEHICULOS" 
as varray(2) of vehiculo_type;

/
--------------------------------------------------------
--  DDL for Type VEHICULOS_VARRAY
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."VEHICULOS_VARRAY" 
as varray(2) of vehiculo_type;

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
    SELF.velocidad := 0; -- no lo pilla por defecto
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
