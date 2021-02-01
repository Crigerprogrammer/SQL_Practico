SELECT *
FROM tabla_diaria
GROUP BY marca;

SELECT *
FROM tabla_diaria
GROUP BY marca, modelo;

SELECT *
FROM tabla_diaria
LIMIT 1500;

SELECT *
FROM tabla_diaria
OFFSET 1500
LIMIT 1500;