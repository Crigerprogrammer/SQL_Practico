-- Primer Registro
SELECT *
FROM platzi.alumnos
LIMIT 1;

-- Windows Function
SELECT *
FROM (
	SELECT ROW_NUMBER() OVER() AS row_id, *
    FROM platzi.alumnos 
) AS alumnos_with_row_num
WHERE row_id = 1;