/*
* Fichero de creación de las tablas temporales de la base de datos
*/

DROP TABLE IF EXISTS oferta_ocupacion;
DROP TABLE IF EXISTS resultados_titulaciones;
DROP TABLE IF EXISTS notas_corte;
DROP TABLE IF EXISTS acuerdos_movilidad_erasmus_sicue;
DROP TABLE IF EXISTS alumnos_egresados_por_titulacion;
DROP TABLE IF EXISTS rendimiento_por_asignatura_y_titulacion;

CREATE TABLE oferta_ocupacion(
    curso_academico INT,
    estudio VARCHAR(200),
    localidad VARCHAR(200),
    centro VARCHAR(200),
    tipo_centro VARCHAR(200),
    tipo_estudio VARCHAR(200),
    plazas_ofertadas INTEGER,
    plazas_matriculadas INTEGER,
    plazas_solicitadas INTEGER,
    indice_ocupacion DECIMAL,
    fecha_actualizacion DATE
);

COPY oferta_ocupacion
FROM '/home/alumno/BD2/P1/DATOS/oferta_ocupacion_2019.csv'  
DELIMITER ';' 
CSV HEADER;

COPY oferta_ocupacion
FROM '/home/alumno/BD2/P1/DATOS/oferta_ocupacion_2020.csv'  
DELIMITER ';' 
CSV HEADER; 

COPY oferta_ocupacion
FROM '/home/alumno/BD2/P1/DATOS/oferta_ocupacion_2021.csv'  
DELIMITER ';' 
CSV HEADER;

CREATE TABLE resultados_titulaciones (
    curso_academico SMALLINT,
    centro VARCHAR(300),
    estudio VARCHAR(300),
    tipo_estudio VARCHAR(300),
    alumnos_matriculados SMALLINT,
    alumnos_nuevo_ingreso SMALLINT,
    plazas_ofertadas SMALLINT,
    alumnos_graduados SMALLINT,
    alumnos_adapta_grado_matri SMALLINT,
    alumnos_adapta_grado_matri_ni SMALLINT,
    alumnos_adapta_grado_titulado SMALLINT,
    alumnos_con_reconocimiento SMALLINT,
    alumnos_movilidad_entrada SMALLINT,
    alumnos_movilidad_salida SMALLINT,
    creditos_matriculados DECIMAL,
    creditos_reconocidos DECIMAL,
    duracion_media_graduados DECIMAL,
    tasa_exito DECIMAL,
    tasa_rendimiento DECIMAL,
    tasa_eficiencia DECIMAL,
    tasa_abandono DECIMAL,
    tasa_graduacion DECIMAL,
    fecha_actualizacion DATE
);

COPY resultados_titulaciones
FROM '/home/alumno/BD2/P1/DATOS/resultados_titulaciones_2019.csv'   
DELIMITER ';' 
CSV HEADER; 

COPY resultados_titulaciones
FROM '/home/alumno/BD2/P1/DATOS/resultados_titulaciones_2020.csv'   
DELIMITER ';' 
CSV HEADER; 

COPY resultados_titulaciones
FROM '/home/alumno/BD2/P1/DATOS/resultados_titulaciones_2021.csv'   
DELIMITER ';' 
CSV HEADER; 

CREATE TABLE notas_corte (
    curso_academico SMALLINT,
    estudio VARCHAR(300),
    localidad VARCHAR(300),
    centro VARCHAR(300),
    prela_convo_nota_def DECIMAL,
    nota_corte_definitiva_julio DECIMAL,
    nota_corte_definitiva_septiembre DECIMAL,
    fecha_actualizacion DATE
);

COPY notas_corte
FROM '/home/alumno/BD2/P1/DATOS/notas_corte_2019.csv'    
DELIMITER ';' 
CSV HEADER; 

COPY notas_corte
FROM '/home/alumno/BD2/P1/DATOS/notas_corte_2020.csv'    
DELIMITER ';' 
CSV HEADER; 

COPY notas_corte
FROM '/home/alumno/BD2/P1/DATOS/notas_corte_2021.csv'    
DELIMITER ';' 
CSV HEADER;

