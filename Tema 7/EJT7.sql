--------------------------------------------------------
-- Archivo creado  - viernes-mayo-17-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type ATAQUE_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."ATAQUE_TYPE" as object 
( 
    -- atributos cuentan como p�blicos (como campos en una tabla)
    nombre VARCHAR2(50),
    da�o INT,
    
    -- m�todos no est�ticos: MEMBER
    -- todos los m�todos tienen como primer argumento
    -- impl�cito SELF (como el this del objeto)
    MEMBER FUNCTION getNombre RETURN VARCHAR2,
    MEMBER PROCEDURE muestra(SELF ataque_type)
    -- funci�n de tipo MAP para comparar
    , MAP MEMBER FUNCTION getDa�o RETURN INT
    -- MEMBER PROCEDURE muestra
    -- constructores
    -- uno con un par�metro por atributo
    , CONSTRUCTOR FUNCTION Ataque_type(nombre VARCHAR2, da�o INT)
        RETURN SELF AS RESULT
    -- con el nombre y da�o 5
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

  constructor function ataque_type(nombre varchar2, da�o int)
        return self as result as
  begin
    SELF.nombre := nombre;
    SELF.da�o := da�o;
    return;
  end ataque_type;

  constructor function ataque_type(nombre varchar2)
        return self as result as
  begin
    -- SELF := ataque_type(nombre,2)
    SELF.nombre := nombre;
    SELF.da�o := 5; -- patatas
    return;
  end ataque_type;

  map member function getda�o return int as
  begin
    -- TAREA: Se necesita implantaci�n para FUNCTION ATAQUE_TYPE.getDa�o
    return SELF.Da�o;
  end getda�o;

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
    -- TAREA: Se necesita implantaci�n para PROCEDURE BOLA_TYPE.muestra
    null;
  end muestra;

  member procedure golpea(self in out bola_type, otro bola_type) as
  begin
    -- TAREA: Se necesita implantaci�n para PROCEDURE BOLA_TYPE.golpea
    null;
  end golpea;

  constructor function bola_type(nombre varchar2, velocidad int)
    return self as result as
  begin
    -- TAREA: Se necesita implantaci�n para FUNCTION BOLA_TYPE.bola_type
    return null;
  end bola_type;

  constructor function bola_type(nombre varchar2)
    return self as result as
  begin
    -- TAREA: Se necesita implantaci�n para FUNCTION BOLA_TYPE.bola_type
    return null;
  end bola_type;

end;

/
--------------------------------------------------------
--  DDL for Type C�RCULO_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."C�RCULO_TYPE" as object 
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
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##MISCO"."C�RCULO_TYPE" as

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
--------------------------------------------------------
--  DDL for Type CUENTA_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."CUENTA_TYPE" as object 
( 
    
    id INT,
    saldo FLOAT,
    
    MEMBER PROCEDURE muestra(SELF IN OUT cuenta_type),
    MEMBER PROCEDURE ingresa(SELF IN OUT cuenta_type, cantidad FLOAT),
    MEMBER PROCEDURE retira(SELF IN OUT cuenta_type, cantidad FLOAT),
    MEMBER PROCEDURE transferencia(SELF IN OUT cuenta_Type, otra cuenta_type, cantidad FLOAT),
    CONSTRUCTOR FUNCTION cuenta_type(id INT) RETURN SELF AS RESULT,
    CONSTRUCTOR FUNCTION cuenta_type(id INT, saldo FLOAT) RETURN SELF AS RESULT
)
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##MISCO"."CUENTA_TYPE" as

  member procedure muestra(self in out cuenta_type) as
  begin
    SYSO.println('' || SELF.id || ' con ' || SELF.saldo || '�');
  end muestra;

  member procedure ingresa(self in out cuenta_type, cantidad float) as
  begin
    SELF.saldo := SELF.saldo + cantidad;
  end ingresa;

  member procedure retira(self in out cuenta_type, cantidad float) as
  begin
    ingresa(-cantidad);
  end retira;

  member procedure transferencia(self in out cuenta_type, otra IN OUT cuenta_type, cantidad float) as
  begin
    SELF.retira(cantidad);
    otra.ingresa(cantidad);
    NULL;
  end transferencia;

  constructor function cuenta_type(id int) return self as result as
  begin
    -- TAREA: Se necesita implantaci�n para FUNCTION CUENTA_TYPE.cuenta_type
    return null;
  end cuenta_type;

  constructor function cuenta_type(id int, saldo float) return self as result as
  begin
    -- TAREA: Se necesita implantaci�n para FUNCTION CUENTA_TYPE.cuenta_type
    return null;
  end cuenta_type;

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
    
    -- m�todos
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
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || SELF.nombre || ' , gramos de harina: ' || SELF.gramos_harina || ' , cucharadas de az�car: ' || SELF.cucharadas_azucar || ' , gramos de chocolate: ' || SELF.gramos_chocolate);
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
    -- constructor por defecto, vac�o, sin args

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
    
    -- m�todos
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
    -- TAREA: Se necesita implantaci�n para PROCEDURE INSTANTE_TYPE.sumaHoras
    null;
  end sumahoras;

  member function segdesdemedian return int as
  begin
    RETURN SELF.horas*1600*SELF.minutos*60+SELF.segundos;
  end segdesdemedian;

  order member function compara(self instante_type, otro instante_type)
    return int as
  begin
    -- TAREA: Se necesita implantaci�n para FUNCTION INSTANTE_TYPE.compara
    return null;
  end compara;

  constructor function instante_type return self as result as
  begin
    -- TAREA: Se necesita implantaci�n para FUNCTION INSTANTE_TYPE.instante_type
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

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."PASSWORD_TYPE" AS OBJECT 
( 
    -- atributo
    contrase�a VARCHAR2(50)
    -- m�todos
    ,MEMBER FUNCTION cuentaCaracteresNoEspeciales RETURN INT
    ,STATIC FUNCTION esCaracterNoEspecial(caracter VARCHAR2) RETURN BOOLEAN
    ,MEMBER FUNCTION cuentaD�gitos RETURN INT
    ,STATIC FUNCTION esD�gito(caracter VARCHAR2) RETURN BOOLEAN
    ,MEMBER FUNCTION cuentaCaracteresEspeciales RETURN INT
    ,STATIC FUNCTION esCaracterEspecial(caracter VARCHAR2) RETURN BOOLEAN
    ,STATIC FUNCTION generaCaracterNoEspecial RETURN VARCHAR2
    ,STATIC FUNCTION generaCaracterD�gito RETURN VARCHAR2
    ,STATIC FUNCTION generaCaracterEspecial RETURN VARCHAR2
    ,MAP MEMBER FUNCTION esSEGURA RETURN FLOAT
    ,STATIC FUNCTION generador RETURN VARCHAR2
    ,CONSTRUCTOR FUNCTION Password_type (contrase�a VARCHAR2)
    RETURN SELF AS RESULT
)
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##MISCO"."PASSWORD_TYPE" AS

  MEMBER FUNCTION cuentaCaracteresNoEspeciales RETURN INT AS
  contador INT := 0;
  caracter VARCHAR2(50);
  BEGIN
    FOR i IN 1..LENGTH(SELF.contrase�a) LOOP
        caracter := SUBSTR(SELF.contrase�a, i, 1);
        IF (PASSWORD_TYPE.esCaracterNoEspecial(caracter)) THEN
            contador := contador+1;
        END IF;
    END LOOP;
    RETURN contador;
  END cuentaCaracteresNoEspeciales;

  STATIC FUNCTION esCaracterNoEspecial(caracter VARCHAR2) RETURN BOOLEAN AS
  BEGIN
    -- may�sculas: ASCII de 65 a 90
    IF ASCII(caracter) BETWEEN 65 AND 90 THEN
        RETURN true;
    END IF;
    -- min�sculas: ASCII de 97 a 122
    IF ASCII(caracter)>=97 AND ASCII(caracter)<=122 THEN
        RETURN true;
    END IF;
    RETURN false;
  END esCaracterNoEspecial;

  MEMBER FUNCTION cuentaD�gitos RETURN INT AS
  contador INT := 0;
  caracter VARCHAR2(50);
  BEGIN
    FOR i IN 1..LENGTH(SELF.contrase�a) LOOP
        caracter := SUBSTR(SELF.contrase�a, i, 1);
        IF (PASSWORD_TYPE.esD�gito(caracter)) THEN
            contador := contador+1;
        END IF;
    END LOOP;
    RETURN contador;
  END cuentaD�gitos;

  STATIC FUNCTION esD�gito(caracter VARCHAR2) RETURN BOOLEAN AS
  BEGIN
    -- d�gitos: del 48 al 57
    RETURN ASCII(caracter)>=48 AND ASCII(caracter)<=57;
  END esD�gito;

  MEMBER FUNCTION cuentaCaracteresEspeciales RETURN INT AS
  contador INT := 0;
  caracter VARCHAR2(50);
  BEGIN
    FOR i IN 1..LENGTH(SELF.contrase�a) LOOP
        caracter := SUBSTR(SELF.contrase�a, i, 1);
        IF (PASSWORD_TYPE.esCaracterEspecial(caracter)) THEN
            contador := contador+1;
        END IF;
    END LOOP;
    RETURN contador;
  END cuentaCaracteresEspeciales;

  STATIC FUNCTION esCaracterEspecial(caracter VARCHAR2) RETURN BOOLEAN AS
  BEGIN
    -- no NoEspecial y No d�gito
    RETURN NOT(esCaracterNoEspecial(caracter)) AND NOT(esD�gito(caracter));
  END esCaracterEspecial;

  STATIC FUNCTION generaCaracterNoEspecial RETURN VARCHAR2 AS
  posici�n INT; -- en la tabla ASCII
  BEGIN
    IF (TRUNC(DBMS_RANDOM.VALUE(1, 2+1))=1) THEN -- n�mero aleatorio: 1 � 2
        --may�scula
        posici�n := TRUNC(DBMS_RANDOM.VALUE(65, 90+1)); -- 65 y 90
    ELSE -- min�scula
        posici�n := TRUNC(DBMS_RANDOM.VALUE(97, 122+1)); -- 97 y 122
    END IF;
    RETURN CHR(posici�n); -- devuelve el car�cter asociado
  END generaCaracterNoEspecial;

  STATIC FUNCTION generaCaracterD�gito RETURN VARCHAR2 AS
  posici�n INT := TRUNC(DBMS_RANDOM.VALUE(48, 57+1));
  BEGIN
    RETURN CHR(posici�n);
  END generaCaracterD�gito;

  STATIC FUNCTION generaCaracterEspecial RETURN VARCHAR2 AS
  posici�n INT := TRUNC(DBMS_RANDOM.VALUE(1, 128+1));
  BEGIN
    -- mientras NO sea especial..
    WHILE(NOT(esCaracterEspecial(CHR(posici�n)))) LOOP
         posici�n := TRUNC(DBMS_RANDOM.VALUE(1, 128+1));
    END LOOP;
    RETURN CHR(posici�n);
  END generaCaracterEspecial;

  MAP MEMBER FUNCTION esSEGURA RETURN FLOAT AS
    suma FLOAT := 0;
  BEGIN
    -- longitud de al menos 8 caracteres
    IF (LENGTH(SELF.contrase�a)<8) THEN
        suma := suma + 10*LENGTH(SELF.contrase�a)/8;
    ELSE
        suma := suma+10;
    END IF;
    IF (SELF.cuentaCaracteresEspeciales<3) THEN
        suma := suma + 30*SELF.cuentaCaracteresEspeciales/3;
    ELSE 
        suma := suma + 30;
    END IF;
    IF (SELF.cuentaD�gitos<4) THEN
        suma := suma + 30*SELF.cuentaD�gitos/4;
    ELSE 
        suma := suma + 30;
    END IF;
    IF (SELF.cuentaCaracteresNoEspeciales<2) THEN
        suma := suma + 30*SELF.cuentaCaracteresNoEspeciales/2;
    ELSE 
        suma := suma + 30;
    END IF;
    RETURN suma;
  END esSEGURA;

  STATIC FUNCTION generador RETURN VARCHAR2 AS
    cadena VARCHAR2(50) := '';
    longitud INT;
    opc INT;
  BEGIN
    longitud := TRUNC(DBMS_RANDOM.VALUE(8, 15+1)); -- entre 8 y 15
    -- bucle para meter longitud caracteres
    FOR i IN 1..longitud LOOP
        opc := TRUNC(DBMS_RANDOM.VALUE(1, 3+1)); -- hay 3 opciones
        CASE opc
        WHEN 1 THEN -- no especial
            cadena := cadena || generaCaracterNoEspecial;
        WHEN 2 THEN -- d�gito
            cadena := cadena || generaCaracterD�gito;
        ELSE -- especial
            cadena := cadena || generaCaracterEspecial;
        END CASE;
    END LOOP;
    RETURN cadena;
  END generador;

  CONSTRUCTOR FUNCTION Password_type (contrase�a VARCHAR2)
    RETURN SELF AS RESULT AS
  BEGIN
    SELF.contrase�a := contrase�a;
    RETURN;
  END Password_type;

END;

/
--------------------------------------------------------
--  DDL for Type SELECCIONADOR_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."SELECCIONADOR_TYPE" as object 
( 

    -- atributos
    opciones v_varchar,
    
    -- m�todos
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
--  DDL for Type SYSO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."SYSO" as object 
( 

    mistu FLOAT, -- me fuerza a tener atributos
    STATIC PROCEDURE printLn,
    STATIC PROCEDURE printLn(texto VARCHAR2),
    STATIC PROCEDURE printLn(numero NUMBER),
    STATIC PROCEDURE printLn(bool BOOLEAN)
    
)
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##MISCO"."SYSO" as

  static procedure printLn AS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('');
  END;
  
  static procedure println(texto varchar2) as
  begin
    DBMS_OUTPUT.PUT_LINE(texto);
  end println;

  static procedure println(numero number) as
  begin
    DBMS_OUTPUT.PUT_LINE(numero);
  end println;

  static procedure println(bool boolean) as
  begin
    if (bool) THEN
        DBMS_OUTPUT.PUT_LINE('true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('false');
    END IF;
  end println;

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
    -- m�todos
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

  CREATE TABLE "C##MISCO"."CIRCULO_TABLE" OF "C##MISCO"."C�RCULO_TYPE" 
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
