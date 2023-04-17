/*
* Fichero de creación del trigger de la tabla localidad
*/

DROP TRIGGER IF EXISTS before_localidad_delete;

delimiter $$
CREATE TRIGGER before_localidad_delete 
BEFORE DELETE ON localidad
FOR EACH ROW  
BEGIN 
	SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No es posible borrar localidades';
END$$
delimiter ;