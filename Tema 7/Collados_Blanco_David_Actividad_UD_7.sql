--------------------------------------------------------
-- Archivo creado  - domingo-mayo-12-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type GALLETA_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##COLLADOS_BLANCO_ACTIVIDAD_UD_7"."GALLETA_TYPE" AS OBJECT 
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
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##COLLADOS_BLANCO_ACTIVIDAD_UD_7"."GALLETA_TYPE" AS
    
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
    
    --SELF.nombre := nombre;
    --SELF.gramos_harina := gramos_harina;
    --SELF.cucharadas_azucar := cucharadas_azucar;
    --SELF.gramos_chocolate := gramos_chocolate;
    SELF := NEW galleta_type(nombre, gramos_harina, cucharadas_azucar, gramos_chocolate);
    
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
--  DDL for Sequence TARRO_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "C##COLLADOS_BLANCO_ACTIVIDAD_UD_7"."TARRO_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE  GLOBAL ;
--------------------------------------------------------
--  DDL for Table TARRO
--------------------------------------------------------

  CREATE TABLE "C##COLLADOS_BLANCO_ACTIVIDAD_UD_7"."TARRO" 
   (	"ID" NUMBER(*,0) GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOKEEP  NOSCALE , 
	"GALLETA_CAMPO" "C##COLLADOS_BLANCO_ACTIVIDAD_UD_7"."GALLETA_TYPE" 
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
REM INSERTING into C##COLLADOS_BLANCO_ACTIVIDAD_UD_7.TARRO
SET DEFINE OFF;
--------------------------------------------------------
--  Constraints for Table TARRO
--------------------------------------------------------

  ALTER TABLE "C##COLLADOS_BLANCO_ACTIVIDAD_UD_7"."TARRO" MODIFY ("ID" NOT NULL ENABLE);
