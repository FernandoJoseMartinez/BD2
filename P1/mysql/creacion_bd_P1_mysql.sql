/*
* Fichero de creación de la base de datos y el usuario específico
*/

DROP USER IF EXISTS ferjose;
DROP DATABASE IF EXISTS practica1_bd2;
CREATE USER 'ferjose'@'%' IDENTIFIED BY '1234';
CREATE DATABASE IF NOT EXISTS practica1_bd2;
GRANT ALL PRIVILEGES ON practica1_bd2.* TO 'ferjose'@'%';
FLUSH PRIVILEGES;
SET GLOBAL log_bin_trust_function_creators=1;
SET GLOBAL local_infile=1;