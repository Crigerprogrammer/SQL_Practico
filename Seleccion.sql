SELECT * 
FROM tabla_diaria 
WHERE id = 1;

SELECT *
FROM tabla_diaria
WHERE cantidad > 10;

SELECT *
FROM tabla_diaria
WHERE cantidad < 100;

SELECT *
FROM tabla_diaria
WHERE cantidad > 10
AND cantidad < 100;

SELECT *
FROM tabla_diaria
WHERE cantidad BETWEEN 10
AND 100;