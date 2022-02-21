
-- 1. Selecciona els treballadors que han venut menys quantitat de productes que la Sue Smith
SELECT DISTINCT nombre
FROM repventas
LEFT JOIN pedidos on num_empl=rep
WHERE rep is NULL 
OR (
	SELECT sum(cant)
	FROM pedidos
	WHERE rep = (
		SELECT num_empl
		FROM repventas
		WHERE nombre = 'Sue Smith'
		)
) > ALL (
	SELECT sum(cant) 
	FROM pedidos
	WHERE num_empl=rep
	) 
;

/*
    nombre     
---------------
 Paul Cruz
 Sam Clark
 Bob Smith
 Nancy Angelli
 Mary Jones
 Tom Snyder
(6 filas)
*/

--Comprovació
SELECT DISTINCT nombre, sum(cant)
FROM repventas
LEFT JOIN pedidos on num_empl=rep
GROUP BY nombre
ORDER BY 2;
/*
    nombre     | sum 
---------------+-----
 Sam Clark     |  13
 Mary Jones    |  13
 Tom Snyder    |  17
 Paul Cruz     |  30
 Nancy Angelli |  33
 Sue Smith     |  38
 Dan Roberts   |  45
 Larry Fitch   |  50
 Bill Adams    | 134
 Bob Smith     |    
(10 rows)
*/


-- 2. Llista els treballadors que han venut mes en import que la Sue Smith, la Mary Jones i els Bill Adams

SELECT nombre 
FROM repventas
WHERE (
	SELECT sum (importe)
	FROM pedidos
	WHERE num_empl=rep
	) > (
	SELECT sum (importe)
	FROM pedidos
	WHERE rep=(
		SELECT num_empl
		FROM repventas 
		WHERE nombre='Sue Smith'))
AND	(
	SELECT sum (importe)
	FROM pedidos
	WHERE num_empl=rep
	) > (
	SELECT sum (importe)
	FROM pedidos
	WHERE rep=(
		SELECT num_empl
		FROM repventas 
		WHERE nombre='Mary Jones')
	)	
AND 
	(SELECT sum (importe)
	FROM pedidos
	WHERE num_empl=rep
	) > 
	(SELECT sum (importe)
	FROM pedidos
	WHERE rep=(
		SELECT num_empl
		FROM repventas 
		WHERE nombre='Bill Adams')
	)	
;

/*   nombre    
-------------
 Larry Fitch
(1 row)
*/

--Comprovació
SELECT nombre, sum (importe) 
FROM repventas 
LEFT JOIN pedidos on num_empl=rep 
GROUP BY nombre
ORDER BY 2 DESC;

/*
    nombre     |   sum    
---------------+----------
 Bob Smith     |         
 Larry Fitch   | 58633.00
 Bill Adams    | 39327.00
 Nancy Angelli | 34432.00
 Sam Clark     | 32958.00
 Dan Roberts   | 26628.00
 Tom Snyder    | 23132.00
 Sue Smith     | 22776.00
 Mary Jones    |  7105.00
 Paul Cruz     |  2700.00
(10 filas)


*/

-- 3. Llista els treballadors que han venut mes que alguns dels seguents : Sue Smith, la Mary Jones i els Bill Adams.
SELECT nombre 
FROM repventas
WHERE ventas > (
	SELECT ventas
	FROM repventas
	WHERE nombre='Sue Smith'
	)
	OR
	ventas > (
	SELECT ventas
	FROM repventas
	WHERE nombre='Mary Jones'
	)
	OR
	ventas > (
	SELECT ventas
	FROM repventas
	WHERE nombre='Bill Adams'
	)
;

/*
   nombre   
------------
 Mary Jones
 Sue Smith
(2 rows)
*/

--Comprovació
SELECT nombre,ventas 
FROM repventas 
ORDER BY ventas;
/*
    nombre     |  ventas   
---------------+-----------
 Tom Snyder    |  75985.00
 Bob Smith     | 142594.00
 Nancy Angelli | 186042.00
 Paul Cruz     | 286775.00
 Sam Clark     | 299912.00
 Dan Roberts   | 305673.00
 Larry Fitch   | 361865.00
 Bill Adams    | 367911.00
 Mary Jones    | 392725.00
 Sue Smith     | 474050.00
(10 rows)
*/


