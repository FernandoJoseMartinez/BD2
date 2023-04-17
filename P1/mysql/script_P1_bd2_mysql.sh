#!/bin/bash

echo Se van a descargar los datos del repositorio
sh /home/alumno/BD2/P1/descarga_datos_P1.sh

echo Se va a crear la base de datos de la práctica 1
sudo mysql -u root -p < /home/alumno/BD2/P1/mysql/creacion_bd_P1_mysql.sql

echo Se van a crear las tablas temporales
sudo mysql --local-infile=1 -u ferjose -p practica1_bd2 < /home/alumno/BD2/P1/mysql/creacion_tablas_tmp_mysql.sql

echo Se van a crear las tablas de la base de datos
sudo mysql -u ferjose -p practica1_bd2 < /home/alumno/BD2/P1/mysql/creacion_tablas_bd_mysql.sql

echo Se va a crear el trigger de la tabla localidad
sudo mysql -u ferjose -p practica1_bd2 < /home/alumno/BD2/P1/mysql/creacion_trigger_mysql.sql

echo Se va a lanzar la consulta 1
sudo mysql -u ferjose -p practica1_bd2 < /home/alumno/BD2/P1/mysql/consulta1_mysql.sql

echo Se va a lanzar la consula 2
sudo mysql -u ferjose -p practica1_bd2 < /home/alumno/BD2/P1/mysql/consulta2_mysql.sql

echo Se va a crear la vista de la tabla asignatura
sudo mysql -u ferjose -p practica1_bd2 < /home/alumno/BD2/P1/mysql/creacion_vista_mysql.sql

echo Se va a crear el usuario profesor con permisos de lectura
sudo mysql -u root -p practica1_bd2 < /home/alumno/BD2/P1/mysql/creacion_usuario_profesor_mysql.sql

