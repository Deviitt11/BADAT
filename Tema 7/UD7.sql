--------------------------------------------------------
-- Archivo creado  - lunes-mayo-13-2024   
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
  end círculo_type;

end;

/
--------------------------------------------------------
--  DDL for Type GALLETA_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."GALLETA_TYPE" AS OBJECT 
( 

    -- atributos
    nombre VARCHAR(50),
    gramos_harina FLOAT,
    cucharadas_azucar INT,
    gramos_chocolate FLOAT,
    
    -- métodos
    MEMBER PROCEDURE muestra(SELF galleta_type),
    MEMBER FUNCTION precio(precio_harina FLOAT, precio_azucar FLOAT, precio_chocolate FLOAT) RETURN FLOAT,
    MAP MEMBER FUNCTION masaTotal RETURN FLOAT,
    
    -- constructores
    CONSTRUCTOR FUNCTION galleta_type RETURN SELF AS RESULT,
    CONSTRUCTOR FUNCTION galleta_type(nombre VARCHAR2, gramos_harina FLOAT, cucharadas_azucar INT, gramos_chocolate FLOAT) RETURN SELF AS RESULT,
    CONSTRUCTOR FUNCTION galleta_type(nombre VARCHAR2, gramos_harina FLOAT, cucharadas_azucar INT) RETURN SELF AS RESULT
)
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##MISCO"."GALLETA_TYPE" AS
    
  -- FUNCIONES DEL TIPO  
    
  MEMBER PROCEDURE muestra(SELF galleta_type) AS
  BEGIN
    -- imprimo por salida todos los atributos
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || SELF.nombre || ' , gramos de harina: ' || SELF.gramos_harina || ' , cucharadas de azúcar: ' || SELF.cucharadas_azucar || ' , gramos de chocolate: ' || SELF.gramos_chocolate);
  END muestra;

  MEMBER FUNCTION precio(precio_harina FLOAT, precio_azucar FLOAT, precio_chocolate FLOAT) RETURN FLOAT AS
    -- variable para el precio total
    precio_total FLOAT;
  BEGIN
    -- calculo el precio total como la suma de todos los ingredientes
    precio_total := precio_harina + precio_azucar + precio_chocolate;
    RETURN precio_total;
  END precio;

  MAP MEMBER FUNCTION masaTotal RETURN FLOAT AS
    -- variable para la masa total
    masa_total FLOAT;
  BEGIN
    -- calculo la masa total como la suma los componentes
    masa_total := SELF.gramos_harina + (SELF.cucharadas_azucar * 15) + SELF.gramos_chocolate;
    RETURN masa_total;
  END masaTotal;


  -- CONSTRUCTORES 

  CONSTRUCTOR FUNCTION galleta_type RETURN SELF AS RESULT AS
  BEGIN
    -- constructor por defecto, vacío, sin args

    -- inicializa el nombre a "galletas de espelta"
    --SELF.nombre := 'galletas de espleta';
    -- gramos de harina a 10
    --SELF.gramos_harina := 10;
    -- resto de valores a 0
    --SELF.cucharadas_azucar := 0;
    --SELF.gramos_chocolate := 0;
    SELF := NEW galleta_type('galletas de espleta', 10, 0, 0);

    -- un return para que no me llore
    RETURN;
  END galleta_type;

  CONSTRUCTOR FUNCTION galleta_type(nombre VARCHAR2, gramos_harina FLOAT, cucharadas_azucar INT, gramos_chocolate FLOAT) 
  RETURN SELF AS RESULT AS
  BEGIN
    -- constructor general, recibe de argumentos un valor por cada atributos

    SELF.nombre := nombre;
    SELF.gramos_harina := gramos_harina;
    SELF.cucharadas_azucar := cucharadas_azucar;
    SELF.gramos_chocolate := gramos_chocolate;
    --SELF := NEW galleta_type(nombre, gramos_harina, cucharadas_azucar, gramos_chocolate);

    -- un return para que no me llore
    RETURN;
  END galleta_type;

  CONSTRUCTOR FUNCTION galleta_type(nombre VARCHAR2, gramos_harina FLOAT, cucharadas_azucar INT) 
  RETURN SELF AS RESULT AS
  BEGIN
    -- constructor que recibe de todo menos los gramos de chocolate, que asigna el valor 0 por defecto a este atri

    --SELF.nombre := nombre;
    --SELF.gramos_harina := gramos_harina;
    --SELF.cucharadas_azucar := cucharadas_azucar;
    --SELF.gramos_chocolate := 0;
    SELF := NEW galleta_type(nombre, gramos_harina, cucharadas_azucar, 0);

    -- un return para que no me llore
    RETURN;
  END galleta_type;

