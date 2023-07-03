--Evaluación Final Módulo 5

-- 1. Descarga el archivo adjunto, y descomprímelo para obtener el archivo “dvdrental.tar”. HECHO.
-- 2. La base de datos “dvdrental” contiene 15 tablas bajo el siguiente modelo relacional. HECHO.
-- 3. Si tienes problemas cargando el archivo .tar en postgresql, puedes seguir los pasos que aparecen
-- en su página: postgresqltutorial.com. HECHO.

-- 4. Construye las siguientes consultas:

-- • Aquellas usadas para insertar, modificar y eliminar un Customer, Staff y Actor.

INSERT INTO customer(customer_id, store_id, first_name, last_name, email, address_id, activebool, create_date,
					 last_update, active) VALUES(?)
					 
UPDATE <tabla> SET <columna1, columna 2, ...> = <VALUE> WHERE <condicion>;

DELETE FROM <tabla> WHERE <condicion>;

-- • Listar todas las “rental” con los datos del “customer” dado un año y mes. 

SELECT rental.*, customer.* FROM rental JOIN customer ON rental.rental_id = customer.customer_id 
WHERE EXTRACT(MONTH FROM rental.rental_date) = '05' AND EXTRACT (YEAR FROM rental.rental_date) = '2005';

-- • Listar Número, Fecha (payment_date) y Total (amount) de todas las “payment”.

SELECT payment_id AS Numero, payment_date AS Fecha, SUM(amount) AS Total FROM payment GROUP BY payment_id, payment_date;

-- • Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.

SELECT * FROM film WHERE film.release_year = '2006' AND film.rental_rate > 4;

-- 5. Realiza un Diccionario de datos que contenga el nombre de las tablas y columnas, si éstas pueden ser nulas, 
-- y su tipo de dato correspondiente.

SELECT
t1.TABLE_NAME AS tabla_nombre,
t1.COLUMN_NAME AS columna_nombre,
t1.COLUMN_DEFAULT AS columna_defecto,
t1.IS_NULLABLE AS columna_nulo,
t1.DATA_TYPE AS columna_tipo_dato,
COALESCE(t1.NUMERIC_PRECISION,
t1.CHARACTER_MAXIMUM_LENGTH) AS columna_longitud,
PG_CATALOG.COL_DESCRIPTION(t2.OID,
t1.DTD_IDENTIFIER::int) AS columna_descripcion,
t1.DOMAIN_NAME AS columna_dominio
FROM
INFORMATION_SCHEMA.COLUMNS t1
INNER JOIN PG_CLASS t2 ON (t2.RELNAME = t1.TABLE_NAME)
WHERE
t1.TABLE_SCHEMA = 'public'
ORDER BY
t1.TABLE_NAME;