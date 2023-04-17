/*
* Fichero de creación de la vista de la tasa de éxito de las asignaturas por año
*/
                        
/* Vista de las 10 asignaturas con menor tasa de éxito*/
DROP VIEW IF EXISTS vista_tasa_exito_asc;
CREATE VIEW vista_tasa_exito_asc AS
  SELECT DISTINCT a1.curso_academico AS curso_ac, a1.nombre AS nombre_asig, a1.tasa_exito AS tasa_exito_asig, t1.nombre AS nombre_tit,
         c1.nombre as nombre_centro
    FROM asignatura a1
    JOIN titulacion t1 ON a1.id_titulacion = t1.id
    JOIN centro c1 ON a1.id_centro = c1.id
    WHERE t1.nombre = 'Ingeniería Informática' AND a1.tasa_exito IS NOT NULL
      AND (c1.nombre = 'Escuela Universitaria Politécnica de Teruel' OR c1.nombre = 'Escuela de Ingeniería y Arquitectura') AND
          a1.nombre IN (SELECT sub.nombre_asignatura
                        FROM (SELECT a2.nombre AS nombre_asignatura
                              FROM asignatura a2
                              JOIN titulacion t2 ON a2.id_titulacion = t2.id
                              JOIN centro c2 ON a2.id_centro = c2.id
                              WHERE t2.nombre = 'Ingeniería Informática' AND a2.tasa_exito IS NOT NULL
                                    AND (c2.nombre = 'Escuela Universitaria Politécnica de Teruel' OR
                                    c2.nombre = 'Escuela de Ingeniería y Arquitectura') AND
                                    a2.curso_academico = a1.curso_academico
                              ORDER BY a2.tasa_exito DESC LIMIT 10) as sub)
    ORDER BY a1.curso_academico;

/* Vista de las 10 asignaturas con mayor tasa de éxito*/
DROP VIEW IF EXISTS vista_tasa_exito_desc;
CREATE VIEW vista_tasa_exito_desc AS
  SELECT a1.curso_academico AS curso_ac, a1.nombre AS nombre_asig, a1.tasa_exito AS tasa_exito_asig, t1.nombre AS nombre_tit,
         c1.nombre as nombre_centro
    FROM asignatura a1
    JOIN titulacion t1 ON a1.id_titulacion = t1.id
    JOIN centro c1 ON a1.id_centro = c1.id
    WHERE t1.nombre = 'Ingeniería Informática' AND a1.tasa_exito IS NOT NULL
      AND (c1.nombre = 'Escuela Universitaria Politécnica de Teruel' OR c1.nombre = 'Escuela de Ingeniería y Arquitectura') AND
          a1.nombre IN (SELECT sub.nombre_asignatura
                        FROM (SELECT a2.nombre AS nombre_asignatura
                              FROM asignatura a2
                              JOIN titulacion t2 ON a2.id_titulacion = t2.id
                              JOIN centro c2 ON a2.id_centro = c2.id
                              WHERE t2.nombre = 'Ingeniería Informática' AND a2.tasa_exito IS NOT NULL
                                    AND (c2.nombre = 'Escuela Universitaria Politécnica de Teruel' OR
                                    c2.nombre = 'Escuela de Ingeniería y Arquitectura') AND
                                    a2.curso_academico = a1.curso_academico
                              ORDER BY a2.tasa_exito DESC LIMIT 10) as sub)
    ORDER BY a1.curso_academico;

SELECT curso_ac, nombre_asig, tasa_exito_asig, nombre_tit, nombre_centro FROM vista_tasa_exito_asc
UNION ALL
SELECT curso_ac, nombre_asig, tasa_exito_asig, nombre_tit, nombre_centro FROM vista_tasa_exito_desc;