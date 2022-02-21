-- 	PRÀCTICA 17. WHERE + GROUP BY + JOIN + UNION

/*
	1. Visualitzar tota la informació de cada client demanat,la quantitat de comandes que ha fet, la informació de les compres realitzades per cada client i el total d''import 
  	comprat per cada client. Si un client no ha comprat mai no s''han de mostrar els seus totals. La informació ha de sortir ordenada per codi de client. Els clients que es demanen són :

	Clients amb un nom acabat amb 'International' o amb un nom acabat amb 'Corp.' o amb un nom
	que no comenci ni en 'A' ni en 'B' ni en 'C' ni en 'D' ni en 'O' ni en 'P' ni en 'J'. 
*/
SELECT 'Client:' AS "concepte" ,clientes.*, NULL AS "Quantitat Comandes", NULL as "Numero Pedido",NULL as "Fecha Pedido",NULL as "Cliente",NULL as "Representant" ,NULL as "Fabrica",NULL as "ID producto",NULL AS "Cantidad", NULL as "Importe / Total"
FROM clientes
JOIN pedidos ON num_clie = clie and rep_clie = rep
WHERE (empresa LIKE '%International' or empresa LIKE '%Corp.') or (empresa NOT ILIKE 'A%' and empresa NOT ILIKE 'B%' and empresa NOT ILIKE 'C%' and empresa NOT ILIKE 'D%' and empresa NOT ILIKE 'O%' and empresa NOT ILIKE 'P%' and empresa NOT ILIKE 'J%' )
GROUP BY num_clie,empresa,rep_clie,limite_credito
UNION
SELECT '	Info Compra:', NULL, empresa,NULL,NULL , NULL , pedidos.*
FROM clientes
JOIN pedidos ON num_clie = clie and rep_clie = rep
JOIN productos ON id_fab = fab and id_producto = producto
WHERE (empresa LIKE '%International' or empresa LIKE '%Corp.') or (empresa NOT ILIKE 'A%' and empresa NOT ILIKE 'B%' and empresa NOT ILIKE 'C%' and empresa NOT ILIKE 'D%' and empresa NOT ILIKE 'O%' and empresa NOT ILIKE 'P%' and empresa NOT ILIKE 'J%' )
UNION
SELECT '			Total importe: ' ,NULL,empresa,NULL,NULL,count(*),NULL,NULL,NULL,NULL,NULL,NULL ,NULL, sum(importe)
FROM clientes
JOIN pedidos ON num_clie = clie and rep_clie = rep
JOIN productos ON id_fab = fab and id_producto = producto
WHERE (empresa LIKE '%International' or empresa LIKE '%Corp.') or (empresa NOT ILIKE 'A%' and empresa NOT ILIKE 'B%' and empresa NOT ILIKE 'C%' and empresa NOT ILIKE 'D%' and empresa NOT ILIKE 'O%' and empresa NOT ILIKE 'P%' and empresa NOT ILIKE 'J%' )
GROUP BY empresa
ORDER BY 3,1 ;




/*
	2. Visualitzar tota la informació de cada producte demanat i la quantitat de comandes fetes per aquell producte,
 	la informació de les ventes fetes de cada producte i el total de l''import venut de cada producte.
 	Si un producte no s'ha venut també ha de sortir.
 	La informació ha d'estar ordenada per codi de fàbrica i codi de producte.
 	Els productes que es demanen són :

	Productes de les fàbriques rei, aci i qsa amb preus entre 75 i 200.
*/

/*
	3. Visualitzar tota la informació de cada venedor demanat i la quantitat de comanes que ha fet;
	la informació de totes les ventes realitzades per cada venedor i el total d'import venut per cada venedor.
 	Si un venedor no ha venut res també s'ha de mostrar. La informació ha de sortir ordenada per codi de venedor.
 	Els venedors que es demanen són :

	Venedors majors de 32 anys, amb un nom començat per 'S' or per 'B' o per 'N'
*/

/*
	4. Visualitzar tota la informació de cada oficina demanada i el número de venedors que té;
 	la informació de tots els venedors assignats a la oficina i el número de cliens assignat a cada venedor
 	i la informació de tots els clients assignats a cada venedor.
 	Si una oficina no té venedors també ha de sortir.
 	Si un venedor no té clients assignats ha de sortir igualment.
 	La informació ha de sortir ordenada per codi d'oficina i codi de venedor.
 	Les oficines que es demanen són:

Oficines de ciutats que continguin alguna 'a' o alguna 'e' i amb un objectiu més gran de 300.000
*/