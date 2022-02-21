--  Christian Manalo Mañibo
-- isx9565961

--1. Donar data i hora actual del sistema en format dd/MM/aaaa-hh:mm:ss
select to_char(current_timestamp,'DD"/"MM"/"YYYY"-"hh24":"mi":"ss') AS hora_sistema;

    hora_sistema     
---------------------
 05/05/2020-17:01:21
(1 row)

--2. Donar hora actual en format hh:mm:ss
select  to_char(current_timestamp, 'HH24:MI:SS') AS hora_actual;
 hora_actual 
-------------
 17:03:36
(1 row)
--3. Determinar la durada de cada contracte fins avui en dies. S'ha de mostrar el nom del treballador, la data del contracte i la durada.
select nombre, contrato, extract(days from (now() - contrato)) AS "durada"
from repventas;

    nombre     |  contrato  | durada 
---------------+------------+--------
 Bill Adams    | 1988-02-12 |  11771
 Mary Jones    | 1989-10-12 |  11163
 Sue Smith     | 1986-12-10 |  12200
 Sam Clark     | 1988-06-14 |  11648
 Bob Smith     | 1987-05-19 |  12040
 Dan Roberts   | 1986-10-20 |  12251
 Tom Snyder    | 1990-01-13 |  11070
 Larry Fitch   | 1989-10-12 |  11163
 Paul Cruz     | 1987-03-01 |  12119
 Nancy Angelli | 1988-11-14 |  11495
(10 rows)


--4. Determinar la suma total de les durades de tots els contractes dels treballadors en dies fins avui.
select nombre, contrato, extract(days from (now() - contrato)) AS "durada"
from repventas
UNION
select 'TOTAL:', NULL, sum(extract(days from (now() - contrato))) AS "durada"
from repventas
ORDER BY 2;
    nombre     |  contrato  | durada 
---------------+------------+--------
 Dan Roberts   | 1986-10-20 |  12251
 Sue Smith     | 1986-12-10 |  12200
 Paul Cruz     | 1987-03-01 |  12119
 Bob Smith     | 1987-05-19 |  12040
 Bill Adams    | 1988-02-12 |  11771
 Sam Clark     | 1988-06-14 |  11648
 Nancy Angelli | 1988-11-14 |  11495
 Larry Fitch   | 1989-10-12 |  11163
 Mary Jones    | 1989-10-12 |  11163
 Tom Snyder    | 1990-01-13 |  11070
 TOTAL:        |            | 116920

--5. Determinar la diferència de temps treballat entre cadascun dels treballadors amb el treballador més antic. S'ha de mostrar el nom del treballador, 
-- la data del contracte i la diferència.

-- Qui porta mes temps 
SELECT nombre, contrato from repventas order by 2 limit 1;
   nombre    |  contrato  
-------------+------------
 Dan Roberts | 1986-10-20
(1 row)

-- Solucio
select nombre, contrato, extract(days from (timestamp '1986-10-20' - contrato)) AS "diferencia"
from repventas ORDER BY 3 DESC;

    nombre     |  contrato  | diferencia 
---------------+------------+------------
 Dan Roberts   | 1986-10-20 |          0
 Sue Smith     | 1986-12-10 |        -51
 Paul Cruz     | 1987-03-01 |       -132
 Bob Smith     | 1987-05-19 |       -211
 Bill Adams    | 1988-02-12 |       -480
 Sam Clark     | 1988-06-14 |       -603
 Nancy Angelli | 1988-11-14 |       -756
 Larry Fitch   | 1989-10-12 |      -1088
 Mary Jones    | 1989-10-12 |      -1088
 Tom Snyder    | 1990-01-13 |      -1181
(10 rows)


-- Nota: He intentat fer-ho amb una subconsulta pero no em deixaba, no se que falla.
select nombre, contrato, extract(days from (timestamp '(SELECT contrato from repventas order by 1 limit 1))' - contrato)) AS "diferencia"
from repventas;

--6. Calcular el nombre de comandes fetes el desembre pels representants de vendes contractats el mes de febrer.

--7. Llistar el número de treballadors que s'han contractat per a cada mes de l'any. El llistat ha d'estar ordenat pel mes. Ha de tenir el següent format:

 mes_de_contractació | numero_contractes 
---------------------+------------------
                   1 |                1
                   2 |                1
                   3 |                1
...


9.- LListar el nom dels treballadors i la data del seu contracte mostrant-la amb el següent format:

    Bill Adams, contractat el divendres 12 de febrer del 1988
    
	--Nota: l'idioma ha de ser el de la localització del servidor postgres. Si és en català, els mesos que comencen amb vocal surten amb d' (per exemple "25 d'abril")
select nombre || ', ' ||to_char(contrato, '"contractat el "Day DD "de" Month "del" YYYY') AS "Empleat" from repventas;
                             Empleat                             
-----------------------------------------------------------------
 Bill Adams, contractat el Friday    12 de February  del 1988
 Mary Jones, contractat el Thursday  12 de October   del 1989
 Sue Smith, contractat el Wednesday 10 de December  del 1986
 Sam Clark, contractat el Tuesday   14 de June      del 1988
 Bob Smith, contractat el Tuesday   19 de May       del 1987
 Dan Roberts, contractat el Monday    20 de October   del 1986
 Tom Snyder, contractat el Saturday  13 de January   del 1990
 Larry Fitch, contractat el Thursday  12 de October   del 1989
 Paul Cruz, contractat el Sunday    01 de March     del 1987
 Nancy Angelli, contractat el Monday    14 de November  del 1988
(10 rows)

-- Nota:; Jo el tinc en anglés no se com fer-ho