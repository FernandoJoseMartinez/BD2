/*
* Fichero de creación de las tablas de la base de datos
*/

DROP TABLE IF EXISTS localidad CASCADE;
CREATE TABLE localidad (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(45)
);

DROP TABLE IF EXISTS centro CASCADE;
CREATE TABLE centro (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    id_localidad INTEGER NOT NULL,
    FOREIGN KEY(id_localidad) REFERENCES localidad(id)
);

DROP TABLE IF EXISTS titulacion CASCADE;
CREATE TABLE titulacion(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);

DROP TABLE IF EXISTS asignatura CASCADE;
CREATE TABLE asignatura(
    nombre VARCHAR(100),
    tipo VARCHAR(50),
    clase VARCHAR(50),
    tasa_exito NUMERIC,
    tasa_rendimiento NUMERIC,
    tasa_evaluacion NUMERIC,
    alumnos_evaluados INTEGER,
    alumnos_superados INTEGER,
    alumnos_presentados INTEGER,
    media_convocatorias_consumidas NUMERIC,
    id_centro INTEGER,
    id_titulacion INTEGER,
    curso_academico INTEGER,
    PRIMARY KEY (id_centro, id_titulacion, curso_academico, nombre, clase, tipo, alumnos_evaluados, alumnos_superados, alumnos_presentados),
    FOREIGN KEY (id_centro) REFERENCES centro(id) ON DELETE CASCADE,
    FOREIGN KEY (id_titulacion) REFERENCES titulacion(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS titulacion_por_centro;
CREATE TABLE titulacion_por_centro (
    curso_academico INTEGER,
    plazas_ofertadas INTEGER,
    plazas_matriculadas INTEGER,
    plazas_solicitadas INTEGER,
    indice_ocupacion NUMERIC,
    alumnos_graduados INTEGER,
    alumnos_con_reconocimiento INTEGER,
    alumnos_movilidad_entrada INTEGER,
    alumnos_movilidad_salida INTEGER,
    creditos_matriculados NUMERIC,
    creditos_reconocidos NUMERIC,
    duracion_media_graduados NUMERIC,
    tasa_exito NUMERIC,
    nota_corte_julio NUMERIC,
    nota_corte_septiembre NUMERIC,
    abandonos_voluntarios INTEGER,
    id_centro INTEGER, 
    id_titulacion INTEGER,
    PRIMARY KEY (curso_academico, id_centro, id_titulacion),
    FOREIGN KEY (id_centro) REFERENCES centro(id) ON DELETE CASCADE,
    FOREIGN KEY (id_titulacion) REFERENCES titulacion(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS pais CASCADE;
CREATE TABLE pais (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(45)
);

DROP TABLE IF EXISTS universidad CASCADE;
CREATE TABLE universidad (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    id_pais INTEGER NOT NULL,
    FOREIGN KEY(id_pais) REFERENCES pais(id)
);

DROP TABLE IF EXISTS acuerdo_movilidad;
CREATE TABLE acuerdo_movilidad (
    curso_academico INTEGER,
    programa VARCHAR(10),
    area_estudios VARCHAR(300),
    in_out VARCHAR(5),
    nivel_idioma VARCHAR(300),
    plazas_ofertadas INTEGER,
    plazas_asignadas_out INTEGER,
    id_universidad INTEGER,
    id_centro INTEGER,
    PRIMARY KEY (curso_academico, programa, area_estudios, in_out, nivel_idioma, id_universidad, id_centro),
    FOREIGN KEY(id_centro) REFERENCES centro(id) ON DELETE CASCADE,
    FOREIGN KEY(id_universidad) REFERENCES universidad(id)
);

/**********************************************************************************************/

/* Insertar datos en la tabla Localidad */
INSERT INTO localidad(nombre)
SELECT DISTINCT localidad
FROM oferta_ocupacion
WHERE tipo_estudio = 'Grado';

/* Insertar datos en la tabla Centro */
INSERT INTO centro(nombre, id_localidad)
SELECT DISTINCT o.centro, l.id
FROM oferta_ocupacion o, localidad l
WHERE o.tipo_estudio = 'Grado' and l.nombre = o.localidad;

/* Insertar datos en tabla Titulacion */
INSERT INTO titulacion(nombre)
SELECT DISTINCT SUBSTRING(estudio, 8)
FROM oferta_ocupacion
WHERE tipo_estudio = 'Grado';

/* Insertar datos en la tabla pais */
INSERT INTO pais(nombre)
SELECT DISTINCT pais_universidad_acuerdo
FROM acuerdos_movilidad_erasmus_sicue;

/* Insertar datos en la tabla universidad */
INSERT INTO universidad(nombre, id_pais)
SELECT DISTINCT a.universidad_acuerdo, p.id
FROM acuerdos_movilidad_erasmus_sicue a, pais p
WHERE p.nombre = a.pais_universidad_acuerdo;

/* Insertar datos en la tabla convenio_movilidad */
INSERT INTO acuerdo_movilidad (curso_academico, programa, area_estudios, in_out, nivel_idioma, plazas_ofertadas, plazas_asignadas_out, id_universidad, id_centro)
SELECT DISTINCT a.curso_academico, a.nombre_programa_movilidad, a.nombre_area_estudios_mov, a.in_out, a.nombre_idioma_nivel_movilidad, a.plazas_ofertadas_alumnos, a.plazas_asignadas_alumnos_out,
u.id, c.id
FROM acuerdos_movilidad_erasmus_sicue a, centro c, universidad u
WHERE a.centro = c.nombre AND u.nombre = a.universidad_acuerdo;

/* Insertar datos en la tabla asignatura */
INSERT INTO asignatura (nombre, tipo, clase, tasa_exito, tasa_rendimiento, tasa_evaluacion, alumnos_evaluados, alumnos_superados,
                        alumnos_presentados, media_convocatorias_consumidas, id_centro, id_titulacion, curso_academico)
SELECT DISTINCT r.asignatura, r.tipo_asignatura, r.clase_asignatura, r.tasa_exito, r.tasa_rendimiento, r.tasa_evaluacion, r.alumnos_evaluados,
                r.alumnos_superados, r.alumnos_presentados, r.media_convocatorias_consumidas, c.id, t.id, r.curso_academico
FROM rendimiento_por_asignatura_y_titulacion r, centro c, titulacion t
WHERE r.centro = c.nombre AND SUBSTRING(r.estudio, 8) = t.nombre;

/* Insertar datos de la primera tabla temporal en la tabla titulacion_por_centro */
INSERT INTO titulacion_por_centro(curso_academico, plazas_ofertadas, plazas_matriculadas, plazas_solicitadas, id_titulacion, id_centro, indice_ocupacion)
SELECT DISTINCT o.curso_academico, o.plazas_ofertadas, o.plazas_matriculadas, o.plazas_solicitadas, t.id, c.id, o.indice_ocupacion
FROM oferta_ocupacion o, titulacion t, centro c
WHERE o.tipo_estudio = 'Grado' AND t.nombre = SUBSTRING(o.estudio, 8) AND c.nombre = o.centro;

/* Insertar datos de la segunda tabla temporal en la tabla titulacion_por_centro*/
UPDATE titulacion_por_centro tc
SET alumnos_graduados = r.alumnos_graduados, alumnos_con_reconocimiento = r.alumnos_con_reconocimiento, alumnos_movilidad_entrada = r.alumnos_movilidad_entrada,
alumnos_movilidad_salida = r.alumnos_movilidad_salida, creditos_matriculados = r.creditos_matriculados, creditos_reconocidos = r.creditos_reconocidos, 
duracion_media_graduados = r.duracion_media_graduados, tasa_exito = r.tasa_exito
FROM resultados_titulaciones r, centro c, titulacion t
WHERE r.tipo_estudio = 'Grado' AND tc.id_titulacion = t.id AND tc.id_centro = c.id AND tc.curso_academico = r.curso_academico AND SUBSTRING(r.estudio, 3) = t.nombre AND c.nombre = r.centro;

/* Insertar datos de la tercera tabla temporal en la tabla titulacion_por_centro */
UPDATE titulacion_por_centro tc
SET nota_corte_julio = n.nota_corte_definitiva_julio, nota_corte_septiembre = n.nota_corte_definitiva_septiembre
FROM notas_corte n, centro c, titulacion t
WHERE tc.id_centro = c.id AND tc.id_titulacion = t.id AND tc.curso_academico = n.curso_academico AND n.centro = c.nombre AND t.nombre = SUBSTRING(n.estudio, 8);

/* Insertar nº de abandonos voluntarios en la tabla titulacion_por_centro */
UPDATE titulacion_por_centro tc
SET abandonos_voluntarios = t1.abandonos
FROM (SELECT  a.curso_academico as curso, c.id as id_centro, t.id as id_titulacion, SUM(a.alumnos_interrumpen_estudios) as abandonos
	  FROM alumnos_egresados_por_titulacion a, centro c, titulacion t, localidad l, titulacion_por_centro tc
	  WHERE tipo_egreso = 'Abandono Voluntario' AND a.localidad = l.nombre AND l.id = c.id_localidad AND t.nombre = SUBSTRING(a.estudio, 8)
	  AND c.id = tc.id_centro AND t.id = tc.id_titulacion AND tc.curso_academico = a.curso_academico
	  GROUP BY c.id, t.id, a.curso_academico) as t1
WHERE tc.id_centro = t1.id_centro AND tc.id_titulacion = t1.id_titulacion AND tc.curso_academico = t1.curso;

