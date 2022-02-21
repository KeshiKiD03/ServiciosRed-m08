--    PRACTICA 16.  UNION  +  LEFT JOIN + WHERE

--		1. Llistar els productes amb existències no superiors a 200 i no inferiors a 20 de la fàbrica aci o de la fabrica imm,
--		i els nom dels clients que han comprat aquests productes. Si algun producte no l'ha comprat ningú ha de sortir sense nom de client.
SELECT  'Clientes:' as "concepte" , NULL AS "producte", empresa AS "Cliente" , id_fab, id_producto
FROM pedidos
LEFT JOIN productos ON id_fab = fab and id_producto = producto
JOIN clientes ON clie = num_clie
WHERE (existencias  BETWEEN 20 and 200) and (id_fab IN ('aci','imm'))

UNION 

SELECT  'Productes:', descripcion, NULL, id_fab, id_producto
FROM pedidos
JOIN productos ON id_fab = fab and id_producto = producto
JOIN clientes ON clie = num_clie
WHERE (existencias  BETWEEN 20 and 200) and (id_fab IN ('aci','imm')) 
GROUP BY descripcion,id_fab,id_producto
ORDER BY 5,4,1 DESC;


--		2. Llistar la ciutat de cada oficina, el número total de treballadors, el nom del cap de l'oficina i el nom de cadascun dels 
--      treballadors (incloent al cap com a treballador).
SELECT '0-Ciutat:' AS "concepte", ciudad, oficina, NULL, count(*) AS "Numero Treballadors"
FROM oficinas
JOIN repventas ON oficina_rep = oficina
GROUP BY ciudad, oficina
UNION
SELECT '	1-Caps:', ciudad, oficina, nombre, NULL
FROM oficinas
JOIN repventas ON oficina_rep = oficina
WHERE num_empl IN (106,104,108,101)
UNION
SELECT '		2-Treballadors:', ciudad, oficina, nombre, NULL
FROM oficinas
JOIN repventas ON oficina_rep = oficina
GROUP BY ciudad, oficina, nombre
ORDER BY 3,1 
;


--    	3. Llistar els noms i preus dels productes de la fàbrica imm i de la fàbrica rei que contenen 'gr' o 'tr' en el seu nom i que valen entre 
--		00 i 5000€, i els noms dels venedors que han venut aquests productes. Si algun producte no l'ha comprat ningú ha de sortir sense nom 
--      venedor.
SELECT '0-Productes: ' AS "concepte",descripcion, precio, NULL AS "Venedor"
FROM productos
WHERE id_fab IN ('rei', 'imm') and (descripcion ILIKE '%gr%' or descripcion ILIKE '%tr%') and precio BETWEEN 0 and 5000
UNION
SELECT '		1-Venedor:', descripcion, NULL, nombre
FROM productos
JOIN pedidos ON fab = id_fab and id_producto = producto
JOIN repventas ON num_empl = rep 
WHERE id_fab IN ('rei', 'imm') and (descripcion ILIKE '%gr%' or descripcion ILIKE '%tr%') and precio BETWEEN 0 and 5000
GROUP BY descripcion, nombre
ORDER BY 2 DESC,1 ;


--    	4. Llistar els noms dels productes, el número total de ventes que s'ha fet d'aquell producte, la quantitat total d'unitats que s'han venut 
--		d'aquell producte, i el nom de cada client que l'ha comprat.
SELECT 'Producto:' , descripcion, count(producto), sum(cant), NULL as "Empresa"
FROM productos
LEFT JOIN pedidos ON id_producto = producto
GROUP BY descripcion
UNION
SELECT '	Client: ', descripcion, NULL, NULL, empresa
FROM productos
LEFT JOIN pedidos ON id_producto = producto
JOIN clientes ON num_clie = clie
GROUP BY descripcion, empresa
ORDER BY descripcion, 1 DESC;

--    	5. Llistar els productes que costen més de 1000 o no són ni de la fàbrica imm ni de la fàbrica rei, ni de la fàbrica ací, 
--		i el total que n'ha comprat cada client. Si algun producte no l'ha comprat ningú ha de sortir sense nom de client.


--    	6. Llistar els codis de fabricants, el número total de productes d'aquell fabricant i el nom de cadascun dels productes.



--    	7. Llistar els venedors i els seus imports totals de ventes, que tinguin més de 30 anys i treballin a l'oficina 12 i els que tinguin més de 20 anys i treballin a l'oficina 21. 
--		Llistar els clients a qui ha venut cadascun d'aquests venedors
SELECT 'Venedor:' AS "concepte" ,nombre AS "Representant/Client", ventas
FROM repventas
WHERE (edad > 30 and oficina_rep = 12) or (edad > 20 and oficina_rep = 21)
UNION
SELECT '	Client:',empresa, NULL 
FROM repventas
JOIN pedidos ON num_empl = rep
JOIN clientes ON clie = num_clie
WHERE (edad > 30 and oficina_rep = 12) or (edad > 20 and oficina_rep = 21)
GROUP BY nombre,empresa,ventas
ORDER BY 2,1 DESC;
