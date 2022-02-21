/*
UNION
https://www.postgresql.org/docs/9.4/static/sql-select.html#SQL-UNION

SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;


The UNION operator is used to combine the result-set of two or more SELECT statements.

Notice that each SELECT statement within the UNION must have the same number of columns. The columns must also have similar data types. Also, the columns in each SELECT statement must be in the same order.



SELECT empresa FROM clientes
UNION
SELECT nombre FROM repventas;


SELECT empresa, rep_clie FROM clientes
UNION
SELECT nombre, num_empl FROM repventas;


SELECT empresa FROM clientes
UNION
SELECT nombre FROM repventas
UNION
SELECT ciudad FROM oficinas;

Nota: l’ordre dels resultats és força aleatori, i va combinant resultats d’un i altre SELECT. Per tant, si volem que surtin en un ordre concret, cal que AL FINAL de l’ordre posem un ORDER BY.


Llistar les empreses, el seu venedor assignat, i, per cada venta realitzada llistar el nom de l'empresa i el venedor que l'ha fet. 

select 'Client' , empresa, rep_clie, 'VENEDOR ASSIGNAT' as relacio FROM clientes
UNION
select 'Venta', empresa, rep, 'VENEDOR QUE HA FET LA VENTA' FROM pedidos JOIN clientes ON clie=num_clie
ORDER BY empresa;

Llistar cada venta, el total de ventes per empresa I el total general de ventes :

SELECT 'Compra : ', empresa, fecha_pedido as data, importe from pedidos JOIN clientes on clie=num_clie 
 UNION 
SELECT 'Total :', empresa, current_date as data, sum(importe) FROM pedidos JOIN clientes ON clie=num_clie GROUP BY empresa 
UNION 
SELECT 'Total General :', '--------', current_date as data, sum(importe) FROM pedidos ORDER BY empresa, data; 

    ?column? 		|      empresa      	|    data          |  importe  
--------------------------+-------------------------+--------------+----------- 
 Total General : 	| --------         		| 2015-12-02 | 	247691.00 
 Compra :        	| Ace International 	| 1990-01-29 |  632.00 
 Compra :       		| Ace International 	| 1990-01-30 |  22500.00 
 Total :        		| Ace International 	| 2015-12-02 |  23132.00 
 Compra :     		| Acme Mfg.         	| 1989-12-17 |   3276.00 
 Compra :       		| Acme Mfg.         	| 1989-12-27 |    702.00 
 Compra :       		| Acme Mfg.         	| 1989-12-31 |  27500.00 
 Compra :       		| Acme Mfg.         	| 1990-01-22 |   4104.00 
 Total :        		| Acme Mfg.         	| 2015-12-02 |  35582.00 
 Compra :        	| Chen Associates   	| 1990-03-02 |  31350.00 
 Total :        		| Chen Associates   	| 2015-12-02 |  31350.00 
 Compra :        	| First Corp.       	| 1989-10-12 |   3978.00 
 Total :         		| First Corp.       	| 2015-12-02 |   3978.00 
 Compra :       		| Fred Lewis Corp.  	| 1989-01-04 |   1896.00 
 Compra :        	| Fred Lewis Corp.  	| 1990-02-27 |   2130.00 
 Total :         		| Fred Lewis Corp. 	| 2015-12-02 |   4026.00 
 Compra :       		| Holm & Landis     	| 1990-01-25 |   5625.00 
 Compra :       		| Holm & Landis     	| 1990-02-15 |    150.00 
 Compra :        	| Holm & Landis     	| 1990-02-23 |   1480.00 
 Total :         		| Holm & Landis     	| 2015-12-02 |   7255.00 
 Compra :        	| Ian & Schmidt     	| 1990-02-02 |  22500.00 
 Total :         		| Ian & Schmidt     	| 2015-12-02 |  22500.00 
 Compra :        	| JCP Inc.          	| 1989-12-12 |   2100.00 
 Compra :        	| JCP Inc.          	| 1990-01-11 |   3745.00 
 Compra :        	| JCP Inc.          	| 1990-02-18 |    600.00 
 Total :         		| JCP Inc.          	| 2015-12-02 |   6445.00 
 Compra :        	| Jones Mfg.       	| 1990-01-03 |   1458.00 
 Total :         		| Jones Mfg.        	| 2015-12-02 |   1458.00 
 Compra :        	| J.P. Sinclair     	| 1989-12-17 |  31500.00 
 Total :        		| J.P. Sinclair     	| 2015-12-02 |  31500.00 
 Compra :       		| Midwest Systems   	| 1989-11-04 |    760.00 
 Compra :       		| Midwest Systems   	| 1990-01-14 |    652.00 
 Compra :        	| Midwest Systems   	| 1990-02-10 |   1420.00 
 Compra :        	| Midwest Systems   	| 1990-02-10 |    776.00 
 Total :         		| Midwest Systems   	| 2015-12-02 |   3608.00 
 Compra :        	| Orion Corp        	| 1989-10-12 |  15000.00 
 Compra :        	| Orion Corp        	| 1990-01-20 |   7100.00 
 Total :         		| Orion Corp        	| 2015-12-02 |  22100.00 
 Compra :        	| Peter Brothers    	| 1990-01-08 |    652.00 
 Compra :        	| Peter Brothers    	| 1990-02-24 |   2430.00 
 Total :         		| Peter Brothers    	| 2015-12-02 |   3082.00 
 Compra :       		| Rico Enterprises  	| 1990-02-10 |   3750.00 
 Total :         		| Rico Enterprises  	| 2015-12-02 |   3750.00 
 Compra :        	| Zetacorp          	| 1990-01-08 |   2925.00 
 Compra :        	| Zetacorp          	| 1990-02-02 |  45000.00 
 Total :        		| Zetacorp          	| 2015-12-02 |  47925.00 
(46 rows) 

1r pas : Mostrar l'import de cada compra i el total per client:

SELECT 'Compra : ', empresa, importe from pedidos JOIN clientes on clie=num_clie 
UNION
SELECT 'Total :', empresa, sum(importe) FROM pedidos JOIN clientes ON clie=num_clie GROUP BY empresa
ORDER BY empresa; 

 ?column?  |      empresa      | importe  
-----------+-------------------+---------- 
 Compra :  | Ace International |   632.00 
 Compra :  | Ace International | 22500.00 
 Total :   | Ace International | 23132.00 
 Compra :  | Acme Mfg.         |  3276.00 
 Compra :  | Acme Mfg.         |  4104.00 
 Compra :  | Acme Mfg.         |   702.00 
 Total :   | Acme Mfg.         | 35582.00 
 Compra :  | Acme Mfg.         | 27500.00 
 Compra :  | Chen Associates   | 31350.00 
 Total :   | Chen Associates   | 31350.00 
 Compra :  | First Corp.       |  3978.00 
 Total :   | First Corp.       |  3978.00 
 Compra :  | Fred Lewis Corp.  |  2130.00 
 Compra :  | Fred Lewis Corp.  |  1896.00 
 Total :   | Fred Lewis Corp.  |  4026.00 
 Compra :  | Holm & Landis     |  1480.00 
 Compra :  | Holm & Landis     |   150.00 
 Compra :  | Holm & Landis     |  5625.00 
 Total :   | Holm & Landis     |  7255.00 
 Compra :  | Ian & Schmidt     | 22500.00 
 Total :   | Ian & Schmidt     | 22500.00 
 Compra :  | JCP Inc.          |  2100.00 
 Total :   | JCP Inc.          |  6445.00 
 Compra :  | JCP Inc.          |  3745.00 
 Compra :  | JCP Inc.          |   600.00 
 Total :   | Jones Mfg.        |  1458.00 
 Compra :  | Jones Mfg.        |  1458.00 
 Compra :  | J.P. Sinclair     | 31500.00 
 Total :   | J.P. Sinclair     | 31500.00 
 Compra :  | Midwest Systems   |   760.00 
 Compra :  | Midwest Systems   |  1420.00 
 Compra :  | Midwest Systems   |   776.00 
 Total :   | Midwest Systems   |  3608.00 
 Compra :  | Midwest Systems   |   652.00 
 Total :   | Orion Corp        | 22100.00 
 Compra :  | Orion Corp        | 15000.00 
 Compra :  | Orion Corp        |  7100.00 
 Total :   | Peter Brothers    |  3082.00 
 Compra :  | Peter Brothers    |  2430.00 
 Compra :  | Peter Brothers    |   652.00 
 Total :   | Rico Enterprises  |  3750.00 
 Compra :  | Rico Enterprises  |  3750.00 
 Compra :  | Zetacorp          | 45000.00 
 Total :   | Zetacorp          | 47925.00 
 Compra :  | Zetacorp          |  2925.00 
(45 rows) 


2n pas : Mostrar l'import total de cada compra i el total per client a data d'avui, ordenat per client i data:

SELECT 'Compra : ', empresa, fecha_pedido as data, importe from pedidos JOIN clientes on clie=num_clie 
 UNION 
SELECT 'Total :', empresa, current_date as data, sum(importe) FROM pedidos JOIN clientes ON clie=num_clie GROUP BY empresa 
ORDER BY empresa, data;

 ?column?  |      empresa      |    data    | importe  
-----------+-------------------+------------+---------- 
 Compra :  | Ace International | 1990-01-29 |   632.00 
 Compra :  | Ace International | 1990-01-30 | 22500.00 
 Total :   | Ace International | 2015-12-02 | 23132.00 
 Compra :  | Acme Mfg.         | 1989-12-17 |  3276.00 
 Compra :  | Acme Mfg.         | 1989-12-27 |   702.00 
 Compra :  | Acme Mfg.         | 1989-12-31 | 27500.00 
 Compra :  | Acme Mfg.         | 1990-01-22 |  4104.00 
 Total :   | Acme Mfg.         | 2015-12-02 | 35582.00 
 Compra :  | Chen Associates   | 1990-03-02 | 31350.00 
 Total :   | Chen Associates   | 2015-12-02 | 31350.00 
 Compra :  | First Corp.       | 1989-10-12 |  3978.00 
 Total :   | First Corp.       | 2015-12-02 |  3978.00 
 Compra :  | Fred Lewis Corp.  | 1989-01-04 |  1896.00 
 Compra :  | Fred Lewis Corp.  | 1990-02-27 |  2130.00 
 Total :   | Fred Lewis Corp.  | 2015-12-02 |  4026.00 
 Compra :  | Holm & Landis     | 1990-01-25 |  5625.00 
 Compra :  | Holm & Landis     | 1990-02-15 |   150.00 
 Compra :  | Holm & Landis     | 1990-02-23 |  1480.00 
 Total :   | Holm & Landis     | 2015-12-02 |  7255.00 
 Compra :  | Ian & Schmidt     | 1990-02-02 | 22500.00 
 Total :   | Ian & Schmidt     | 2015-12-02 | 22500.00 
 Compra :  | JCP Inc.          | 1989-12-12 |  2100.00 
 Compra :  | JCP Inc.          | 1990-01-11 |  3745.00 
 Compra :  | JCP Inc.          | 1990-02-18 |   600.00 
 Total :   | JCP Inc.          | 2015-12-02 |  6445.00 
 Compra :  | Jones Mfg.        | 1990-01-03 |  1458.00 
 Total :   | Jones Mfg.        | 2015-12-02 |  1458.00 
 Compra :  | J.P. Sinclair     | 1989-12-17 | 31500.00 
 Total :   | J.P. Sinclair     | 2015-12-02 | 31500.00 
 Compra :  | Midwest Systems   | 1989-11-04 |   760.00 
 Compra :  | Midwest Systems   | 1990-01-14 |   652.00 
 Compra :  | Midwest Systems   | 1990-02-10 |   776.00 
 Compra :  | Midwest Systems   | 1990-02-10 |  1420.00 
 Total :   | Midwest Systems   | 2015-12-02 |  3608.00 
 Compra :  | Orion Corp        | 1989-10-12 | 15000.00 
 Compra :  | Orion Corp        | 1990-01-20 |  7100.00 
 Total :   | Orion Corp        | 2015-12-02 | 22100.00 
 Compra :  | Peter Brothers    | 1990-01-08 |   652.00 
 Compra :  | Peter Brothers    | 1990-02-24 |  2430.00 
 Total :   | Peter Brothers    | 2015-12-02 |  3082.00 
 Compra :  | Rico Enterprises  | 1990-02-10 |  3750.00 
 Total :   | Rico Enterprises  | 2015-12-02 |  3750.00 
 Compra :  | Zetacorp          | 1990-01-08 |  2925.00 
 Compra :  | Zetacorp          | 1990-02-02 | 45000.00 
 Total :   | Zetacorp          | 2015-12-02 | 47925.00 
(45 rows)


3r pas : Afegir-hi el total general :

SELECT 'Compra : ', empresa, fecha_pedido as data, importe from pedidos JOIN clientes on clie=num_clie 
UNION 
SELECT 'Total :', empresa, current_date as data, sum(importe) FROM pedidos JOIN clientes ON clie=num_clie GROUP BY empresa 
UNION 
SELECT 'Total General :', '--------', current_date as data, sum(importe) FROM pedidos
ORDER BY empresa, data; 

    ?column?     |      empresa      |    data    |  importe  
-----------------+-------------------+------------+----------- 
 Total General : | --------          | 2015-12-02 | 247691.00 
 Compra :        | Ace International | 1990-01-29 |    632.00 
 Compra :        | Ace International | 1990-01-30 |  22500.00 
 Total :         | Ace International | 2015-12-02 |  23132.00 
 Compra :        | Acme Mfg.         | 1989-12-17 |   3276.00 
 Compra :        | Acme Mfg.         | 1989-12-27 |    702.00 
 Compra :        | Acme Mfg.         | 1989-12-31 |  27500.00 
 Compra :        | Acme Mfg.         | 1990-01-22 |   4104.00 
 Total :         | Acme Mfg.         | 2015-12-02 |  35582.00 
 Compra :        | Chen Associates   | 1990-03-02 |  31350.00 
 Total :         | Chen Associates   | 2015-12-02 |  31350.00 
 Compra :        | First Corp.       | 1989-10-12 |   3978.00 
 Total :         | First Corp.       | 2015-12-02 |   3978.00 
 Compra :        | Fred Lewis Corp.  | 1989-01-04 |   1896.00 
 Compra :        | Fred Lewis Corp.  | 1990-02-27 |   2130.00 
 Total :         | Fred Lewis Corp.  | 2015-12-02 |   4026.00 
 Compra :        | Holm & Landis     | 1990-01-25 |   5625.00 
 Compra :        | Holm & Landis     | 1990-02-15 |    150.00 
 Compra :        | Holm & Landis     | 1990-02-23 |   1480.00 
 Total :         | Holm & Landis     | 2015-12-02 |   7255.00 
 Compra :        | Ian & Schmidt     | 1990-02-02 |  22500.00 
 Total :         | Ian & Schmidt     | 2015-12-02 |  22500.00 
 Compra :        | JCP Inc.          | 1989-12-12 |   2100.00 
 Compra :        | JCP Inc.          | 1990-01-11 |   3745.00 
 Compra :        | JCP Inc.          | 1990-02-18 |    600.00 
 Total :         | JCP Inc.          | 2015-12-02 |   6445.00 
 Compra :        | Jones Mfg.        | 1990-01-03 |   1458.00 
 Total :         | Jones Mfg.        | 2015-12-02 |   1458.00 
 Compra :        | J.P. Sinclair     | 1989-12-17 |  31500.00 
 Total :         | J.P. Sinclair     | 2015-12-02 |  31500.00 
 Compra :        | Midwest Systems   | 1989-11-04 |    760.00 
 Compra :        | Midwest Systems   | 1990-01-14 |    652.00 
 Compra :        | Midwest Systems   | 1990-02-10 |   1420.00 
 Compra :        | Midwest Systems   | 1990-02-10 |    776.00 
 Total :         | Midwest Systems   | 2015-12-02 |   3608.00 
 Compra :        | Orion Corp        | 1989-10-12 |  15000.00 
 Compra :        | Orion Corp        | 1990-01-20 |   7100.00 
 Total :         | Orion Corp        | 2015-12-02 |  22100.00 
 Compra :        | Peter Brothers    | 1990-01-08 |    652.00 
 Compra :        | Peter Brothers    | 1990-02-24 |   2430.00 
 Total :         | Peter Brothers    | 2015-12-02 |   3082.00 
 Compra :        | Rico Enterprises  | 1990-02-10 |   3750.00 
 Total :         | Rico Enterprises  | 2015-12-02 |   3750.00 
 Compra :        | Zetacorp          | 1990-01-08 |   2925.00 
 Compra :        | Zetacorp          | 1990-02-02 |  45000.00 
 Total :         | Zetacorp          | 2015-12-02 |  47925.00 
(46 rows) 

*/


