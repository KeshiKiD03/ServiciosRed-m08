-- Christian Manalo - isx9565961
-- --------------------------------------------
--    Funcions predefinides
-- --------------------------------------------

-- 10.1- Mostreu la longitud de la cadena "hola que tal"
SELECT char_length('hola que tal');
 char_length 
-------------
          12
(1 fila)

-- 10.2- Mostreu la longitud dels valors del camp "id_producto".
SELECT char_length(id_producto) FROM productos;
char_length 
-------------
           5
           5
           4
           5
           4
           5
           5
           5
           4
           4
           5
           3
           4
           5
           5
           4
           5
           5
           5
           5
           4
           5
           3
           4
           5
(25 filas
-- 10.3- Mostrar la longitud dels valors del camp "descripcion".
SELECT char_length(descripcion) FROM productos;
 char_length 
-------------
          17
           9
           8
           5
          12
          15
          15
           8
          13
           8
          14
           8
          15
           4
          15
          12
           8
           8
          15
          13
          14
           9
          13
          17
          15
(25 filas)

-- 10.4- Mostreu els noms dels venedors en majúscules.
SELECT upper(nombre) as upper_nom FROM  repventas;
   upper_nom     
---------------
 BILL ADAMS
 MARY JONES
 SUE SMITH
 SAM CLARK
 BOB SMITH
 DAN ROBERTS
 TOM SNYDER
 LARRY FITCH
 PAUL CRUZ
 NANCY ANGELLI
(10 filas)

-- 10.5- Mostreu els noms dels venedors en minúscules.
SELECT lower(nombre) as lower_nom FROM repventas;
   lower_nom     
---------------
 bill adams
 mary jones
 sue smith
 sam clark
 bob smith
 dan roberts
 tom snyder
 larry fitch
 paul cruz
 nancy angelli
(10 filas)

-- 10.6- Trobeu on és la posició de l'espai en blanc de la cadena 'potser 7'.
SELECT position(' ' in 'potser 7');
 position 
----------
        7
(1 fila)

-- 10.7- Volem mostrar el nom, només el nom dels venedors sense el cognom, en majúscules.
SELECT upper(left(nombre, position(' ' in nombre)-1)) as nom FROM repventas ;
 nom 
-------
 BILL
 MARY
 SUE
 SAM
 BOB
 DAN
 TOM
 LARRY
 PAUL
 NANCY
(10 filas)

SELECT upper(split_part(nombre, ' ', 1)) as nom FROM repventas;
 nom 
-------
 BILL
 MARY
 SUE
 SAM
 BOB
 DAN
 TOM
 LARRY
 PAUL
 NANCY
(10 filas)
-- 10.8- Crear una consulta que mostri l'identificador dels representants de vendes i en columnes separades el nom i el cognom.
SELECT num_empl,split_part(nombre,' ', 1) as nom, split_part(nombre,' ', 2) as cognom FROM repventas;
 num_empl |  nom  | cognom  
----------+-------+---------
      105 | Bill  | Adams
      109 | Mary  | Jones
      102 | Sue   | Smith
      106 | Sam   | Clark
      104 | Bob   | Smith
      101 | Dan   | Roberts
      110 | Tom   | Snyder
      108 | Larry | Fitch
      103 | Paul  | Cruz
      107 | Nancy | Angelli
(10 filas)

-- 10.9- Mostreu els valors del camp nombre de manera que 'Bill Adams' sorti com 'B. Adams'.
 SELECT substring(nombre from 1 for 1)||'. '|| split_part(nombre,' ', 2) as nombre  FROM repventas;
   nombre   
------------
 B. Adams
 M. Jones
 S. Smith
 S. Clark
 B. Smith
 D. Roberts
 T. Snyder
 L. Fitch
 P. Cruz
 N. Angelli
(10 filas)

-- 10.10- Mostreu els valors del camp nombre de manera que 'Bill Adams' sorti com 'Adams, Bill'.
SELECT split_part(nombre,' ', 2) || ', ' || split_part(nombre,' ', 1) as cognom_nom FROM repventas;
   cognom_nom   
----------------
 Adams, Bill
 Jones, Mary
 Smith, Sue
 Clark, Sam
 Smith, Bob
 Roberts, Dan
 Snyder, Tom
 Fitch, Larry
 Cruz, Paul
 Angelli, Nancy
(10 filas)

-- 10.11- Volem mostrar el camp descripcion de la taula productos però que en comptes de sortir espais en blanc, volem subratllats ('_').
SELECT replace(descripcion, ' ', '_') as descripcion FROM productos;

-- 10.12- Volem treure per pantalla una columna, que conté el nom i les vendes, amb els següent estil:
--   vendes dels empleats
-- ---------------------------
--  Bill Adams..... 367911,00
--  Mary Jones..... 392725,00
--  Sue Smith...... 474050,00
--  Sam Clark...... 299912,00
--  Bob Smith...... 142594,00
--  Dan Roberts.... 305673,00
--  Tom Snyder.....  75985,00
--  Larry Fitch.... 361865,00
--  Paul Cruz...... 286775,00
--  Nancy Angelli.. 186042,00
-- (10 rows)
select concat(rpad(nombre,15,'.'),' ',ventas) as "vendes dels empleats" from repventas;
   vendes dels empleats    
---------------------------
 Bill Adams..... 367911.00
 Mary Jones..... 392725.00
 Sue Smith...... 474050.00
 Sam Clark...... 299912.00
 Bob Smith...... 142594.00
 Dan Roberts.... 305673.00
 Tom Snyder..... 75985.00
 Larry Fitch.... 361865.00
 Paul Cruz...... 286775.00
 Nancy Angelli.. 186042.00
(10 filas)


-- 10.13- Treieu per pantalla el temps total que fa que estan contractats els treballadors, ordenat pels cognoms dels treballadors amb un estil semblant al següent:
--       nombre  |     tiempo_trabajando
--    -----------+-------------------------
--    Mary Jones | 13 years 4 months 6 days
select nombre , age(contrato) as "tiempo_trabajando" FROM repventas;
    nombre     |    tiempo_trabajando     
---------------+--------------------------
 Bill Adams    | 32 years 2 mons 13 days
 Mary Jones    | 30 years 6 mons 13 days
 Sue Smith     | 33 years 4 mons 15 days
 Sam Clark     | 31 years 10 mons 11 days
 Bob Smith     | 32 years 11 mons 6 days
 Dan Roberts   | 33 years 6 mons 5 days
 Tom Snyder    | 30 years 3 mons 12 days
 Larry Fitch   | 30 years 6 mons 13 days
 Paul Cruz     | 33 years 1 mon 24 days
 Nancy Angelli | 31 years 5 mons 11 days
(10 filas)

-- 10.14- Cal fer un llistat dels productes dels quals les existències són inferiors al total d'unitats venudes d'aquell 
-- producte els darrers 60 dies, a comptar des de la data actual. Cal mostrar els codis de fabricant i de producte, les existències, 
-- i les unitats totals venudes dels darrers 60 dies.
select fab, producto, existencias, sum(cant)
FROM pedidos JOIN productos on fab= id_fab and id_producto = producto
where fecha_pedido >= current_date - '60 days'::interval
group by fab, producto, existencias;

-- 10.15- Com l'exercici anterior però en comptes de 60 dies ara es volen aquells productes venuts durant el mes actual o durant l'anterior.
select fab, producto, existencias, sum(cant)
FROM pedidos JOIN productos on fab= id_fab and id_producto = producto
where (fecha_pedido >= date_trunc('month', (select max(fecha_pedido) from pedidos) - interval '1 month'))
group by fab, producto, existencias;

-- 10.16- Per fer un estudi previ de la campanya de Nadal es vol un llistat on, per cada any del qual hi hagi comandes a la base de dades, 
-- el nombre de clients diferents que hagin fet comandes en el mes de desembre d'aquell any. Cal mostrar l'any i el número de clients,
-- ordenat ascendent per anys.
?

-- 10.17- Llisteu codi(s) i descripció dels productes. La descripció ha d'aperèixer en majúscules. 
-- Ha d'estar ordenat per la longitud de les descripcions (les més curtes primer).
SELECT id_producto , upper(descripcion) as descripcion
FROM productos
ORDER BY length(id_producto) ;
 id_producto |       descripcion       
-------------+-------------------
 112         | CUBIERTA
 114         | BANCADA MOTOR
 779c        | RIOSTRA 2-TM
 887h        | SOPORTE RIOSTRA
 773c        | RIOSTRA 1/2-TM
 xk47        | REDUCTOR
 887x        | RETENEDOR RIOSTRA
 775c        | RIOSTRA 1-TM
 887p        | PERNO RIOSTRA
 xk48        | REDUCTOR
 xk48a       | REDUCTOR
 41002       | ARTICULO TIPO 2
 2a44r       | BISAGRA DCHA.
 4100x       | AJUSTADOR
 2a45c       | V STAGO TRINQUETE
 2a44g       | PASADOR BISAGRA
 4100y       | EXTRACTOR
 41672       | PLATE
 41003       | ARTICULO TIPO 3
 41004       | ARTICULO TIPO 4
 41003       | MANIVELA
 2a44l       | BISAGRA IZQDA.
 41089       | RETN
 41001       | ARTICULO TIPO 1
 4100z       | MONTADOR
(25 filas)


-- 10.18- LListar el nom dels treballadors i la data del seu contracte mostrant-la amb el següent format:
-- Dia_de_la_setmana dia_mes_numeric, mes_text del any_4digits
-- per exemple:
-- Bill Adams    | Friday    12, February del 1988
SELECT nombre, to_char(contrato, 'Day DD, Month "del" YYYY') as "contrato"
FROM repventas;
    nombre     |             contrato             
---------------+----------------------------------
 Bill Adams    | Friday    12, February  del 1988
 Mary Jones    | Thursday  12, October   del 1989
 Sue Smith     | Wednesday 10, December  del 1986
 Sam Clark     | Tuesday   14, June      del 1988
 Bob Smith     | Tuesday   19, May       del 1987
 Dan Roberts   | Monday    20, October   del 1986
 Tom Snyder    | Saturday  13, January   del 1990
 Larry Fitch   | Thursday  12, October   del 1989
 Paul Cruz     | Sunday    01, March     del 1987
 Nancy Angelli | Monday    14, November  del 1988
(10 filas)

-- 10.19- Modificar els imports de les comandes que s'han realitzat durant l'estiu augmentant-lo un 20% i arrodonint a l'alça el resultat.
?

-- 10.20- Mostar les dades de les oficines llistant en primera instància aquelles oficines que tenen una desviació entre vendes i objectius més gran.
?

-- 10.21- Llistar les dades d'aquells representants de vendes que tenen un identificador senar i són directors d'algun representants de vendes.
?

