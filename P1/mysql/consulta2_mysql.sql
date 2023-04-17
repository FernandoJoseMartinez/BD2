/*
* Consulta 2: Devuelve la universidad que más
*             alumnos recibe de cada centro en el 2020
*/

SELECT DISTINCT c.nombre as nombre_centro, u.nombre as nombre_universidad, am.plazas_asignadas_out as plazas_asignadas
FROM centro c, universidad u, acuerdo_movilidad am
WHERE am.id_centro = c.id AND am.id_universidad = u.id AND am.in_out = 'OUT' AND am.curso_academico = 2020 AND
      am.plazas_asignadas_out = (SELECT MAX(am2.plazas_asignadas_out)
							     FROM acuerdo_movilidad am2
							     WHERE am2.in_out = 'OUT' AND am2.curso_academico = 2020 AND am2.id_centro = am.id_centro)
ORDER BY c.nombre;