-- 4. Llista els treballadors que han fet mes comandes que els seus directors.
SELECT repventas.nombre, directors.nombre as "director"
FROM repventas
LEFT JOIN repventas as directors on directors.num_empl=repventas.director
WHERE (
	SELECT count(1) 
	FROM pedidos
	WHERE repventas.num_empl=rep
	) >
	(SELECT count(1)
	FROM pedidos
	WHERE directors.num_empl=rep
	)
;

/*
   nombre    | director  
-------------+-----------
 Bill Adams  | Bob Smith
 Sam Clark   | 
 Dan Roberts | Bob Smith
 Larry Fitch | Sam Clark
 Paul Cruz   | Bob Smith
(5 rows)
*/

--comprovació
SELECT nombre, count (1)
FROM pedidos
JOIN repventas on num_empl=rep
GROUP BY nombre
ORDER BY 2;

/*
    nombre     | count 
---------------+-------
 Paul Cruz     |     2
 Tom Snyder    |     2
 Mary Jones    |     2
 Sam Clark     |     2
 Dan Roberts   |     3
 Nancy Angelli |     3
 Sue Smith     |     4
 Bill Adams    |     5
 Larry Fitch   |     7
(9 rows)
*/

-- 5. Llista els treballadors que en el r[anking de ventes estan entre el Dan Roberts i la Mary Jones
SELECT nombre
FROM repventas
WHERE ventas BETWEEN (
	SELECT ventas
	FROM repventas
	WHERE nombre='Dan Roberts')
AND (
	SELECT ventas
	FROM repventas
	WHERE nombre='Mary Jones')
;

/*
   nombre    
-------------
 Bill Adams
 Mary Jones
 Dan Roberts
 Larry Fitch
(4 rows)
*/

--Comprovació

SELECT nombre, ventas
FROM repventas
ORDER BY ventas
;
/*
    nombre     |  ventas   
---------------+-----------
 Tom Snyder    |  75985.00
 Bob Smith     | 142594.00
 Nancy Angelli | 186042.00
 Paul Cruz     | 286775.00
 Sam Clark     | 299912.00
 Dan Roberts   | 305673.00
 Larry Fitch   | 361865.00
 Bill Adams    | 367911.00
 Mary Jones    | 392725.00
 Sue Smith     | 474050.00
(10 filas)
*/
-- 6. Mostra les oficines (codi i ciutat) tals que el seu objectiu sigui inferior o igual a les quotes de tots els seus treballadors.

SELECT oficina, ciudad 
FROM oficinas
WHERE objetivo <=  ALL (
	SELECT cuota
	FROM repventas
	WHERE oficina=oficina_rep
);
/*
 oficina | ciudad  
---------+---------
      22 | Denver
      13 | Atlanta
(2 rows)
*/

--Comprovació

SELECT 'oficina:' as "Concepte" , oficina,ciudad,objetivo, NULL as cuota
FROM oficinas
LEFT JOIN repventas on oficina=oficina_rep

UNION


SELECT '  rep:', oficina_rep, nombre, NULL, cuota
FROM oficinas
LEFT JOIN repventas on oficina=oficina_rep
ORDER BY 2, 1
;

/*
 Concepte | oficina |    ciudad     | objetivo  |   cuota   
----------+---------+---------------+-----------+-----------
 oficina: |      11 | New York      | 575000.00 |          
   rep:   |      11 | Mary Jones    |           | 300000.00
   rep:   |      11 | Sam Clark     |           | 275000.00
 oficina: |      12 | Chicago       | 800000.00 |          
   rep:   |      12 | Bob Smith     |           | 200000.00
   rep:   |      12 | Paul Cruz     |           | 275000.00
   rep:   |      12 | Dan Roberts   |           | 300000.00
 oficina: |      13 | Atlanta       | 350000.00 |          
   rep:   |      13 | Bill Adams    |           | 350000.00
 oficina: |      21 | Los Angeles   | 725000.00 |          
   rep:   |      21 | Sue Smith     |           | 350000.00
   rep:   |      21 | Larry Fitch   |           | 350000.00
 oficina: |      22 | Denver        | 300000.00 |          
   rep:   |      22 | Nancy Angelli |           | 300000.00
(14 rows)

*/


-- 7. Llista els representants de vendes (codi de treballador i nom) que tenen un director més jove que algun dels seus empleats.
SELECT repventas.num_empl, repventas.nombre
FROM repventas
JOIN repventas as directors on directors.num_empl=repventas.director
WHERE directors.edad < ANY (
	SELECT edad
	FROM repventas
	WHERE director=directors.num_empl
	)
;
/*
 num_empl |   nombre    
----------+-------------
      108 | Larry Fitch
      104 | Bob Smith
      109 | Mary Jones
      103 | Paul Cruz
      101 | Dan Roberts
      105 | Bill Adams
(6 rows)
*/


--8. Mostrar el codi de treballador, el seu nom i un camp anomenat i_m. El camp i_m és l'import més gran de les comandes que ha fet aquest treballador. 
-- Només s'han de llistar els treballadors que tinguin tots els clients amb alguna comanda amb import superior a la mitjana dels imports de totes les comandes.
SELECT num_empl, nombre, max(importe) as "i_m"
FROM repventas
LEFT JOIN pedidos on num_empl=rep
WHERE importe > ANY (
	SELECT sum(importe)/count(1)
	FROM pedidos
	)
GROUP BY num_empl, nombre
;
/*
 num_empl |    nombre     |   i_m    
----------+---------------+----------
      105 | Bill Adams    | 27500.00
      107 | Nancy Angelli | 31350.00
      106 | Sam Clark     | 31500.00
      110 | Tom Snyder    | 22500.00
      101 | Dan Roberts   | 22500.00
      108 | Larry Fitch   | 45000.00
      102 | Sue Smith     | 15000.00
(7 rows)
*/


-- 9. Mostra el codi de fabricant i de producte i un camp de nom n_p. n_p és el nombre de comandes que s'han fet d'aquell producte. 
-- Només s'han de llistar aquells productes tals que se n'ha fet alguna comanda amb una quantitat inferior a les seves existències. 
-- En el llistat només han d'aparèixer els tres productes amb més comandes, ordenats per codi de fabricant i de producte.
SELECT id_fab, id_producto, count(num_pedido) as "n_p"
FROM productos
JOIN pedidos on id_fab=fab and id_producto=producto
WHERE cant < existencias
GROUP BY id_fab, id_producto
ORDER BY 3 DESC ,1,2
LIMIT 3
;
/* id_fab | id_producto | count 
--------+-------------+-------
 aci    | 41004       |     3
 qsa    | xk47        |     3
 aci    | 41002       |     2
(3 rows)
*/


-- 10. Mostra el codi de client, el nom de client, un camp c_r i un camp n_p. 
-- El camp c_r ha de mostrar la quota del representant de vendes del client. 
-- El camp n_p ha demostrar el nombre de comandes que ha fet aquest client. 
-- Només s'han de mostrar els clients que l'import total de totes les seves comandes sigui superior a la mitjana de l'import de totes les comandes.

SELECT num_clie, empresa, cuota AS "c_r", count(clie) AS "n_p"
FROM clientes
JOIN pedidos ON num_clie = clie
JOIN repventas ON rep_clie = num_empl
WHERE (
	SELECT sum(importe)
	FROM pedidos
	WHERE clie = num_clie
) > ALL (
	SELECT sum(importe)/count(1)
	FROM pedidos
	WHERE clie = num_clie
) 
GROUP BY num_clie, empresa, cuota
ORDER BY 2;

/*
num_clie |      empresa      |    c_r    | n_p 
----------+-------------------+-----------+-----
     2107 | Ace International |           |   2
     2103 | Acme Mfg.         | 350000.00 |   4
     2106 | Fred Lewis Corp.  | 350000.00 |   2
     2108 | Holm & Landis     | 300000.00 |   3
     2111 | JCP Inc.          | 275000.00 |   3
     2118 | Midwest Systems   | 350000.00 |   4
     2114 | Orion Corp        | 350000.00 |   2
     2124 | Peter Brothers    | 300000.00 |   2
     2112 | Zetacorp          | 350000.00 |   2
*/
-- comprovacio
SELECT num_clie, empresa, cuota, sum(importe) AS "Total comandes", round(sum(importe)/count(*),2) AS "Mitjana"
FROM clientes
JOIN pedidos ON num_clie = clie
JOIN repventas ON rep_clie = num_empl
GROUP BY num_clie, empresa, cuota
ORDER BY 2;

/*
 num_clie |      empresa      |   cuota   | Total comandes | Mitjana  
----------+-------------------+-----------+----------------+----------
     2107 | Ace International |           |       23132.00 | 11566.00
     2103 | Acme Mfg.         | 350000.00 |       35582.00 |  8895.50
     2109 | Chen Associates   | 275000.00 |       31350.00 | 31350.00
     2102 | First Corp.       | 300000.00 |        3978.00 |  3978.00
     2106 | Fred Lewis Corp.  | 350000.00 |        4026.00 |  2013.00
     2108 | Holm & Landis     | 300000.00 |        7255.00 |  2418.33
     2113 | Ian & Schmidt     | 200000.00 |       22500.00 | 22500.00
     2111 | JCP Inc.          | 275000.00 |        6445.00 |  2148.33
     2101 | Jones Mfg.        | 275000.00 |        1458.00 |  1458.00
     2117 | J.P. Sinclair     | 275000.00 |       31500.00 | 31500.00
     2118 | Midwest Systems   | 350000.00 |        3608.00 |   902.00
     2114 | Orion Corp        | 350000.00 |       22100.00 | 11050.00
     2124 | Peter Brothers    | 300000.00 |        3082.00 |  1541.00
     2120 | Rico Enterprises  | 350000.00 |        3750.00 |  3750.00
     2112 | Zetacorp          | 350000.00 |       47925.00 | 23962.50
(15 filas)

*/

/* 11. Mostrar l'identificador i el nom de l'empresa dels clients i un camp anomenat m_importe. 
Només s'ha de llistar aquells clients que han fet comandes de productes que tenen un preu que supera 
la mitjana del preu de tots els productes. El camp m_importe ha de mostrar 
l'import més petit de les comandes del client.
*/

-- No m'ha sortit
SELECT num_clie, empresa ,min(importe) AS "m_importe", SUM(precio)
FROM clientes
JOIN pedidos ON num_clie = clie
JOIN productos ON id_fab = fab AND id_producto = producto
WHERE (
	SELECT sum(precio)
	FROM productos
	WHERE id_fab = fab AND id_producto = producto 
) >  ALL (
	SELECT sum(precio)/count(1)
	FROM productos
	WHERE id_fab = fab AND id_producto = producto )
GROUP BY num_clie, empresa
ORDER BY 2;
/*
 num_clie | empresa | m_importe | sum 
----------+---------+-----------+-----
(0 filas)

*/

-- Posible comprovacio
SELECT num_clie, empresa, sum(precio) AS "Total preu", round(sum(precio)/count(*),2) AS "Mitjana"
FROM clientes
JOIN pedidos ON num_clie = clie
JOIN productos ON id_fab = fab AND id_producto = producto
GROUP BY num_clie, empresa
ORDER BY 2;
/*
 num_clie |      empresa      | Total preu     | Mitjana  
----------+-------------------+----------------+----------
     2107 | Ace International |        2579.00 | 11566.00
     2103 | Acme Mfg.         |        3060.00 |  8895.50 
     2109 | Chen Associates   |        1425.00 | 31350.00
     2102 | First Corp.       |         117.00 |  3978.00
     2106 | Fred Lewis Corp.  |         434.00 |  2013.00
     2108 | Holm & Landis     |        2048.00 |  2418.33
     2113 | Ian & Schmidt     |        4500.00 | 22500.00
     2111 | JCP Inc.          |         482.00 |  2148.33
     2101 | Jones Mfg.        |         243.00 |  1458.00
     2117 | J.P. Sinclair     |        4500.00 | 31500.00
     2118 | Midwest Systems   |        1083.00 |   729.33  <--------
     2114 | Orion Corp        |        2855.00 | 11050.00
     2124 | Peter Brothers    |         895.00 |  1541.00
     2120 | Rico Enterprises  |        1875.00 |  3750.00
     2112 | Zetacorp          |        5475.00 | 23962.50
(15 filas)

*/