# Script que descarga los datos del repositorio de datos abiertos de la Universidad de Zaragoza

mkdir /home/alumno/BD2/P1/DATOS/

wget -cO - https://zaguan.unizar.es/record/87665/files/CSV.csv > /home/alumno/BD2/P1/DATOS/oferta_ocupacion_2019.csv
wget -cO - https://zaguan.unizar.es/record/96835/files/CSV.csv > /home/alumno/BD2/P1/DATOS/oferta_ocupacion_2020.csv
wget -cO - https://zaguan.unizar.es/record/108270/files/CSV.csv > /home/alumno/BD2/P1/DATOS/oferta_ocupacion_2021.csv

wget -cO - https://zaguan.unizar.es/record/95644/files/CSV.csv > /home/alumno/BD2/P1/DATOS/resultados_titulaciones_2019.csv
wget -cO - https://zaguan.unizar.es/record/107369/files/CSV.csv > /home/alumno/BD2/P1/DATOS/resultados_titulaciones_2020.csv
wget -cO - https://zaguan.unizar.es/record/118234/files/CSV.csv > /home/alumno/BD2/P1/DATOS/resultados_titulaciones_2021.csv

wget -cO - https://zaguan.unizar.es/record/87663/files/CSV.csv > /home/alumno/BD2/P1/DATOS/notas_corte_2019.csv
wget -cO - https://zaguan.unizar.es/record/98173/files/CSV.csv > /home/alumno/BD2/P1/DATOS/notas_corte_2020.csv
wget -cO - https://zaguan.unizar.es/record/109322/files/CSV.csv > /home/alumno/BD2/P1/DATOS/notas_corte_2021.csv

wget -cO - https://zaguan.unizar.es/record/83980/files/CSV.csv > /home/alumno/BD2/P1/DATOS/acuerdos_movilidad_erasmus_sicue_2019.csv
wget -cO - https://zaguan.unizar.es/record/95648/files/CSV.csv > /home/alumno/BD2/P1/DATOS/acuerdos_movilidad_erasmus_sicue_2020.csv
wget -cO - https://zaguan.unizar.es/record/107373/files/CSV.csv > /home/alumno/BD2/P1/DATOS/acuerdos_movilidad_erasmus_sicue_2021.csv

wget -cO - https://zaguan.unizar.es/record/95646/files/CSV.csv > /home/alumno/BD2/P1/DATOS/alumnos_egresados_por_titulacion_2019.csv
wget -cO - https://zaguan.unizar.es/record/107371/files/CSV.csv > /home/alumno/BD2/P1/DATOS/alumnos_egresados_por_titulacion_2020.csv
wget -cO - https://zaguan.unizar.es/record/118236/files/CSV.csv > /home/alumno/BD2/P1/DATOS/alumnos_egresados_por_titulacion_2021.csv

wget -cO - https://zaguan.unizar.es/record/95645/files/CSV.csv > /home/alumno/BD2/P1/DATOS/rendimiento_por_asignatura_y_titulacion_2019.csv
wget -cO - https://zaguan.unizar.es/record/107370/files/CSV.csv > /home/alumno/BD2/P1/DATOS/rendimiento_por_asignatura_y_titulacion_2020.csv
wget -cO - https://zaguan.unizar.es/record/118235/files/CSV.csv > /home/alumno/BD2/P1/DATOS/rendimiento_por_asignatura_y_titulacion_2021.csv