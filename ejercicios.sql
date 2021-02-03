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

-- RETO elimiar un duplicado
DELETE FROM platzi.alumnos
WHERE id IN(
SELECT id
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
    ) AS row 
    FROM platzi.alumnos
) AS duplicados 
WHERE duplicados.row > 1;
);

-- RANGOS
SELECT *
FROM platzi.alumnos
WHERE tutor_id IN (1,2,3,4);

SELECT *
FROM platzi.alumnos
WHERE tutor_id BETWEEN 1 AND 10;

SELECT int4range(10, 20) @> 3;

SELECT numrange(11.1, 22.2) && numrange(20.0, 30.0);

-- El numero mayor del rango
SELECT UPPER(int8range(15,25));

-- El numero menor del rango
SELECT LOWER(int8range(15,25));

SELECT int4range(10,20) * int4range(15,25);

SELECT ISEMPTY (numrange(1,5));

SELECT *
FROM platzi.alumnos
WHERE int4range(10,20) @> tutor_id;

-- Buscar interseccion entre dos rangos
SELECT numrange(
    (SELECT MIN(tutor_id) FROM platzi.alumnos),
    (SELECT MAX(tutor_id) FROM platzi.alumnos)
) * numrange(
    (SELECT MIN(carrera_id) FROM platzi.alumnos),
    (SELECT MAX(carrera_id) FROM platzi.alumnos)
);

-- Maximo de una tabla
SELECT fecha_incorporacion
FROM platzi.alumnos 
ORDER BY fecha_incorporacion DESC
LIMIT 1;

-- Fecha más reciente pero por grupo de carrera
SELECT carrera_id, 
MAX(fecha_incorporacion) 
from platzi.alumnos 
GROUP BY carrera_id
ORDER BY carrera_id

-- RETO MIN id_tutores
SELECT tutor_id,
MIN(nombre)
FROM platzi.alumnos 
GROUP BY tutor_id
ORDER BY tutor_id;

-- Self JOIN
SELECT CONCAT(t.nombre,' ', t.apellido) AS tutor,
       COUNT(*) AS alumnos_por_tutor
FROM platzi.alumnos AS a 
INNER JOIN platzi.alumnos AS t ON a.tutor_id = t.id
GROUP BY tutor
ORDER BY alumnos_por_tutor DESC;

-- Extraer promedio de alumnos por tutor
SELECT AVG(alumnos_por_tutor) AS promedio_alumnos_por_tutor
FROM(
SELECT CONCAT(t.nombre,' ', t.apellido) AS tutor,
       COUNT(*) AS alumnos_por_tutor
FROM platzi.alumnos AS a 
INNER JOIN platzi.alumnos AS t ON a.tutor_id = t.id
GROUP BY tutor
) AS alumnos_tutor;

-- Diferencias 
SELECT carrera_id, COUNT(*) AS cuenta 
FROM platzi.alumnos 
GROUP BY carrera_id 
ORDER BY cuenta DESC;

SELECT a.nombre,
       a.apellido,
       a.carrera_id,
       c.id,
       c.carrera 
FROM platzi.alumnos AS a 
LEFT JOIN platzi.carreras AS c 
ON a.carrera_id = c.id 
WHERE c.id IS NULL

-- Todas las uniones
SELECT a.nombre,
       a.apellido,
       a.carrera_id,
       c.id,
       c.carrera
FROM platzi.alumnos AS a 
LEFT JOIN platzi.carreras AS c 
ON a.carrera_id = c.id 
WHERE c.id IS NULL 

SELECT a.nombre,
       a.apellido,
       a.carrera_id,
       c.id,
       c.carrera
FROM platzi.alumnos AS a 
RIGHT JOIN platzi.carreras AS c 
ON a.carrera_id = c.id 
WHERE a.id IS NULL 

SELECT a.nombre,
       a.apellido,
       a.carrera_id,
       c.id,
       c.carrera
FROM platzi.alumnos AS a 
INNER JOIN platzi.carreras AS c 
ON a.carrera_id = c.id 
ORDER BY c.id DESC;


-- Triangulado 
SELECT lpad('sql', 15, '*');

SELECT lpad('sql', id, '*')
FROM platzi.alumnos 
WHERE id < 10;

SELECT lpad('*', id, '*')
FROM platzi.alumnos
WHERE id < 10
ORDER BY carrera_id;

SELECT lpad('*', CAST(row_id AS int), '*')
FROM (
    SELECT ROW_NUMBER() OVER(ORDER BY carrera_id) AS row_id, *
    FROM platzi.alumnos
) AS alumnos_with_row_id 
WHERE row_id <= 5
ORDER BY carrera_id;

-- Rangos
SELECT * 
FROM generate_series(1,4);

SELECT *
FROM generate_series(1.1,4,1.3);

SELECT current_date + s.a. AS dates 
FROM generate_series(0, 14, 7) AS s(a);

SELECT *
FROM generate_series('2020-09-01 00:00:00'::timestamp, 
                     '2020-09-04 12:00:00', '10 hours');

