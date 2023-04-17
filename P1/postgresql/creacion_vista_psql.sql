/*
* Fichero de creación de la vista de la tasa de éxito de las asignaturas
*/

/* Vista de las 10 asignaturas con menor tasa de éxito*/
drop view if exists vista_tasa_exito_asc;
create view vista_tasa_exito_asc (nombre_asignatura,tasa_exito,nombre_titulacion)
  as
  select a.nombre, a.tasa_exito, t.nombre
   from asignatura a, titulacion t, centro c
   where t.nombre = 'Ingeniería Informática' and a.id_centro = c.id and (c.nombre = 'Escuela Universitaria Politécnica de Teruel' or 
         c.nombre = 'Escuela de Ingeniería y Arquitectura') and a.tasa_exito is not null
   order by a.tasa_exito ASC LIMIT 10;

/* Vista de las 10 asignaturas con mayor tasa de éxito*/
drop view if exists vista_tasa_exito_desc;
create view vista_tasa_exito_desc (nombre_asignatura,tasa_exito,nombre_titulacion)
  as
  select a.nombre, a.tasa_exito, t.nombre
   from asignatura a, titulacion t, centro c
   where t.nombre = 'Ingeniería Informática' and a.id_centro = c.id and (c.nombre = 'Escuela Universitaria Politécnica de Teruel' or 
         c.nombre = 'Escuela de Ingeniería y Arquitectura') and a.tasa_exito is not null
   order by a.tasa_exito DESC LIMIT 10;

SELECT * FROM vista_tasa_exito_asc
UNION ALL
SELECT * FROM vista_tasa_exito_desc;
