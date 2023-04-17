#!/bin/bash

echo Se van a descargar los datos del repositorio
sh /home/alumno/BD2/P1/descarga_datos_P1.sh

echo Se va a crear la base de datos de la práctica 1
sudo -i -u postgres psql -f /home/alumno/BD2/P1/postgresql/creacion_bd_P1_psql.sql

echo Se van a crear las tablas temporales
sudo -i -u postgres psql -U ferjose -d practica1_bd2 -f /home/alumno/BD2/P1/postgresql/creacion_tablas_tmp_psql.sql

echo Se van a crear las tablas de la base de datos
sudo -i -u postgres psql -U ferjose -d practica1_bd2 -f /home/alumno/BD2/P1/postgresql/creacion_tablas_bd_psql.sql

echo Se va a crear el trigger de la tabla centro
sudo -i -u postgres psql -U ferjose -d practica1_bd2 -f /home/alumno/BD2/P1/postgresql/creacion_trigger_psql.sql

echo Se va a lanzar la primera consulta
sudo -i -u postgres psql -U ferjose -d practica1_bd2 -f /home/alumno/BD2/P1/postgresql/consulta1_psql.sql

echo Se va a lanzar la segunda consulta
sudo -i -u postgres psql -U ferjose -d practica1_bd2 -f /home/alumno/BD2/P1/postgresql/consulta2_psql.sql

echo Se va a crear la vista de la tabla asignatura
sudo -i -u postgres psql -U ferjose -d practica1_bd2 -f /home/alumno/BD2/P1/postgresql/creacion_vista_psql.sql

echo Se va a crear el usuario profesor con permisos de lectura
sudo -i -u postgres psql -d practica1_bd2 -f /home/alumno/BD2/P1/postgresql/creacion_usuario_profesor_psql.sql