END;

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
    SELF.minutos = TRUNC(resto/60, 0);
    SELF.segundos := TRUNC(resto, 60);
    null;
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
--  DDL for Type PASSWORD_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."PASSWORD_TYPE" as object 
( 
    
    -- atributo
    contraseña VARCHAR2(50),
    
    -- métodos
    MEMBER FUNCTION cuentaCaracteresNOEspeciales RETURN INT,
    MEMBER FUNCTION esCaracterNoEspecial (caracter VARCHAR2) RETURN BOOLEAN,
    MEMBER FUNCTION cuentaDigitos RETURN INT,
    MEMBER FUNCTION esDigito(caracter VARCHAR2) RETURN BOOLEAN,
    MEMBER FUNCTION cuentaCaracteresEspeciales RETURN INT,
    MEMBER FUNCTION esCaracterEspecial (caracter VARCHAR2) RETURN BOOLEAN,
    MEMBER FUNCTION generaCaracterNoEspecial RETURN VARCHAR2,
    MEMBER FUNCTION generaCaracterDigito RETURN VARCHAR2,
    MEMBER FUNCTION generaCaracterEspecial RETURN VARCHAR2,
    MAP MEMBER FUNCTION esSegura RETURN FLOAT,
    STATIC FUNCTION generador RETURN VARCHAR2,
    CONSTRUCTOR FUNCTION password_type(contraseña VARCHAR2) RETURN SELF AS RESULT
    
)
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##MISCO"."PASSWORD_TYPE" as

  member function cuentacaracteresnoespeciales return int as
    contador int := 0;
    caracter VARCHAR2(50);
  begin
     FOR i IN 1..LENGTH(SELF.contraseña) LOOP
        caracter := SUBSTR(SELF.contraseña, i, 1);
        if(escaracternoespecial(caracter)) THEN
            contador := contador+1;
        END IF;
     END LOOP;
  end cuentacaracteresnoespeciales;

  member function escaracternoespecial (caracter varchar2) return boolean as
  begin
    -- mayus
    IF ASCII(caracter) BETWEEN 65 AND 90 THEN
        RETURN true;
    END IF;
    
    -- minus
    IF (ASCII(caracter)>=97 AND ASCII(caracter)<= 122) THEN
        RETURN true;
    END IF;
    return false;
  end escaracternoespecial;

  member function cuentadigitos return int as
    contador int := 0;
    caracter VARCHAR2(50);
  begin
     FOR i IN 1..LENGTH(SELF.contraseña) LOOP
        caracter := SUBSTR(SELF.contraseña, i, 1);
        if(esdigito(caracter)) THEN
            contador := contador+1;
        END IF;
     END LOOP;
  end cuentadigitos;

  member function esdigito(caracter varchar2) return boolean as
  begin
    -- digitos del 49 al 57
    RETURN ASCII(caracter) >= 49 AND ASCII(caracter) <= 57;
  end esdigito;

  member function cuentacaracteresespeciales return int as
   contador int := 0;
    caracter VARCHAR2(50);
  begin
     FOR i IN 1..LENGTH(SELF.contraseña) LOOP
        caracter := SUBSTR(SELF.contraseña, i, 1);
        if(escaracterespecial(caracter)) THEN
            contador := contador+1;
        END IF;
     END LOOP;
  end cuentacaracteresespeciales;

  member function escaracterespecial (caracter varchar2) return boolean as
  begin
    -- TAREA: Se necesita implantación para FUNCTION PASSWORD_TYPE.esCaracterEspecial
    return NOT(escaracternoespecial(caracter)) AND NOT (esdigito(caracter));
  end escaracterespecial;

  member function generacaracternoespecial return varchar2 as
    posicion int;
  begin
    IF(TRUNC(DBMS_RANDOM.VALUE(1,2+1))=1) THEN
        -- mayus
        posicion := TRUNC(DBMS_RANDOM.VALUE(65, 90+1));
    ELSE
        -- minus
        posicion := TRUNC(DBMS_RANDOM.VALUE(97, 122+1));
    END IF;
    return CHR(posicion); -- devuelve el caracter asociado
  end generacaracternoespecial;

  member function generacaracterdigito return varchar2 as
    posicion INT := TRUNC(DBMS_RANDOM.VALUE(48, 57+1));
  begin
        RETURN CHR(posicion);
    return null;
  end generacaracterdigito;

  member function generacaracterespecial return varchar2 as
    posicion int := TRUNC(DBMS_RANDOM.VALUE(1, 256+1));
  begin
        WHILE(NOT(escaracterespecial(ASCII(posicion)))) LOOP
            posicion := TRUNC(DBMS_RANDOM.VALUE(1, 256+1));
        END LOOP;
    return null;
  end generacaracterespecial;

  map member function essegura return float as
  begin
    -- TAREA: Se necesita implantación para FUNCTION PASSWORD_TYPE.esSegura
    return null;
  end essegura;

  static function generador return varchar2 as
  begin
    -- TAREA: Se necesita implantación para FUNCTION PASSWORD_TYPE.generador
    return null;
  end generador;

  constructor function password_type(contraseña varchar2) return self as result as
  begin
    SELF.contraseña := contraseña;
    return;
  end password_type;

