-- --------------------------------------------
--    CASE WHEN ELSE END
-- --------------------------------------------
-- Christian Manalo Mañibo -isx9565961

-- 1.- Llistar l'identificador i el nom dels representants de vendes. Mostrar un camp anomenat "result" que mostri 0 si la quota és inferior a les vendes, en cas contrari ha de 
-- mostrar 1 a no ser que sigui director d'oficina, en aquest cas ha de mostrar 2.
SELECT num_empl, nombre,
	CASE
		WHEN num_empl IN (
			SELECT director
			FROM repventas) THEN '2'
		WHEN cuota < ventas THEN '0'
		ELSE '1'
	END AS result
FROM repventas;
/*
 num_empl |    nombre     | result 
----------+---------------+--------
      105 | Bill Adams    | 0
      109 | Mary Jones    | 0
      102 | Sue Smith     | 0
      106 | Sam Clark     | 2
      104 | Bob Smith     | 2
      101 | Dan Roberts   | 2
      110 | Tom Snyder    | 1
      108 | Larry Fitch   | 2
      103 | Paul Cruz     | 0
      107 | Nancy Angelli | 1
(10 rows)
*/
-- 2.- Llistar tots els productes amb totes les seves dades afegint un nou camp anomenat "div". El camp div ha de contenir el resultat de la divisió entre el preu i les existències. 
-- En cas de divisió per zero, es canviarà el resultat a 0.
SELECT *, 
	CASE
		WHEN existencias = 0 THEN '0'
		ELSE round((precio/existencias),2)
	END AS div
FROM productos;
/*
 id_fab | id_producto |    descripcion    | precio  | existencias |  div   
--------+-------------+-------------------+---------+-------------+--------
 rei    | 2a45c       | V Stago Trinquete |   79.00 |         210 |   0.38
 aci    | 4100y       | Extractor         | 2750.00 |          25 | 110.00
 qsa    | xk47        | Reductor          |  355.00 |          38 |   9.34
 bic    | 41672       | Plate             |  180.00 |           0 |      0
 imm    | 779c        | Riostra 2-Tm      | 1875.00 |           9 | 208.33
 aci    | 41003       | Articulo Tipo 3   |  107.00 |         207 |   0.52
 aci    | 41004       | Articulo Tipo 4   |  117.00 |         139 |   0.84
 bic    | 41003       | Manivela          |  652.00 |           3 | 217.33
 imm    | 887p        | Perno Riostra     |  250.00 |          24 |  10.42
 qsa    | xk48        | Reductor          |  134.00 |         203 |   0.66
 rei    | 2a44l       | Bisagra Izqda.    | 4500.00 |          12 | 375.00
 fea    | 112         | Cubierta          |  148.00 |         115 |   1.29
 imm    | 887h        | Soporte Riostra   |   54.00 |         223 |   0.24
 bic    | 41089       | Retn              |  225.00 |          78 |   2.88
 aci    | 41001       | Articulo Tipo 1   |   55.00 |         277 |   0.20
 imm    | 775c        | Riostra 1-Tm      | 1425.00 |           5 | 285.00
 aci    | 4100z       | Montador          | 2500.00 |          28 |  89.29
 qsa    | xk48a       | Reductor          |  117.00 |          37 |   3.16
 aci    | 41002       | Articulo Tipo 2   |   76.00 |         167 |   0.46
 rei    | 2a44r       | Bisagra Dcha.     | 4500.00 |          12 | 375.00
 imm    | 773c        | Riostra 1/2-Tm    |  975.00 |          28 |  34.82
 aci    | 4100x       | Ajustador         |   25.00 |          37 |   0.68
 fea    | 114         | Bancada Motor     |  243.00 |          15 |  16.20
 imm    | 887x        | Retenedor Riostra |  475.00 |          32 |  14.84
 rei    | 2a44g       | Pasador Bisagra   |  350.00 |          14 |  25.00
(25 rows)*/
-- 3.- Afegir una condició a la sentència de l'exercici anterior per tal de nomès mostrar aquells productes que el valor del camp div és menor a 1.
SELECT *, 
	CASE
		WHEN existencias = 0 THEN '0'
		ELSE round((precio/existencias),2)
	END AS "div"
FROM productos
WHERE 
	CASE
		WHEN existencias = 0 THEN '0'
		ELSE round((precio/existencias),2)
	END  < 1;
/*
 id_fab | id_producto |    descripcion    | precio | existencias | div  
--------+-------------+-------------------+--------+-------------+------
 rei    | 2a45c       | V Stago Trinquete |  79.00 |         210 | 0.38
 bic    | 41672       | Plate             | 180.00 |           0 |    0
 aci    | 41003       | Articulo Tipo 3   | 107.00 |         207 | 0.52
 aci    | 41004       | Articulo Tipo 4   | 117.00 |         139 | 0.84
 qsa    | xk48        | Reductor          | 134.00 |         203 | 0.66
 imm    | 887h        | Soporte Riostra   |  54.00 |         223 | 0.24
 aci    | 41001       | Articulo Tipo 1   |  55.00 |         277 | 0.20
 aci    | 41002       | Articulo Tipo 2   |  76.00 |         167 | 0.46
 aci    | 4100x       | Ajustador         |  25.00 |          37 | 0.68
(9 rows)
*/
-- 4.- Mostrar per a cada empleat el seu nom i al costat un columna anomenada "dirigeix?" que digui si és director d'algú ("dirigent") o no ("no dirigeix")
SELECT nombre, 
	CASE
		WHEN num_empl IN (
			SELECT director
			FROM repventas) THEN 'dirigent'
		ELSE 'no dirigeix'
	END AS "dirigeix?"
FROM repventas;
/*
    nombre     |  dirigeix?  
---------------+-------------
 Bill Adams    | no dirigeix
 Mary Jones    | no dirigeix
 Sue Smith     | no dirigeix
 Sam Clark     | dirigent
 Bob Smith     | dirigent
 Dan Roberts   | dirigent
 Tom Snyder    | no dirigeix
 Larry Fitch   | dirigent
 Paul Cruz     | no dirigeix
 Nancy Angelli | no dirigeix
(10 rows)*/

-- 5.- Mostrar per a cada producte totes les sevs dades, i a la dreta un camp titulat "Alerta existències" on, si la suma de les quantitats de dues últimes comandes (en direm N) s
-- upera les existències actuals, hi surti el missatge "ALERTA: últimes comandes sumen N")(on N és el número que hem anomenat abans). Si no, que no hi surti res a la columna

-- Per exemple:
/*
 id_fab | id_producto |    descripcion    | precio  | existencias |         Alerta existències          
--------+-------------+-------------------+---------+-------------+-------------------------------------
...
 aci    | 41001       | Articulo Tipo 1   |   55.00 |         277 | 
 imm    | 775c        | Riostra 1-Tm      | 1425.00 |           5 | ALERTA: últimes 2 comandes sumen 22
 aci    | 4100z       | Montador          | 2500.00 |          28 | 
...
*/
SELECT *,
	CASE
		WHEN ? > existencias THEN 'ALERTA: últimes 2 comandes sumen ' || ? 
		ELSE NULL
	END AS "Alerta existències"
FROM productos;

-- Només em falta posar la sentencia per conseguir els 2 ultims comandes



	-- aquest últim exercici és força complex. Si no te'n surts (però intenta-ho, els elements per fer-lo us els he donat encara que algun sigui de 'resquilón'), no et preocupis.



