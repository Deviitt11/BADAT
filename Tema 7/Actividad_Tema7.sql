-- creo el user
-- CREATE USER C##Collados_Blanco_Actividad_UD_7 IDENTIFIED BY admin;
-- GRANT ALL PRIVILEGES TO C##Collados_Blanco_Actividad_UD_7;

-- apartado 2.b, EJ2
DECLARE
    -- creo tres galletas 
    g1 galleta_type := NEW galleta_type();
    g2 galleta_type := NEW galleta_type('Galletas de canarios', 20, 5, 0);
    g3 galleta_type := NEW galleta_type('Galletas pastosas', 15, 3);
BEGIN
    -- y las inserto a pinchu en la tabla
    DELETE FROM tarro;
    INSERT INTO tarro (galleta_campo) VALUES (g1);
    DBMS_OUTPUT.PUT_LINE('Galleta 1 insertada correctamente');
    INSERT INTO tarro (galleta_campo) VALUES (g2);
    DBMS_OUTPUT.PUT_LINE('Galleta 2 insertada correctamente');
    INSERT INTO tarro (galleta_campo) VALUES (g3);
    DBMS_OUTPUT.PUT_LINE('Galleta 3 insertada correctamente');
    
    -- pruebo métodos
    g1.muestra();
    g2.muestra();
    g3.muestra();
    
    DBMS_OUTPUT.PUT_LINE('Precio galleta 1: ' || g1.precio(5.17, 7.25, 10.0) || ' euros');
    DBMS_OUTPUT.PUT_LINE('Precio galleta 2: ' || g2.precio(2.33, 4.20, 8.8) || ' euros');
    DBMS_OUTPUT.PUT_LINE('Precio galleta 3: ' || g3.precio(1.40, 2.00, 3.50) || ' euros');
    
    DBMS_OUTPUT.PUT_LINE('Masa total galleta 1: ' || g1.masatotal() || ' gramos');
    DBMS_OUTPUT.PUT_LINE('Masa total galleta 2: ' || g2.masatotal() || ' gramos');
    DBMS_OUTPUT.PUT_LINE('Masa total galleta 3: ' || g3.masatotal() || ' gramos');
END;
/

