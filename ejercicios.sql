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

-- Colegiatura 2da más cara
SELECT DISTINCT colegiatura 
FROM platzi.alumnos AS a1
WHERE 2 = (
    SELECT COUNT(DISTINCT colegiatura)
    FROM platzi.alumnos a2
    WHERE a1.colegiatura = a2.colegiatura
);

-- Otra forma 2da más cara
SELECT DISTINCT colegiatura, tutor_id
FROM platzi.alumnos
WHERE tutor_id = 20
ORDER BY colegiatura DESC 
LIMIT 1 OFFSET 1;

-- 3era forma 2da colegiatura más cara con alumnos
SELECT *
FROM platzi.alumnos AS datos_alumnos
INNER JOIN (
    SELECT DISTINCT colegiatura
    FROM platzi.alumnos
    WHERE tutor_id = 20
    ORDER BY colegiatura DESC 
    LIMIT 1 OFFSET 1
) AS segunda_mayor_colegiatura 
ON datos_alumnos.colegiatura = segunda_mayor_colegiatura.colegiatura

-- Otra forma
SELECT *
FROM platzi.alumnos AS datos_alumnos
WHERE colegiatura = (
    SELECT DISTINCT colegiatura
    FROM platzi.alumnos
    WHERE tutor_id = 20
    ORDER BY colegiatura DESC
    LIMIT 1 OFFSET 1
)

-- 2da mitad de la tabla
SELECT ROW_NUMBER() OVER() AS row_id, *
FROM platzi.alumnos
OFFSET(
    SELECT COUNT(*)/2
    FROM platzi.alumnos
)

-- Arrays
SELECT *
FROM (
    SELECT ROW_NUMBER() OVER() AS row_id, *
    FROM platzi.alumnos
) AS alumnos_with_row_num
WHERE row_id IN (1, 5, 10, 12, 15, 20);

-- Otra forma arreglos
SELECT *
FROM platzi.alumnos 
WHERE id IN (
    SELECT id 
    FROM platzi.alumnos
    WHERE tutor_id = 30
)

-- Extraer algo de un campo
SELECT EXTRACT(YEAR FROM fecha_incorporacion AS anio_incorporacion)
FROM platzi.alumnos;

-- Otra forma
SELECT DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion
FROM platzi.alumnos;

SELECT DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion,
    DATE_PART('MONTH', fecha_incorporacion) AS mes_incorporacion,
    DATE_PART('DAY', fecha_incorporacion) AS dia_incorporacion
FROM platzi.alumnos;

-- RETO extraer hora 
SELECT DATE_PART('HOUR', fecha_incorporacion) AS hora_incorporacion,
    DATE_PART('MINUTE', fecha_incorporacion) AS minuto_incorporacion,
    DATE_PART('SECOND', fecha_incorporacion) AS segundo_incorporacion
FROM platzi.alumnos;

-- Extract todo de los que se incorporaron en el 2019
SELECT *
FROM platzi.alumnos
WHERE (EXTRACT(YEAR FROM fecha_incorporacion)) = 2019;

-- SELECT igual de 2019 pero otra forma
SELECT *
FROM platzi.alumnos 
WHERE (DATE_PART('YEAR', fecha_incorporacion)) = 2019;

-- Con subquery
SELECT *
FROM (
    SELECT *,
        DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion
    FROM platzi.alumnos 
) AS alumnos_con_anio
WHERE anio_incorporacion = 2019; 

-- Double Trouble
SELECT *
FROM (
    SELECT *,
        DATE_PART('YEAR', fecha_incorporacion) AS anio_incorporacion,
        DATE_PART('MONTH', fecha_incorporacion ) AS mes_incorporacion
    FROM platzi.alumnos 
) AS alumnos_con_anio
WHERE anio_incorporacion = 2018
    AND mes_incorporacion = 5;

-- Encontrar duplicados
SELECT (platzi.alumnos.nombre,
        platzi.alumnos.apellido,
        platzi.alumnos.email,
        platzi.alumnos.colegiatura,
        platzi.alumnos.fecha_incorporacion,
        platzi.alumnos.carrera_id,
        platzi.alumnos.tutor_id
    )::text, COUNT(*)
FROM platzi.alumnos 
GROUP BY platzi.alumnos.nombre,
        platzi.alumnos.apellido,
        platzi.alumnos.email,
        platzi.alumnos.colegiatura,
        platzi.alumnos.fecha_incorporacion,
        platzi.alumnos.carrera_id,
        platzi.alumnos.tutor_id
HAVING COUNT(*) > 1;

-- Duplicados con windows function y subquery
SELECT *
FROM(
    SELECT id,
    ROW_NUMBER() OVER (
        PARTITION BY 
            nombre,
            apellido,
            email,
            colegiatura,
            fecha_incorporacion,
            carrera_id,
            tutor_id
        ORDER BY id AS ASC
    ) AS row ,
    *
    FROM platzi.alumnos
) AS duplicados 
WHERE duplicados.row > 1;