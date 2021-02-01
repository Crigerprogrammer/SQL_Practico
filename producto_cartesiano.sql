SELECT *
FROM tabla_diaria AS td 
    JOIN tabla_mensual AS tm 
    ON td.pk = tm.fk