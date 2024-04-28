--------------------------------------------------------
-- Archivo creado  - viernes-abril-26-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Type ATAQUE_TYPE
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE TYPE "C##MISCO"."ATAQUE_TYPE" as object 
( 
    -- atributos cuentan como p�blicos (como campos en una tabla)
    nombre VARCHAR2(10),
    da�o INT,
    
    -- m�todos no est�ticos: MEMBER
    -- todos los m�todos tienen como primer argumento
    -- impl�cito SELF (como el this del objeto)
    MEMBER FUNCTION getNombre RETURN VARCHAR2,
    MEMBER PROCEDURE muestra(SELF ataque_type)
    -- MEMBER PROCEDURE muestra
    
)
/
CREATE OR REPLACE EDITIONABLE TYPE BODY "C##MISCO"."ATAQUE_TYPE" as

  member function getnombre return varchar2 as
  begin
    -- TAREA: Se necesita implantaci�n para FUNCTION ATAQUE_TYPE.getNombre
    return SELF.nombre; -- return this.nombre
  end getnombre;

  member procedure muestra(self ataque_type) as
  begin
    -- TAREA: Se necesita implantaci�n para PROCEDURE ATAQUE_TYPE.muestra
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('Ataque ' || SELF.nombre || ' son' || da�o || ' puntos de da�o');
  end muestra;

end;

/