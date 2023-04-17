/*
* Fichero de creación del usuario profesor con contraseña rubenp
*/

DROP USER IF EXISTS profesor;
CREATE USER profesor WITH PASSWORD 'rubenp';
GRANT CONNECT ON DATABASE practica1_bd2 TO profesor;
GRANT USAGE ON SCHEMA public TO profesor;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO profesor;