end;

/
--------------------------------------------------------
--  DDL for Type SELECCIONADOR_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."SELECCIONADOR_TYPE" as object 
( 

    -- atributos
    opciones v_varchar,
    
    -- métodos
    MEMBER FUNCTION respuesta RETURN VARCHAR2,
    CONSTRUCTOR FUNCTION seleccionador_type(vector v_varchar)
    RETURN SELF AS RESULT
)
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##MISCO"."SELECCIONADOR_TYPE" as

  member function respuesta return varchar2 as
    posicion INT;
  begin
    -- elementos: de 1 a count
    posicion := TRUNC(DBMS_RANDOM.VALUE(1, SELF.opciones.COUNT()+1));
    RETURN SELF.opciones(posicion);
  end respuesta;

  constructor function seleccionador_type(vector v_varchar)
    return self as result as
  begin
    SELF.opciones := vector;
    RETURN;
  end seleccionador_type;

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
--  DDL for Type V_VARCHAR
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."V_VARCHAR" IS VARRAY(50) OF VARCHAR2(50);

/
--------------------------------------------------------
--  DDL for Sequence TARRO_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "C##MISCO"."TARRO_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
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
--------------------------------------------------------
--  DDL for Table TARRO
--------------------------------------------------------

  CREATE TABLE "C##MISCO"."TARRO" 
   (	"ID" NUMBER(*,0) GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"GALLETA_CAMPO" "C##MISCO"."GALLETA_TYPE" 
   ) SEGMENT CREATION IMMEDIATE 
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
REM INSERTING into C##MISCO.TARRO
SET DEFINE OFF;
Insert into C##MISCO.TARRO (ID,GALLETA_CAMPO) values ('1',C##MISCO.GALLETA_TYPE('galletas de espleta', 10, 0, 0));
Insert into C##MISCO.TARRO (ID,GALLETA_CAMPO) values ('2',C##MISCO.GALLETA_TYPE('Galletas de canarios', 20, 5, 0));
Insert into C##MISCO.TARRO (ID,GALLETA_CAMPO) values ('3',C##MISCO.GALLETA_TYPE('Galletas pastosas', 15, 3, 0));
--------------------------------------------------------
--  Constraints for Table TARRO
--------------------------------------------------------

  ALTER TABLE "C##MISCO"."TARRO" MODIFY ("ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CIRCULO_TABLE
--------------------------------------------------------

  ALTER TABLE "C##MISCO"."CIRCULO_TABLE" ADD UNIQUE ("SYS_NC_OID$") RELY
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
