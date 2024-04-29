DECLARE
    Ataque1 Ataque_type := NEW Ataque_type('Látigo cepa');
    Ataque2 Ataque_type := NEW Ataque_type('Impactrueno', 6);
BEGIN
    DBMS_OUTPUT.ENABLE;
    -- atributos públicos
    DBMS_OUTPUT.PUT_LINE(ataque1.daño); -- 5
    ataque2.daño := 40; -- se pueden modificar sin setter
    DBMS_OUTPUT.PUT_LINE(ataque2.daño); -- 40
    DBMS_OUTPUT.PUT_LINE(ataque1.daño); -- 5
    DBMS_OUTPUT.PUT_LINE(ataque1.getNombre()); -- látigo cepa
    DBMS_OUTPUT.PUT_LINE(ataque2.getNombre); -- impactrueno
    -- DBMS_OUTPUT.PUT_LINE(ataque2.muestra()); 
    ataque2.muestra();
    IF(ataque1<ataque2) THEN
        DBMS_OUTPUT.PUT_LINE('ataque1 menor');
    ELSE
        DBMS_OUTPUT.PUT_LINE('ataque2 menor');
    END IF;
END;