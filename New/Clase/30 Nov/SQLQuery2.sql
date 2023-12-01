USE PruebaG;
GO

CREATE ROLE db_r_w;
GO

-- que forme parte del db_datawriter y db_reader

ALTER ROLE db_datawriter
ADD MEMBER db_r_w;