--  1. Mostar les ventes individuals dels productes dels fabricants 'aci' i 'rei' que comencin per 'Bisagra' o 'Articulo'. Mostrar també el total venut d'aquests productes.
    SELECT 'Ventes individuals: ' AS "concepte" , descripcion, importe
    FROM productos
    JOIN pedidos ON id_fab = fab and id_producto = producto
    WHERE id_fab in ('aci','rei') and (descripcion LIKE 'Bisagra%' or descripcion LIKE 'Articulo%')
    
    UNION

    SELECT 'Total: ' , descripcion, sum(importe)
    FROM productos
    JOIN pedidos ON id_fab = fab and id_producto = producto
    WHERE id_fab in ('aci','rei') and (descripcion LIKE 'Bisagra%' or descripcion LIKE 'Articulo%')
    GROUP BY descripcion
    ORDER BY 2,1 DESC
    ; 


--  2. Mostrar les ventes individuals fetes pels venedors de New York i de Chicago que superin els 2500€. Mostrar també el total de ventes de cada oficina.
    SELECT 'Ventes individuals: ' AS "concepte", ciudad , repventas.ventas
    FROM repventas
    JOIN oficinas ON oficina = oficina_rep
    WHERE oficina_rep IN (11,12) and repventas.ventas > 2500

    UNION

    SELECT 'Total: ', ciudad,sum(repventas.ventas)
    FROM repventas
    JOIN oficinas ON oficina = oficina_rep
    WHERE oficina_rep IN (11,12) and repventas.ventas > 2500
    GROUP BY ciudad
    ORDER BY 2,1 DESC;
