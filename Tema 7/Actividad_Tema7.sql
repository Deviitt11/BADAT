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
    INSERT INTO tarro (galleta_campo) VALUES (g2);
    INSERT INTO tarro (galleta_campo) VALUES (g3);
END;
/

