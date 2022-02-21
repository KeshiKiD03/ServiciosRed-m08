-------------------------------------------------------------------------------
--          Subconsultes
-------------------------------------------------------------------------------


-- 5.1- Llista els venedors que tinguin una quota igual o inferior a l'objectiu de l'oficina de vendes d'Atlanta.
SELECT nombre
FROM repventas 
WHERE cuota <= ( 
	SELECT objetivo 
	FROM oficinas 
	WHERE ciudad ILIKE 'atlanta' OR cuota IS NULL
);
/*
    nombre     
---------------
 Bill Adams
 Mary Jones
 Sue Smith
 Sam Clark
 Bob Smith
 Dan Roberts
 Larry Fitch
 Paul Cruz
 Nancy Angelli
(9 rows)
*/

-- 5.2- Tots els clients, identificador i nom de l'empresa, que han estat atesos per (que han fet comanda amb) Bill Adams.
SELECT empresa, num_clie 
FROM clientes
WHERE num_clie IN (
	SELECT clie 
	FROM pedidos
	JOIN repventas ON rep = num_empl 
	WHERE nombre = 'Bill Adams'
);
/*
  empresa  | num_clie 
-----------+----------
 JCP Inc.  |     2111
 Acme Mfg. |     2103
(2 rows)
*/
-- 5.3- Venedors amb quotes que siguin iguals o superiors a l'objectiu de llur oficina de vendes.
SELECT nombre
FROM repventas
WHERE cuota >= (
	SELECT objetivo 
	FROM oficinaa 
	WHERE oficina = oficina_rep
);
/*
    nombre     
---------------
 Bill Adams
 Nancy Angelli
(2 rows)
*/

-- 5.4- Mostrar l'identificador de l'oficina i la ciutat de les oficines on l'objectiu de vendes de l'oficina excedeix la suma de quotes dels venedors d'aquella oficina.
SELECT oficina, ciudad 
FROM oficinas 
WHERE objetivo > ( 
	SELECT sum(cuota) 
	FROM repventas 
	WHERE oficina_rep = oficina  
);
/*
 oficina |   ciudad    
---------+-------------
      12 | Chicago
      21 | Los Angeles
*/

-- 5.5- Llista dels productes del fabricant amb identificador "aci" que les existències superen les existències del producte amb 
-- identificador de producte "41004" i identificador de fabricant "aci".
SELECT id_fab, descripcion 
FROM productos
WHERE id_fab = 'aci' AND existencias > (
	SELECT existencias  
	FROM productos 
	WHERE id_producto = '41004' AND id_fab = 'aci'
);
/*
 id_fab |   descripcion   
--------+-----------------
 aci    | Articulo Tipo 3
 aci    | Articulo Tipo 1
 aci    | Articulo Tipo 2
 */
-- 5.6- Llistar els venedors que han acceptat una comanda que representa més del 10% de la seva quota.
SELECT nombre
FROM repventas
WHERE cuota > ANY (
	SELECT 0.1*importe 
	FROM pedidos
	WHERE rep = num_empl
);
/*
    nombre     
---------------
 Bill Adams
 Mary Jones
 Sue Smith
 Sam Clark
 Dan Roberts
 Larry Fitch
 Paul Cruz
 Nancy Angelli
(8 rows)
*/

-- 5.7- Llistar el nom i l'edat de totes les persones de l'equip de vendes que no dirigeixen una oficina.
SELECT nombre, edad
FROM repventas
WHERE num_empl != (
	SELECT dir 
	FROM oficinas
	WHERE oficina = oficina_rep
);
/*
    nombre     | edad 
---------------+------
 Mary Jones    |   31
 Sue Smith     |   48
 Dan Roberts   |   45
 Paul Cruz     |   29
 Nancy Angelli |   49
(5 rows)
*/


