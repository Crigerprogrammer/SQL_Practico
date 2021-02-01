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

SELECT *
FROM users
WHERE name = "Israel"
AND ( lastname = "Vasquez" OR lastname = "Lopez")

SELECT *
FROM users 
WHERE name = "Israel"
AND lastname = "Vasquez"
OR lastname = "Lopez";

SELECT *
FROM users
WHERE name LIKE "%Is";

SELECT *
FROM users
WHERE name LIKE "Is_ael";

SELECT * 
FROM users
WHERE name NOT LIKE "Is_ael";

SELECT * 
FROM users
WHERE name IS NULL;

SELECT * 
FROM users
WHERE name IS NOT NULL;

SELECT *
FROM users
WHERE name IN ('Israel', 'Laura', 'Luis');