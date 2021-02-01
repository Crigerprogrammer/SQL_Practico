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

-- Sacar primeros 5
SELECT *
FROM platzi.alumnos
FETCH FIRST 5 ROWS ONLY;

-- Sacar primeros 5
SELECT *
FROM platzi.alumnos
LIMIT 5;

-- Sacar primeros 5 WFunction
SELECT *
FROM(
    SELECT ROW_NUMBER() OVER() AS row_id, *
    FROM platzi.alumnos
) AS alumnos_with_row_num
WHERE row_id BETWEEN 1 AND 5;