-- ORIGIN FROM
SELECT * 
FROM tabla_diaria;

-- Otro ejemplo ORIGIN
SELECT *
FROM tabla_diaria AS td 
JOIN tabla_mensual AS tm 
ON td.pk = tm.fk;

-- FROM a traves de otras bases de datos
SELECT *
FROM dblink('
    dbname=somedb
    port=5432 host=someserver
    user=someuser
    password=somepassword',
    'SELECT gid, area, perimeter, state
        tract, blockgroup, block, the_geom
        FROM massgis.cens2000blocks') AS blockgroups