-- 5.8- Llistar aquelles oficines, i els seus objectius, que tots els seus venedors tinguin unes vendes que superen el 50% de l'objectiu de l'oficina.
SELECT oficina, ciudad, objetivo 
FROM oficinas
WHERE 0.5*objetivo < ALL (
	SELECT min(repventas.ventas)
	FROM repventas
	WHERE oficina_rep = oficina
); 
/* 
 oficina |  ciudad  | objetivo  
---------+----------+-----------
      22 | Denver   | 300000.00
      11 | New York | 575000.00
      13 | Atlanta  | 350000.00
(3 rows)
*/

-- 5.9- Llistar aquells clients que els seus representants de vendes estàn assignats a oficines de la regió est.
SELECT empresa
FROM clientes
WHERE rep_clie IN (
	SELECT num_empl 
	FROM repventas
	JOIN oficinas ON oficina_rep = oficina
	WHERE region = 'Este'
);
/*     empresa     
-----------------
 JCP Inc.
 First Corp.
 Acme Mfg.
 Smithson Corp.
 Jones Mfg.
 QMA Assoc.
 Holm & Landis
 J.P. Sinclair
 Three-Way Lines
 Solomon Inc.
 Ian & Schmidt
 Chen Associates
 AAA Investments
(13 filas)
*/

-- Sense Joins, només subconsultes
SELECT empresa
FROM clientes
WHERE rep_clie IN (
	SELECT num_empl
	FROM repventas
	WHERE oficina_rep IN (
		SELECT oficina
		FROM oficinas
		WHERE region = 'Este')
);
/*
     empresa     
-----------------
 JCP Inc.
 First Corp.
 Acme Mfg.
 Smithson Corp.
 Jones Mfg.
 QMA Assoc.
 Holm & Landis
 J.P. Sinclair
 Three-Way Lines
 Solomon Inc.
 Ian & Schmidt
 Chen Associates
 AAA Investments
(13 rows)
*/

-- Comprovem
SELECT empresa, region
FROM clientes
JOIN repventas ON num_empl=rep_clie
JOIN oficinas ON oficina = oficina_rep
WHERE region = 'Este';
/*
     empresa     | region 
-----------------+--------
 JCP Inc.        | Este
 First Corp.     | Este
 Acme Mfg.       | Este
 Smithson Corp.  | Este
 Jones Mfg.      | Este
 QMA Assoc.      | Este
 Holm & Landis   | Este
 J.P. Sinclair   | Este
 Three-Way Lines | Este
 Solomon Inc.    | Este
 Ian & Schmidt   | Este
 Chen Associates | Este
 AAA Investments | Este
(13 rows)
*/



-- 5.10- Llistar els venedors que treballen en oficines que superen el seu objectiu.
SELECT nombre
FROM repventas
WHERE  oficina_rep IN (
	SELECT oficina
	FROM oficinas
	WHERE ventas > objetivo
);
/*
   nombre    
-------------
 Bill Adams
 Mary Jones
 Sue Smith
 Sam Clark
 Larry Fitch
(5 filas)
*/