--  3. Mostrar quantes ventes ha fet cada venedor, la mitjana de numero de ventes dels venedors de cada oficina i el numero de ventes total.
    SELECT '0.Numero Ventes: ' AS "concepte", nombre, oficina, count(*) 
    FROM repventas
    JOIN oficinas ON oficina = oficina_rep
    JOIN pedidos ON rep = num_empl
    GROUP BY nombre, oficina

    UNION

    SELECT '1.Mitjana: ', nombre, oficina, round(avg(oficinas.ventas),1)
    FROM repventas
    JOIN oficinas ON oficina = oficina_rep
    JOIN pedidos ON rep = num_empl
    GROUP BY oficina,nombre

    UNION

    SELECT '2.Ventes Total: ', nombre, oficina, sum(repventas.ventas)
    FROM repventas
    JOIN oficinas ON oficina = oficina_rep
    JOIN pedidos ON rep = num_empl
    GROUP BY nombre, oficina
    ORDER BY 2,3
    ;


--  4. Mostrar les compres de productes de la fabrica 'aci' que han fet els clients del Bill Adams i el Dan Roberts. Mostrar també l'import total per cada client.
    SELECT '0.Client:' AS "concepte" ,empresa,nombre,NULL AS "Import"
    FROM pedidos
    JOIN clientes ON num_clie = clie
    JOIN repventas ON rep = num_empl
    WHERE fab IN ('aci') and rep IN (105,101)

    
    UNION

    SELECT '1.Import:',empresa, nombre,sum(importe)
    FROM pedidos
    JOIN clientes ON num_clie = clie
    JOIN repventas ON rep = num_empl
    WHERE fab IN ('aci') and rep IN (105,101)
    GROUP BY empresa,nombre
    ORDER BY 2,1;


