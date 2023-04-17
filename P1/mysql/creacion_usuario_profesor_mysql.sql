/*
* Fichero de creación del usuario profesor con contraseña rubenp
*/

DROP USER IF EXISTS profesor;
CREATE USER 'profesor'@'%' IDENTIFIED BY 'rubenp';
GRANT SELECT, SHOW VIEW ON practica1_bd2.* TO 'profesor'@'%';
FLUSH PRIVILEGES;