/*
* Consulta 1: Devuelve los dos estudios de cada
*             localidad con mayor índice de ocupación en el 2020
*/

SELECT l1.nombre as localidad, t1.nombre as titulacion, tc1.indice_ocupacion
FROM titulacion_por_centro tc1, titulacion t1, centro c1, localidad l1
WHERE tc1.curso_academico = 2020 AND tc1.id_titulacion = t1.id AND tc1.id_centro = c1.id AND c1.id_localidad = l1.id 
AND t1.id IN (SELECT sub.id
              FROM(SELECT t2.id
                   FROM titulacion_por_centro tc2, titulacion t2, centro c2
                   WHERE tc2.curso_academico = 2020 AND tc2.id_titulacion = t2.id AND tc2.id_centro = c2.id 
                   AND c2.id_localidad = l1.id
                   ORDER BY tc2.indice_ocupacion DESC LIMIT 2) as sub)
ORDER BY l1.nombre;