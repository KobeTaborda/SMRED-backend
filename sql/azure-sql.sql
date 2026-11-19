-- Usuario de la aplicación en Azure SQL. Ejecútalo en el Editor de consultas del portal,
-- conectado a la base smred con el administrador del servidor.
-- Cambia la contraseña antes de ejecutarlo y no la guardes en este archivo.
-- Es un usuario "contenido": solo existe dentro de esta base y no tiene permisos en el servidor.

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'smred_app')
BEGIN
    CREATE USER [smred_app] WITH PASSWORD = N'ESCRIBE-AQUI-LA-CONTRASEÑA';
END
GO

-- db_owner solo sobre ESTA base: las migraciones de Knex necesitan crear tablas.
ALTER ROLE db_owner ADD MEMBER [smred_app];
GO
