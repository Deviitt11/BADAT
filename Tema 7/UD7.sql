--------------------------------------------------------
-- Archivo creado  - viernes-abril-26-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type ATAQUE_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."ATAQUE_TYPE" as object 
( 
    -- atributos cuentan como públicos (como campos en una tabla)
    nombre VARCHAR2(10),
    daño INT,
    
    -- métodos no estáticos: MEMBER
    -- todos los métodos tienen como primer argumento
    -- implícito SELF (como el this del objeto)
    MEMBER FUNCTION getNombre RETURN VARCHAR2,
    MEMBER PROCEDURE muestra(SELF ataque_type)
    -- MEMBER PROCEDURE muestra
    
)
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##MISCO"."ATAQUE_TYPE" as

  member function getnombre return varchar2 as
  begin
    -- TAREA: Se necesita implantación para FUNCTION ATAQUE_TYPE.getNombre
    return SELF.nombre; -- return this.nombre
  end getnombre;

  member procedure muestra(self ataque_type) as
  begin
    -- TAREA: Se necesita implantación para PROCEDURE ATAQUE_TYPE.muestra
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('Ataque ' || SELF.nombre || ' son' || daño || ' puntos de daño');
  end muestra;

end;
/

create or replace type ataque_type as object 
( 
    -- atributos cuentan como públicos (como campos en una tabla)
    nombre VARCHAR2(10),
    daño INT,
    
    -- métodos no estáticos: MEMBER
    -- todos los métodos tienen como primer argumento
    -- implícito SELF (como el this del objeto)
    MEMBER FUNCTION getNombre RETURN VARCHAR2,
    MEMBER PROCEDURE muestra(SELF ataque_type)
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

-- CUERPO
create or replace
type body ataque_type as

  member function getnombre return varchar2 as
  begin
    -- TAREA: Se necesita implantación para FUNCTION ATAQUE_TYPE.getNombre
    return null;
  end getnombre;

  member procedure muestra(self ataque_type) as
  begin
    -- TAREA: Se necesita implantación para PROCEDURE ATAQUE_TYPE.muestra
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

end;
/