-- Comprovem
SELECT nombre, ciudad, oficinas.ventas , objetivo, oficinas.ventas > objetivo
FROM repventas
JOIN oficinas ON oficina_rep = oficina
WHERE oficinas.ventas > objetivo
;
/*
   nombre    |   ciudad    |  ventas   | objetivo  | ?column? 
-------------+-------------+-----------+-----------+----------
 Bill Adams  | Atlanta     | 367911.00 | 350000.00 | t
 Mary Jones  | New York    | 692637.00 | 575000.00 | t
 Sue Smith   | Los Angeles | 835915.00 | 725000.00 | t
 Sam Clark   | New York    | 692637.00 | 575000.00 | t
 Larry Fitch | Los Angeles | 835915.00 | 725000.00 | t

*/
-- 5.11- Llistar els venedors que treballen en oficines que superen el seu objectiu. Mostrar també les següents dades de l'oficina: ciutat i la diferència entre les vendes i l'objectiu. 
-- Ordenar el resultat per aquest últim valor. Proposa dues sentències SQL, una amb subconsultes i una sense.
SELECT nombre, ciudad, (oficinas.ventas - objetivo ) AS "Diferència vendes i objectiu"
FROM repventas
JOIN oficinas ON oficina = oficina_rep
WHERE  oficina_rep IN (
	SELECT oficina
	FROM oficinas
	WHERE ventas > objetivo
)
ORDER BY 3;
/*
   nombre    |   ciudad    | Diferència vendes i objectiu 
-------------+-------------+------------------------------
 Bill Adams  | Atlanta     |                     17911.00
 Sue Smith   | Los Angeles |                    110915.00
 Larry Fitch | Los Angeles |                    110915.00
 Mary Jones  | New York    |                    117637.00
 Sam Clark   | New York    |                    117637.00
(5 filas)
*/

SELECT nombre, ciudad, (oficinas.ventas - objetivo ) AS "Diferència vendes i objectiu"
FROM repventas
JOIN oficinas ON oficina = oficina_rep
WHERE oficina_rep IN (11,13,21);

-- 5.12- Llista els venedors que no treballen en oficines dirigides per Larry Fitch, o que no treballen a cap oficina. Sense usar consultes multitaula.
SELECT nombre
FROM repventas
WHERE oficina_rep not in (
	SELECT oficina
	FROM oficinas
	WHERE dir = (
		SELECT num_empl
		FROM repventas
		WHERE nombre = 'Larry Fitch'
		)
)
OR oficina_rep IS NULL;
/*
   nombre    
-------------
 Bill Adams
 Mary Jones
 Sam Clark
 Bob Smith
 Dan Roberts
 Tom Snyder
 Paul Cruz
(7 rows)
*/
-- 5.13- Llistar els venedors que no treballen en oficines dirigides per Larry Fitch, o que no treballen a cap oficina. 
-- Mostrant també la ciutat de l'oficina on treballa l'empleat i l'identificador del director de la oficina. 
-- Proposa dues sentències SQL, una amb subconsultes i una sense.
SELECT nombre, ciudad, dir
FROM repventas
LEFT JOIN oficinas ON oficina_rep = oficina
WHERE oficina_rep not in (
	SELECT oficina
	FROM oficinas
	WHERE dir = (
		SELECT num_empl
		FROM repventas
		WHERE nombre = 'Larry Fitch'
		)
)
OR oficina_rep IS NULL;
/*
   nombre    |  ciudad  | dir 
-------------+----------+-----
 Bill Adams  | Atlanta  | 105
 Mary Jones  | New York | 106
 Sam Clark   | New York | 106
 Bob Smith   | Chicago  | 104
 Dan Roberts | Chicago  | 104
 Tom Snyder  |          |    
 Paul Cruz   | Chicago  | 104
(7 rows)

*/

SELECT ciudad, nombre, dir
FROM repventas AS reps
LEFT JOIN oficinas ON reps.oficina_rep = oficina
LEFT JOIN repventas AS dirs ON dir = dirs.num_empl
WHERE dirs.nombre != 'Larry Fitch' or reps.oficina_rep IS NULL;

-- 5.14- Llistar tots els clients que han realitzat comandes del productes de la família ACI Widgets entre gener i 
-- juny del 1990. Els productes de la famíla ACI Widgets són aquells que tenen identificador de fabricant "aci" i que 
-- l'identificador del producte comença per "4100".
SELECT empresa
FROM clientes
WHERE EXISTS (
	SELECT 1
	FROM pedidos
	WHERE num_clie = clie AND
	fab = 'aci' AND producto LIKE '4100%' AND
	fecha_pedido BETWEEN '01-01-1990' AND '06-30-1990'
);
/*
      empresa      
-------------------
 JCP Inc.
 Acme Mfg.
 Ace International
 Holm & Landis
(4 filas)

*/
-- 5.15- Llistar els clients que no tenen cap comanda.
SELECT empresa
FROM clientes
WHERE NOT EXISTS (
	SELECT 1
	FROM pedidos
	WHERE num_clie = clie
);
/*
     empresa     
-----------------
 Carter & Sons
 Smithson Corp.
 QMA Assoc.
 Three-Way Lines
 Solomon Inc.
 AAA Investments
(6 filas)
*/
-- Altre alternativa
SELECT empresa
FROM clientes
WHERE num_clie NOT IN (
	SELECT clie 
	FROM pedidos
);

