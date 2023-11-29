/*Quiero hace un nuevo rol 
en la base de datos de Comandos*/
USE Comandos; -- me conecto a Comandos
GO

CREATE ROLE db_reader_writer
GO

/*user2 forma parte de rol
Altero el rol para añadir al usuario */
ALTER ROLE db_reader_writer
ADD MEMBER user2;
GO

-- reader_writer forma parte de db_reader y db_writer
ALTER ROLE db_datareader
ADD MEMBER db_reader_writer;
GO

ALTER ROLE db_datawriter
ADD MEMBER db_reader_writer;
GO