--  5. Mostrar el total de ventes de cada oficina i el total de ventes de cada regió
    SELECT '0.Total oficina:' AS "concepte", oficina,ciudad, region,sum(oficinas.ventas) 
    FROM oficinas
    GROUP BY oficina

    UNION 

    SELECT '1.Total regio:' , NULL, NULL, region,sum(oficinas.ventas)
    FROM oficinas
    GROUP BY region 
    ORDER BY 4,1 ;
--  6. Mostrar els noms dels venedors de cada ciutat i el numero total de venedors per ciutat
    SELECT '0.Venedors:' as "concepte",nombre, ciudad, NULL AS "Total"
    FROM oficinas
    JOIN repventas ON oficina_rep = oficina 
    GROUP BY  ciudad, nombre

    UNION

    SELECT '1.Total:' as "concepte",NULL, ciudad,count(*)
    FROM oficinas
    JOIN repventas ON oficina_rep = oficina 
    GROUP BY  ciudad
    ORDER BY 2,1 ;
--  7. Mostrat els noms dels clients de cada ciutat i el numero total de clients per ciutat.
    SELECT '0.Ciutat:' , ciudad,empresa, NULL AS "Total"
    FROM clientes
    JOIN repventas ON num_empl = rep_clie
    JOIN oficinas ON oficina = oficina_rep

    UNION 

    SELECT '      1.Total:', ciudad, NULL, count(*)
    FROM clientes
    JOIN repventas ON num_empl = rep_clie
    JOIN oficinas ON oficina = oficina_rep
    GROUP BY ciudad
    ORDER BY 2,1;
--  8. Mostrat els noms dels treballadors que son -caps- d'algú, els noms dels seus -subordinats- i el numero de treballadors que té assignat cada cap.
    SELECT '0.-caps-:' as "concepte" , nombre, num_empl AS "director"
    FROM repventas
    WHERE num_empl IN (106,104,108,101)

    UNION

    SELECT '      1.-subordinats-:', nombre,director  
    FROM repventas
    WHERE director IS NOT NULL
    GROUP BY director , nombre
    ORDER BY 3 ,1 ;


                                                                    San Clark
                                                                        |
                                            |---------------------------|---------------------------------------------------------------------------|                           
                                        Mary Jones                  Bob Smith                                                                   Larry Fitch
                                                                        |                                                                            |
                                                          |-------------|--------------------|                                        |--------------|------------------|
                                                        Bill Adams     Dan Roberts       Paul Cruz                                Sue Smith                       Nancy Angelli 
                                                                        |
                                                                    Tom Snyder 