-- Comprovar
SELECT empresa, num_pedido
FROM clientes 
LEFT JOIN pedidos on num_clie = clie
WHERE num_pedido IS NULL;
/*
     empresa     | num_pedido 
-----------------+------------
 QMA Assoc.      |           
 Smithson Corp.  |           
 Solomon Inc.    |           
 Three-Way Lines |           
 AAA Investments |           
 Carter & Sons   |           
(6 rows)
*/

-- 5.16- Llistar els clients que tenen assignat el venedor que porta més temps a contractat.

-- primer intent (pot portar problemes perquè la subquery pot retornar més d'un registre)
SELECT empresa
FROM clientes
WHERE rep_clie = (
	SELECT num_empl
	FROM repventas
	WHERE contrato =(
		SELECT min(contrato)
		FROM repventas
		)
);
/*
     empresa     
-----------------
 First Corp.
 Smithson Corp.
 AAA Investments
(3 rows)

*/

SELECT empresa
FROM clientes
WHERE rep_clie = ANY(
	SELECT num_empl
	FROM repventas
	WHERE contrato =(
		SELECT min(contrato)
		FROM repventas
		)
);
/*
     empresa     
-----------------
 First Corp.
 Smithson Corp.
 AAA Investments
(3 rows)
*/

-- no funciona tan bé perquè no permetria seleccionar diferents representatnts en cas que hi hagués més d'un que vab començar a treballar alhora els primers.
SELECT empresa
FROM clientes
WHERE rep_clie = ANY(
	SELECT num_empl
	FROM repventas
	ORDER BY contrato asc
	LIMIT 1
);

-- comprovar 
SELECT empresa, nombre, contrato
FROM clientes
JOIN repventas ON rep_clie = num_empl
ORDER BY contrato ASC;

/*
      empresa      |    nombre     |  contrato  
-------------------+---------------+------------
 AAA Investments   | Dan Roberts   | 1986-10-20
 Smithson Corp.    | Dan Roberts   | 1986-10-20
 First Corp.       | Dan Roberts   | 1986-10-20
 Rico Enterprises  | Sue Smith     | 1986-12-10
 Carter & Sons     | Sue Smith     | 1986-12-10
 Orion Corp        | Sue Smith     | 1986-12-10
 Fred Lewis Corp.  | Sue Smith     | 1986-12-10
 JCP Inc.          | Paul Cruz     | 1987-03-01
 QMA Assoc.        | Paul Cruz     | 1987-03-01
 Chen Associates   | Paul Cruz     | 1987-03-01
 Ian & Schmidt     | Bob Smith     | 1987-05-19
 Three-Way Lines   | Bill Adams    | 1988-02-12
 Acme Mfg.         | Bill Adams    | 1988-02-12
 J.P. Sinclair     | Sam Clark     | 1988-06-14
 Jones Mfg.        | Sam Clark     | 1988-06-14
 Peter Brothers    | Nancy Angelli | 1988-11-14
 Zetacorp          | Larry Fitch   | 1989-10-12
 Holm & Landis     | Mary Jones    | 1989-10-12
 Solomon Inc.      | Mary Jones    | 1989-10-12
 Midwest Systems   | Larry Fitch   | 1989-10-12
 Ace International | Tom Snyder    | 1990-01-13
(21 rows)
*/

-- 5.17- Llistar els clients assignats a Sue Smith que no han fet cap comanda amb un import superior a 30000. 
-- Proposa una sentència SQL sense usar multitaula i una altre en que s'usi multitaula i subconsultes.

--sense multitaula

SELECT empresa
FROM clientes
WHERE rep_clie IN (
	SELECT num_empl 
	FROM repventas	
	WHERE nombre = 'Sue Smith'
) AND NOT EXISTS ( 	
	SELECT num_pedido
	FROM pedidos
	WHERE clie = num_clie and importe > 30000
);
/*
     empresa      
------------------
 Carter & Sons
 Orion Corp
 Rico Enterprises
 Fred Lewis Corp.
(4 rows)
*/

-- Sense subqueries
SELECT DISTINCT empresa
FROM clientes
LEFT JOIN repventas ON rep_clie = num_empl
LEFT JOIN pedidos ON num_clie = clie
WHERE nombre = 'Sue Smith' and (importe <= 30000 OR  importe IS NULL);
/*
     empresa      
------------------
 Carter & Sons
 Fred Lewis Corp.
 Orion Corp
 Rico Enterprises
*/


-- 5.18- Llistar l'identificador i el nom dels directors d'empleats que tenen més de 40 anys i que dirigeixen un venedor 
-- que té unes vendes superiors a la seva pròpia quota.

SELECT num_empl, nombre
FROM repventas 
WHERE num_empl IN (
	SELECT director
	FROM repventas 
	WHERE edad > 40 
) AND num_empl IN (
	SELECT director
	FROM repventas 
	WHERE ventas > cuota
);

/*
 num_empl |   nombre    
----------+-------------
      106 | Sam Clark
      104 | Bob Smith
      108 | Larry Fitch
(3 rows)
*/

-- comprovar
SELECT num_empl, nombre
FROM repventas 
WHERE num_empl IN (
	SELECT director
	FROM repventas 
	WHERE edad > 40 
);

/*
 num_empl |   nombre    
----------+-------------
      106 | Sam Clark
      104 | Bob Smith
      101 | Dan Roberts
      108 | Larry Fitch
(4 rows)
*/

SELECT num_empl, nombre
FROM repventas 
WHERE num_empl IN (
	SELECT director
	FROM repventas 
	WHERE ventas > cuota
);
/*
 num_empl |   nombre    
----------+-------------
      106 | Sam Clark
      104 | Bob Smith
      108 | Larry Fitch
(3 rows)
*/

-- 5.19- Llista d'oficines on hi hagi algun venedor tal que la seva quota representi més del 50% de l'objectiu de l'oficina
SELECT oficinas.*
FROM oficinas
WHERE oficina IN (
	SELECT oficina_rep
	FROM repventas
	WHERE cuota > 0.5* oficinas.objetivo
);
/* 
oficina |  ciudad  | region | dir | objetivo  |  ventas   
---------+----------+--------+-----+-----------+-----------
      22 | Denver   | Oeste  | 108 | 300000.00 | 186042.00
      11 | New York | Este   | 106 | 575000.00 | 692637.00
      13 | Atlanta  | Este   | 105 | 350000.00 | 367911.00

*/

-- comprovem
SELECT oficina, ciudad, 0.5*objetivo  as "50% de objetivo", max(cuota)
FROM oficinas 
JOIN repventas ON oficina = oficina_rep
WHERE cuota > 0.5* oficinas.objetivo
GROUP BY oficina, ciudad, objetivo;
/*
 oficina |  ciudad  | 50% de objetivo |    max    
---------+----------+-----------------+-----------
      13 | Atlanta  |      175000.000 | 350000.00
      22 | Denver   |      150000.000 | 300000.00
      11 | New York |      287500.000 | 300000.00
*/
-- 5.20- Llista d'oficines on tots els venedors tinguin la seva quota superior al 55% de l'objectiu de l'oficina.
SELECT *
FROM oficinas
WHERE objetivo * 0.55 < all (
	SELECT cuota
	FROM repventas
	WHERE oficina_rep = oficina
);
/*
 oficina | ciudad  | region | dir | objetivo  |  ventas   
---------+---------+--------+-----+-----------+-----------
      22 | Denver  | Oeste  | 108 | 300000.00 | 186042.00
      13 | Atlanta | Este   | 105 | 350000.00 | 367911.00
(2 rows)
*/

-- comprovar
SELECT ciudad, 0.55*objetivo as "55% de objetivo", min (cuota)
FROM oficinas
JOIN repventas ON oficina_rep = oficina
GROUP BY ciudad, objetivo
--HAVING min(cuota) > objetivo *0.55;

/*
   ciudad    | 55% de objetivo |    min    
-------------+-----------------+-----------
 Chicago     |     440000.0000 | 200000.00
 Denver      |     165000.0000 | 300000.00
 Atlanta     |     192500.0000 | 350000.00
 New York    |     316250.0000 | 275000.00
 Los Angeles |     398750.0000 | 350000.00
(5 rows)
*/


-- 5.21- Transforma el següent JOIN a una comanda amb subconsultes:
-- SELECT num_pedido, importe, clie, num_clie, limite_credito
-- FROM pedidos JOIN clientes
-- ON clie = num_clie;
SELECT num_pedido, importe, clie,(
	SELECT num_clie
	FROM clientes 
	WHERE clie = num_clie
	) , ( SELECT limite_credito 
		FROM clientes 
		WHERE clie = num_clie
		)
FROM pedidos
;

-- 5.22- Transforma el següent JOIN a una comanda amb subconsultes:
-- SELECT empl.nombre, empl.cuota, dir.nombre, dir.cuota
-- FROM repventas AS empl JOIN repventas AS dir
-- ON empl.director = dir.num_empl
-- WHERE empl.cuota > dir.cuota;
SELECT empl.nombre, empl.cuota, ( 
	SELECT dir.nombre
	FROM repventas AS dir 
	WHERE empl.director = dir.num_empl), (
		SELECT dir.cuota
		FROM repventas AS dir
		WHERE empl.director = dir.num_empl)
FROM repventas AS empl
WHERE empl.cuota > (
	SELECT dir.cuota
	FROM repventas AS dir
	WHERE empl.director = dir.num_empl);


-- 5.23- Transforma la següent consulta amb un ANY a una consulta amb un EXISTS i també en una altre consulta amb un ALL:
-- SELECT oficina FROM oficinas WHERE ventas*0.8 < ANY (SELECT ventas FROM repventas WHERE oficina_rep = oficina);
/* oficina 
---------
      22
      13
(2 filas)
*/
-- EXISTS
SELECT oficina 
FROM oficinas 
WHERE EXISTS (
	SELECT 1
	FROM repventas 
	WHERE oficina_rep = oficina
	AND oficinas.ventas*0.8 < repventas.ventas);

-- ALL
SELECT oficina 
FROM oficinas 
WHERE ventas*0.8 < ALL (
	SELECT ventas 
	FROM repventas 
	WHERE oficina_rep = oficina);

-- Alternativa ALL
SELECT oficina 
from oficinas 
where not ventas*0.8 >= ALL (
	SELECT ventas 
	FROM repventas 
	WHERE oficina_rep = oficina);

-- 5.24- Transforma la següent consulta amb un ALL a una consutla amb un EXISTS i també en una altre consulta amb un ANY:
-- SELECT num_clie FROM clientes WHERE limite_credito < ALL (SELECT importe FROM pedidos WHERE num_clie = clie);
/* 
num_clie 
----------
     2123
     2115
     2121
     2122
     2119
     2113
     2109
     2105
(8 filas)
*/


--amb EXISTS:
select num_clie 
from clientes 
where (not exists (
	select 1 
	from pedidos 
	where importe <= limite_credito and num_clie=clie)
);

-- amb ANY:
select num_clie 
from clientes 
where not limite_credito >= any (
	SELECT importe 
	FROM pedidos 
	WHERE num_clie = clie);


-- 5.25- Transforma la següent consulta amb un EXISTS a una consulta amb un ALL i també a una altre consulta amb un ANY:
-- SELECT num_clie, empresa FROM clientes WHERE EXISTS (SELECT * FROM repventas WHERE rep_clie = num_empl AND edad BETWEEN 40 AND 50);

--amb ANY:
select num_clie, empresa 
from clientes 
where rep_clie = ANY (
	select num_empl 
	from repventas 
	where edad between 40 and 50);

--amb ALL:
select num_clie, empresa 
from clientes 
where not rep_clie <> ALL (
	select num_empl 
	from repventas 
	where edad between 40 and 50);


-- 5.26- Transforma la següent consulta amb subconsultes a una consulta sense subconsultes.
-- SELECT * FROM productos WHERE id_fab IN(SELECT fab FROM pedidos WHERE cant > 30) AND id_producto IN(SELECT producto FROM pedidos WHERE cant > 30);
--sense subconsultes i per separat:
select productos.* 
from productos, pedidos 
where (id_fab = fab and cant > 30) and (id_producto=producto and cant > 30);

--sense subconsultes i conjuntament:
select productos.* 
from productos join pedidos on id_producto=producto and id_fab=fab
where cant > 30;


-- 5.27- Transforma la següent consulta amb subconsultes a una consulta sense subconsultes.
-- SELECT num_empl, nombre FROM repventas WHERE num_empl = ANY ( SELECT rep_clie FROM clientes WHERE empresa LIKE '%Inc.');
SELECT num_empl, nombre 
FROM repventas 
JOIN clientes ON num_empl = rep_clie
WHERE empresa LIKE '%Inc.';



-- 5.28- Transforma la següent consulta amb un IN a una consulta amb un EXISTS i també a una altre consulta amb un ALL.
-- SELECT num_empl, nombre FROM repventas WHERE num_empl IN(SELECT director FROM repventas);

--amb EXISTS:
select dir.num_empl, dir.nombre 
from repventas as dir 
where exists (
	select 1 
	from repventas as empl 
	where dir.num_empl = empl.director );

--amb ALL:
select num_empl, nombre 
FROM repventas 
where not num_empl <> ALL (
	SELECT director FROM repventas);


-- 5.29- Modifica la següent consulta perquè mostri la ciutat de l'oficina, proposa una consulta simplificada.
SELECT num_pedido FROM pedidos WHERE rep IN
 (
     SELECT num_empl FROM repventas WHERE ventas >
     (
         SELECT avg(ventas) FROM repventas
     )
     AND oficina_rep IN
     (
         SELECT oficina FROM oficinas WHERE region ILIKE 'este'
     )
 );

 /*
  num_pedido 
------------
     112961
     113012
     112989
     112968
     112963
     113058
     112983
     113027
     113055
     113003
     112987
     113042
(12 filas)
*/

select num_pedido, ciudad
from pedidos join repventas on rep=num_empl join oficinas on oficina_rep=oficina
where region ilike 'este' and repventas.ventas > (SELECT avg(ventas) FROM repventas);

-- 5.30- Transforma la següent consulta amb subconsultes a una consulta amb les mínimes subconsultes possibles.
-- SELECT num_clie, empresa, (SELECT nombre FROM repventas WHERE rep_clie = num_empl) AS rep_nombre FROM clientes WHERE rep_clie = ANY (SELECT num_empl FROM repventas WHERE ventas > (SELECT MAX(cuota) FROM repventas));

select num_clie, empresa, nombre 
from clientes join repventas on rep_clie=num_empl
where ventas > (select max (cuota) from repventas);