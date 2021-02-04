## SQL
**Breve Historia SQL**
Es un lenguaje que se basó en la teoría de conjuntos y se basó en la álgebra relacional de Codd. 

SQL Nació en los años 70 en IMB, originalmente llamado SEQUEL, 
luego se llamo System/38 (1979) 
luego SQL/DS (1981)
luego DB2 (1983)

Luego Relational company creó el software Oracle en 1979.  

## Álgebra relacional
El álgebra relacional estudia basicamente las operaciones que se pueden realizar entre diversos conjuntos de datos.
⠀
No confundir las relaciones del álgebra relacional con las relaciones de una base de datos relacional.

Las relaciones de una base de datos es cuando unes dos tablas.
Las relaciones en álgebra relacional se refiere a una tabla.
- La diferencia es conceptual: Las tablas pueden tener tuplas repetidas pero en el álgebra relacional cada relación no tiene un cuerpo, no tiene un primer ni último row.
⠀
Tipos de operadores
Operadores unarios.- Requiere una relación o tabla para funcionar.
- Proyección (π): Equivale al comando Select. Saca un número de columnas o atributos sin necesidad de hacer una unión con una segunda tabla.
π<Nombre, Apellido, Email>(Tabla_Alumno)
⠀
- Selección (σ): Equivale al comando Where. Consiste en el filtrado de de tuplas.
σ<Suscripción=Expert>(Tabla_Alumno)

## Proyección (SELECT)
Es el comando que usamos para elegir que se muestra
**Ejemplo**
- SELECT *; (Significa que muestra todas las columnas de la entidad)
- SELECT field AS alias; (Coloca un alias a la columna)
- SELECT COUNT(id), SUM(quantity), AVG(age) (Cuenta todo, suma una columna y saca promedio)
- SELECT MIN(date), MAX(quantity) (Saca el minimo y el maximo)

**ESTRUCTURAS DE CONTROL CON SELECT**
- SELECT IF(500<1000, "YES", "NO");
- SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN "Over 30"
    WHEN Quantity = 30 THEN "Equal 30"
END AS QuantityText

## Origin (FROM)

## Productos cartesianos (Join)
- LEFT JOIN
- RIGHT JOIN
- EXCLUSIVE LEFT JOIN
- EXCLUSIVE RIGHT JOIN 
- FULL OUTER JOIN
- EXCLUSIVE FULL OUTER JOIN
- INNER JOIN

## Selección WHERE

## Ordenamiento (Order BY)
**Indices**
- Excelentes para búsquedas y ordenamientos
- Cuidar para alta transaccionalidad.

## Agregación (GROUP BY)

## Limitantes (Limit)

### Base de Datos Distribuidas
Es una colección de múltiples bases de datos separadas físicamente que se comunican mediante una red informática.
**Ventajas**
- Desarrollo Modular.
- Incrementa la confiabilidad.
- Mejora el redimiento
- Mayor disponibilidad
- Rapidez de respuesta.
**Desventajas**
- Manejo de seguridad
- Complejidad de procesamiento
- Integridad de datos más compleja
- Costo
**Homogéneas y heterogéneas**
- Mismo OS
- Sistema de base de datos
- Modelos de datos
**Arquitecturas**
- Cliente - Servidor
- Par a par (peer 2 peer)
- Multi manejador de base de datos
**Estrategias de diseño**
- Top down
- Bottom up
**Almacenamiento distribuido**
- Fragmentación
- Replicación
- Distribución
**Fragmentación**
- Horizontal
- Vertical
- Mixta
**Replicación**
- Completa
- Parcial
- Sin replicación
**Distribución de los datos**
- Centralizada
- Particionada
- Replicada

## Queries Distribuidos

## Sharding 
Divide la data en un criterio por medio de servidores. 
**Problemas**
- Joins entre shards
- Baja elasticidad
- Reemplaza PK

## Window Functions
**¿Que es ?**
Realizan cálculos en algunas tuplas que se encuentran relacionadas con la tupla actual
**¿Para que sirven?**
Evitan el uso de self JOINS y reduce la complejidad alrededor de la analítica,
agragaciones y uso de cursores.