CREATE TABLE acuerdos_movilidad_erasmus_sicue (
    curso_academico SMALLINT,
    nombre_programa_movilidad VARCHAR(300),
    nombre_area_estudios_mov VARCHAR(300),
    centro VARCHAR(300),
    in_out VARCHAR(300),
    nombre_idioma_nivel_movilidad VARCHAR(300),
    pais_universidad_acuerdo VARCHAR(300),
    universidad_acuerdo VARCHAR(300),
    plazas_ofertadas_alumnos SMALLINT,
    plazas_asignadas_alumnos_out SMALLINT,
    fecha_actualizacion DATE
);

COPY acuerdos_movilidad_erasmus_sicue
FROM '/home/alumno/BD2/P1/DATOS/acuerdos_movilidad_erasmus_sicue_2019.csv'    
DELIMITER ';' 
CSV HEADER; 

COPY acuerdos_movilidad_erasmus_sicue
FROM '/home/alumno/BD2/P1/DATOS/acuerdos_movilidad_erasmus_sicue_2020.csv'    
DELIMITER ';' 
CSV HEADER;

COPY acuerdos_movilidad_erasmus_sicue
FROM '/home/alumno/BD2/P1/DATOS/acuerdos_movilidad_erasmus_sicue_2021.csv'    
DELIMITER ';' 
CSV HEADER;


CREATE TABLE alumnos_egresados_por_titulacion (
    curso_academico SMALLINT,
    localidad VARCHAR(300),
    estudio VARCHAR(300),
    tipo_estudio VARCHAR(300),
    tipo_egreso VARCHAR(300),
    sexo VARCHAR(300),
    alumnos_graduados SMALLINT,
    alumnos_interrumpen_estudios SMALLINT,
    alumnos_interrumpen_est_ano1 SMALLINT,
    alumnos_trasladan_otra_univ SMALLINT,
    duracion_media_graduados DECIMAL,
    tasa_eficiencia DECIMAL,
    fecha_actualizacion DATE
);

COPY alumnos_egresados_por_titulacion
FROM '/home/alumno/BD2/P1/DATOS/alumnos_egresados_por_titulacion_2019.csv'   
DELIMITER ';' 
CSV HEADER;

COPY alumnos_egresados_por_titulacion
FROM '/home/alumno/BD2/P1/DATOS/alumnos_egresados_por_titulacion_2020.csv'   
DELIMITER ';' 
CSV HEADER;

COPY alumnos_egresados_por_titulacion
FROM '/home/alumno/BD2/P1/DATOS/alumnos_egresados_por_titulacion_2021.csv'   
DELIMITER ';' 
CSV HEADER;

CREATE TABLE rendimiento_por_asignatura_y_titulacion (
    curso_academico SMALLINT,
    tipo_estudio VARCHAR(300),
    estudio VARCHAR(300),
    localidad VARCHAR(300),
    centro VARCHAR(300),
    asignatura VARCHAR(300),
    tipo_asignatura VARCHAR(300),
    clase_asignatura VARCHAR(300),
    tasa_exito NUMERIC,
    tasa_rendimiento NUMERIC,
    tasa_evaluacion NUMERIC,
    alumnos_evaluados INTEGER,
    alumnos_superados INTEGER,
    alumnos_presentados INTEGER,
    media_convocatorias_consumidas NUMERIC,
    fecha_actualizacion DATE
);

COPY rendimiento_por_asignatura_y_titulacion
FROM '/home/alumno/BD2/P1/DATOS/rendimiento_por_asignatura_y_titulacion_2019.csv'   
DELIMITER ';' 
CSV HEADER;

COPY rendimiento_por_asignatura_y_titulacion
FROM '/home/alumno/BD2/P1/DATOS/rendimiento_por_asignatura_y_titulacion_2020.csv'   
DELIMITER ';' 
CSV HEADER;

COPY rendimiento_por_asignatura_y_titulacion
FROM '/home/alumno/BD2/P1/DATOS/rendimiento_por_asignatura_y_titulacion_2021.csv'   
DELIMITER ';' 
CSV HEADER;


