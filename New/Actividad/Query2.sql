-- Creamos un nuevo login 
CREATE LOGIN login_admin
WITH PASSWORD = 'login_admin';
GO

-- Nos conectamos a la base de datos
USE ColladosBlanco_David_Actividad
GO

-- Creamos 2 nuevos usuarios con las condiciones que se nos piden
CREATE USER user_writer FOR LOGIN login1 WITH DEFAULT_SCHEMA = Esquema1 ;
GO

CREATE USER user_reader FOR LOGIN login2 WITH DEFAULT_SCHEMA = Esquema2;
GO

-- Nos conectamos de nuevo a la base
USE ColladosBlanco_David_Actividad
GO

-- Incluimos a user_reader en db_datareader
ALTER ROLE db_datareader
ADD MEMBER user_reader
GO

-- Incluimos a user_writer en db_datawriter
ALTER ROLE db_datawriter
ADD MEMBER user_writer
GO