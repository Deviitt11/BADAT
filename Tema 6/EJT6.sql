-- hiper bloque
BEGIN
    DBMS_OUTPUT.ENABLE;
    -- EJ 1.1
    DECLARE
        aux INT := 3;   
    BEGIN
        
        IF (MOD(aux,2)=0) THEN
            DBMS_OUTPUT.PUT_LINE('par');
        ELSE
            DBMS_OUTPUT.PUT_LINE('impar');
        END IF;
    END;
    
    -- 1.3
    DECLARE
        var INT := 15;
    BEGIN
        IF (MOD(var,3)=0 AND MOD(var,5)=0) THEN 
            DBMS_OUTPUT.PUT_LINE('FizzBuzz');
        ELSIF (MOD(var,3)=0) THEN
            DBMS_OUTPUT.PUT_LINE('Fizz');
        ELSIF (MOD(var,5)=0) THEN
            DBMS_OUTPUT.PUT_LINE('Buzz');
        END IF;
    END;
    
    -- 1.4
    DECLARE
        nota double(5) := 9.2;
    BEGIN
        CASE
        WHEN (nota BETWEEN 9 AND 10) THEN
            DBMS_OUTPUT.PUT_LINE('A');
        -- nota entre 0 y 9
        WHEN (nota >= 8) THEN
            DBMS_OUTPUT.PUT_LINE('B');
        WHEN (nota >= 7) THEN
            DBMS_OUTPUT.PUT_LINE('C');
        WHEN (nota >= 6) THEN
            DBMS_OUTPUT.PUT_LINE('D');
        ELSE -- por narices entre 0 y 6
            DBMS_OUTPUT.PUT_LINE('E');
        END CASE;
    END;
    
    -- 1.6
    DECLARE
        a float := 3;
        b float := 4.2;
    BEGIN
        IF (a < b) THEN
            DBMS_OUTPUT.PUT_LINE(a);
            DBMS_OUTPUT.PUT_LINE(b);
        ELSE
            DBMS_OUTPUT.PUT_LINE(b);
            DBMS_OUTPUT.PUT_LINE(a);
        END IF;
    END;
    
    -- 1.7
    DECLARE -- de mayor a menor
        a float := 3;
        b float := 4.2;
        c float := 5.3;
    BEGIN
        IF (a>b AND a>c) THEN -- a es la mayor
            DBMS_OUTPUT.PUT_LINE(a);
            IF(b > c) THEN
                DBMS_OUTPUT.PUT_LINE(b);
                DBMS_OUTPUT.PUT_LINE(c);
            ELSE
                DBMS_OUTPUT.PUT_LINE(b);
                DBMS_OUTPUT.PUT_LINE(a);
            END IF;
            
            -- a no es el mayor
            ELSIF (b>c) THEN
            DBMS_OUTPUT.PUT_LINE(b);
            IF(a > c) THEN
                    DBMS_OUTPUT.PUT_LINE(a);
                    DBMS_OUTPUT.PUT_LINE(c);
            ELSE
                    DBMS_OUTPUT.PUT_LINE(c);
                    DBMS_OUTPUT.PUT_LINE(a);
            END IF;
            
            -- ni a ni b
            ELSE
                DBMS_OUTPUT.PUT_LINE(c);
                IF(a>b) THEN
                    DBMS_OUTPUT.PUT_LINE(a);
                    DBMS_OUTPUT.PUT_LINE(b);
                ELSE
                    DBMS_OUTPUT.PUT_LINE(b);
                    DBMS_OUTPUT.PUT_LINE(a);
            END IF;
                
    END IF;
    
    END;
    
    -- 1.8
    DECLARE
        opcYo CHAR(1) := 'r';
        opcPC CHAR(1);
        intPC int := TRUNC(DBMS_RANDOM.VALUE(0, 2+1)); -- de 0 a 2
    BEGIN
        -- convierto la opción del pc a un texto
        CASE intPC
        WHEN 0 THEN
            opcPC := 'r';
        WHEN 1 THEN
            opcPC := 'p';
        ELSE 
            opcPC := 's';
        END CASE;
        
        -- COMBATES
        CASE
        WHEN (opcYo = opcPC) THEN
            DBMS_OUTPUT.PUT_LINE('Empate');
            -- yo piedra
        WHEN (opcYo = 'r') THEN
            IF(opcPC = 'p') THEN
                DBMS_OUTPUT.PUT_LINE('Gana PC');
            ELSE
                    DBMS_OUTPUT.PUT_LINE('Gano yo');
            END IF;
        WHEN (opcYo = 'p') THEN -- yo papel
            IF(opcPC = 's') THEN -- pc tijeras
                DBMS_OUTPUT.PUT_LINE('Gana PC');
            ELSE
                    DBMS_OUTPUT.PUT_LINE('Gano yo');
            END IF;
        ELSE -- yo tijeras
            IF(opcPC = 'r') THEN -- pc piedra
                DBMS_OUTPUT.PUT_LINE('Gana PC');
            ELSE
                    DBMS_OUTPUT.PUT_LINE('Gano yo');
            END IF;
        END CASE;
    END;
    
    -- 2.1
    BEGIN
        DBMS_OUTPUT.ENABLE;
        FOR i IN 1..10 LOOP
            DBMS_OUTPUT.PUT_LINE(i);
        END LOOP;
    END;
    
    -- 0 a 100 con while
    DECLARE
        i INT := 0;
    BEGIN
      DBMS_OUTPUT.ENABLE;
        WHILE (i<=100) LOOP
            IF (MOD(i,2)=0) THEN
                DBMS_OUTPUT.PUT_LINE(i);
            END IF;
            i := i+1;
        END LOOP;
    END;
    
    -- 2.3
    DECLARE
        aux INT := 3;
    BEGIN
        FOR i IN 1..10 LOOP
            DBMS_OUTPUT.PUT_LINE(aux || 'x' || i || '=' || aux*i);
        END LOOP;
    END;
    
    -- 2.4
    DECLARE
        texto VARCHAR2(50) := 'misco y tupu';
    BEGIN
        FOR i IN 1..LENGTH(texto) LOOP
            DBMS_OUTPUT.PUT_LINE(SUBSTRING(texto, i,1));
        END LOOP;
    END;
    
    -- 2.6
    DECLARE                             
        texto VARCHAR2(50) := 'ocsimmisco';
        palindromo BOOL := true;
        final INT := LENGTH(texto); --LENGTH(..)+1-i
    BEGIN
        FOR i IN 1..LENGTH(texto) LOOP
            IF (SUBSTR(texto, i, 1) <> SUBSTR(texto, final, 1) THEN
                palindromo := false;
            END IF;
            final := final-1;
        END LOOP;
        IF(palindromo) THEN
            DBMS_OUTPUT.PUT_LINE('Sí');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No');
        END IF;
    END;
    
    -- 
    DECLARE
        aux INT := 100000;
        primo BOOLEAN := true;
        i INT := 2;
    BEGIN
        while(i<aux AND primo) LOOP
        IF(MOD(aux,i)=0) THEN
            primo := false;
        END IF;
        i := i+1;
        
    
    END;
    
    BEGIN
        FOR fila IN(SELECT * FROM NUMEROS) LOOP
            IF(MOD(fila.valor, 2)=0) THEN
                INSERT INTO Numeros_pares VALUES(fila.valor);
            END IF;
        END LOOP;
    END;
    
    CREATE TABLE Numeros(
        VALOR INT
        ,CONSTRAINT INT FK_Numeros PRIMARY KEY (Valor)
    );
    
    CREATE TABLE Numeros_pares(
        VALOR INT
        ,CONSTRAINT INT FK_Numeros PRIMARY KEY (Valor)
    );
    
END;