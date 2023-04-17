/*
* Fichero de creación de la base de datos y el usuario específico
*/

SELECT 
    pg_terminate_backend(pid) 
FROM 
    pg_stat_activity 
WHERE 
    pid <> pg_backend_pid()
    AND datname = 'practica1_bd2';

DROP USER IF EXISTS ferjose;
DROP DATABASE IF EXISTS practica1_bd2;
CREATE USER ferjose WITH PASSWORD '1234';
CREATE DATABASE practica1_bd2 WITH OWNER ferjose;
GRANT all privileges on database practica1_bd2 to ferjose;
GRANT pg_read_server_files TO ferjose;