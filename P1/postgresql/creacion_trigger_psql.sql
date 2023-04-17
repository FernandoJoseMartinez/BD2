/*
* Fichero de creación del trigger que audita la tabla centro
*/

/* Tabla de auditoría de la tabla centro */
DROP TABLE IF EXISTS audit_centro;
CREATE TABLE audit_centro (
	id SERIAL PRIMARY KEY,
	operacion TEXT,
	usuario TEXT,
	fecha TIMESTAMP,
	id_viejo INTEGER,
    id_nuevo INTEGER
);

/* Función del trigger */
CREATE OR REPLACE FUNCTION registrar_operacion_centro() RETURNS TRIGGER AS $$
BEGIN
	INSERT INTO audit_centro(operacion, usuario, fecha, id_viejo, id_nuevo)
	VALUES(TG_OP, current_user, NOW(), OLD.id, NEW.id);
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

/* Se crea el trigger */
DROP TRIGGER IF EXISTS trigger_centro ON centro;
CREATE TRIGGER trigger_centro
	AFTER DELETE OR UPDATE ON centro
	FOR EACH ROW
	EXECUTE PROCEDURE registrar_operacion_centro();