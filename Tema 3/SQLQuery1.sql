-- Creo nuevo login
CREATE LOGIN login2
WITH PASSWORD = 'login2';
-- (misma contraseña que login)
GO
/* quiero crear un usuario
en la base de datos de Comandos*/
USE Comandos;
/* hago un usuario ASOCIADO PARA
el login */
CREATE USER user2
FOR LOGIN login2;
GO