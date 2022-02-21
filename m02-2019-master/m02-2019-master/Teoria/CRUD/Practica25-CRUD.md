# CRUD - Create, Read, Update, Delete

L'acrònim CRUD recull aquestes 4 operacions sobre una BD. Fins ara ens hem estat centrant únicament en la R de *Read*, o sigui, fer consultes.

Ara passarem a les altres tres. No veurem totes les opcions, sinó només el funcionament més bàsic.

Atès que modificarem la BD, el millor és fer-ho sobre una còpia. Per generar una còpia de la BD de `training`, utilitzarem aquesta comanda:

```sql
CREATE DATABASE training2 TEMPLATE training;
-- i ens connectem a la nova BD:
\c training2
```

*Nota: això ho podem fer perquè estem utilitzant l'usuari postgres, que té permís per fer qualsevol cosa*

# Còpia d'una taula

## Contingut i estructura (és a dir: camps, tipus de dades, i dades, però no restriccions...):

Utilitzem la comanda [CREATE TABLE AS](https://www.postgresql.org/docs/current/sql-createtableas.html)
```sql
CREATE TABLE repventas2 AS TABLE repventas;

--llistem les taules de la BD:
\dt

           List of relations
 Schema |    Name    | Type  |  Owner   
--------+------------+-------+----------
 public | clientes   | table | postgres
 public | oficinas   | table | postgres
 public | pedidos    | table | postgres
 public | productos  | table | postgres
 public | repventas  | table | postgres
 public | repventas2 | table | postgres
(6 rows)

--llistem el contingut:
select * from repventas2;

num_empl |    nombre     | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   
----------+---------------+------+-------------+------------+------------+----------+-----------+-----------
     105 | Bill Adams    |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00
     109 | Mary Jones    |   31 |          11 | Rep Ventas | 1989-10-12 |      106 | 300000.00 | 392725.00
....
     107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00
(10 rows)

--  Mirem els detalls de la taula repventas2 recentment creada:
\d repventas2

Table "public.repventas2"
Column    |         Type          | Collation | Nullable | Default
-------------+-----------------------+-----------+----------+---------
num_empl    | smallint              |           |          |
nombre      | character varying(15) |           |          |
edad        | smallint              |           |          |
oficina_rep | smallint              |           |          |
titulo      | character varying(10) |           |          |
contrato    | date                  |           |          |
director    | smallint              |           |          |
cuota       | numeric(8,2)          |           |          |
ventas      | numeric(8,2)          |           |          |

```
Veiem que s'han copiat els camps i els tipus de dades. Però s'ha copiat tot? No: no s'han copiat les restriccions ni la definició de clau primària (ni altres índex en cas d'haver-n'hi).
Les restriccions són quelcom que no hem vist fins ara, perquè principalment afecten a l'hora de modificar les taules. Al llistat d'abans, tindríem `Nullable` i també la propietat `Default`, que és el valor que pren el camp quan inserim un registre nou a la taula sense donar-li un valor a aquell camp.

Fixa't què retorna si mirem els detalls de la taula `repventas` original:

```sql
\d repventas

                       Table "public.repventas"
   Column    |         Type          | Collation | Nullable | Default
-------------+-----------------------+-----------+----------+---------
 num_empl    | smallint              |           | not null |
 nombre      | character varying(15) |           | not null |
 edad        | smallint              |           |          |
 oficina_rep | smallint              |           |          |
 titulo      | character varying(10) |           |          |
 contrato    | date                  |           | not null |
 director    | smallint              |           |          |
 cuota       | numeric(8,2)          |           |          |
 ventas      | numeric(8,2)          |           | not null |
Indexes:
    "repventas_pkey" PRIMARY KEY, btree (num_empl)
```

Veiem que a part de la clau primària, tampoc s'ha copiat la restricció `Nullable`, que vol dir que si quan li afegim dades (o les modifiquem), admetem que el valor corresponent a aquella columna (camp) sigui nul. `Defaul` (aquí tots en blanc) significa quin valor per defecte posem al camp si quan inserim dades no n'especifiquem cap.
No et preocupis de moment per això de la clau primària: ho veuràs a 2on, a la UF1

## Copiar l'estructura, amb restriccions, però sense dades:

Utilitzem la comanda [CREATE TABLE](https://www.postgresql.org/docs/current/sql-createtable.html) d'una manera especial:

```sql
CREATE TABLE repventas3 (like repventas);
--i després li hem d'inserir manualment les dades, agafant-les de repventas:
insert into repventas3 (select * from repventas);
--INSERT 0 10
```

Això no ens ha posat la clau primària, emperò. L'hauríem de posar manualment.


## A partir d'una consulta

Podem crear una taula nova a partir d'una consulta ([CREATE TABLE AS](https://www.postgresql.org/docs/current/sql-createtableas.html)). Tindrà els camps d'aquesta, però cap restricció (com ara claus primàries o forànies). La consulta pot ser senzilla:

```sql
create table repventas4 as select * from repventas;
--SELECT 10
select * from repventas4;
 num_empl |    nombre     | edad | oficina_rep |   titulo   |  contrato  | director |   cuota   |  ventas   
----------+---------------+------+-------------+------------+------------+----------+-----------+-----------
      105 | Bill Adams    |   37 |          13 | Rep Ventas | 1988-02-12 |      104 | 350000.00 | 367911.00
      109 | Mary Jones    |   31 |          11 | Rep Ventas | 1989-10-12 |      106 | 300000.00 | 392725.00
....
      107 | Nancy Angelli |   49 |          22 | Rep Ventas | 1988-11-14 |      108 | 300000.00 | 186042.00
(10 rows)

--mirem els detalls i veurem que NO s'ha copiat la restricció de no ser null els camps que la tenien:
\d repventas4

                      Table "public.repventas3"
   Column    |         Type          | Collation | Nullable | Default
-------------+-----------------------+-----------+----------+---------
 num_empl    | smallint              |           |          |
 nombre      | character varying(15) |           |          |
 edad        | smallint              |           |          |
 oficina_rep | smallint              |           |          |
 titulo      | character varying(10) |           |          |
 contrato    | date                  |           |          |
 director    | smallint              |           |          |
 cuota       | numeric(8,2)          |           |          |
 ventas      | numeric(8,2)          |           |          |
```

També podem crear una taula a partir d'una consulta complexa. Important: aquesta taula es copia en el moment, però no s'actualitza després si canviem les dades d'origen. Si volguéssim que això passés, aleshores crearíem una ***vista***, que és una taula virtual que es crea en funció d'una consulta, i el "contingut" de la qual es va actualitzant a mida que canvien les taules origen d'aquesta vista. Això no crec que tinguem temps de veure-ho, però si tens curiositat, pots consultar la documentació [aquí](https://www.postgresql.org/docs/current/sql-createview.html).

Creem una taula a partir d'una consulta més complexa:

```SQL
create table vendes89 as
    select num_pedido as "idPedido", fecha_pedido, clie as "idCliente", empresa,
           rep as "idRepresentante", nombre, ciudad, cant, importe
    from pedidos join clientes on clie=num_clie
        join repventas on rep=num_empl
        left join oficinas on oficina_rep = oficina
    where extract ('year' from fecha_pedido) = 1989;
--SELECT 9

select * from vendes89;

 idPedido | fecha_pedido | idCliente |     empresa      | idRepresentante |   nombre    |   ciudad    | cant | importe  
----------+--------------+-----------+------------------+-----------------+-------------+-------------+------+----------
   112975 | 1989-12-12   |      2111 | JCP Inc.         |             103 | Paul Cruz   | Chicago     |    6 |  2100.00
   112968 | 1989-10-12   |      2102 | First Corp.      |             101 | Dan Roberts | Chicago     |   34 |  3978.00
   112963 | 1989-12-17   |      2103 | Acme Mfg.        |             105 | Bill Adams  | Atlanta     |   28 |  3276.00
   112983 | 1989-12-27   |      2103 | Acme Mfg.        |             105 | Bill Adams  | Atlanta     |    6 |   702.00
   112987 | 1989-12-31   |      2103 | Acme Mfg.        |             105 | Bill Adams  | Atlanta     |   11 | 27500.00
   112979 | 1989-10-12   |      2114 | Orion Corp       |             102 | Sue Smith   | Los Angeles |    6 | 15000.00
   112961 | 1989-12-17   |      2117 | J.P. Sinclair    |             106 | Sam Clark   | New York    |    7 | 31500.00
   112993 | 1989-01-04   |      2106 | Fred Lewis Corp. |             102 | Sue Smith   | Los Angeles |   24 |  1896.00
   112992 | 1989-11-04   |      2118 | Midwest Systems  |             108 | Larry Fitch | Los Angeles |   10 |   760.00
(9 rows)
```

# INSERT
La comanda [INSERT](https://www.postgresql.org/docs/current/sql-insert.html) serveix per afegir registres (files) a una taula.

No sempre hem de posar dades a tots els camps de la taula (sí que haurem d'especificar aquells que no puguin ser nuls, o ens donarà error). Podem especificar a quins camps (l'ordre és indiferent). Una ordre `insert` pot afegir més d'un registre a la taula.

Fixem-nos amb la taula repventas i els camps, tipus de dades i restriccions que té. Tornem a fer la comanda d'abans:
```sql
\d repventas
                       Table "public.repventas"
   Column    |         Type          | Collation | Nullable | Default
-------------+-----------------------+-----------+----------+---------
 num_empl    | smallint              |           | not null |
 nombre      | character varying(15) |           | not null |
 edad        | smallint              |           |          |
 oficina_rep | smallint              |           |          |
 titulo      | character varying(10) |           |          |
 contrato    | date                  |           | not null |
 director    | smallint              |           |          |
 cuota       | numeric(8,2)          |           |          |
 ventas      | numeric(8,2)          |           | not null |
Indexes:
    "repventas_pkey" PRIMARY KEY, btree (num_empl)
```

Anem a inserir una treballadora anomenada Frederica Montseny, que no estarà assignada a cap oficina ni tindrà quota ni director, i les vendes seran 0. La data del contracte serà l'actual, el títol 'Rep desub' i el num_empl el posarem a 200 (res ens obliga a continuar la sèrie, però hem d'anar amb compte quan el camp clau no "creix sol" com quan és de tipus `serial`):

Dues maneres de fer-ho. A la primera, diem cada valor a quin camp correspon (primer posem els camps entre parèntesis i després els valors, seguint l'ordre dels camps que hem indicat). A la segona, no indiquem els camps, i aleshores l'ordre ha de ser el del llistat d'abans:

```sql
INSERT INTO repventas2 (nombre, num_empl, edad, titulo, contrato, ventas)
    VALUES ('Annie Jump', 200, 63, 'Rep desub', current_date, 0);
--INSERT 0 1
--nota: El segon nombre ens indica el número de files inserides.
--      Pel primer, `OID`, no cal saber-ho (pots mirar la documentació).

select * from repventas where num_empl = 200;
 num_empl |   nombre   | edad | oficina_rep |  titulo   |  contrato  | director | cuota | ventas
----------+------------+------+-------------+-----------+------------+----------+-------+--------
      200 | Annie Jump |   63 |             | Rep desub | 2020-05-16 |          |       |   0.00
(1 row)
```

D'aquest exemple podem veure que hem posat un ordre de camps al INSERT diferent del de la definició de la taula, però no passa res, es pot. També que no hem especificat tots els camps. Aquells que no, han quedat NULL.

Una altra manera de fer l'INSERT:

```sql
--primer esborrem el registre anterior per tornar-lo a crear
--  (no podríem inserir el mateix perquè num_empl és clau primària i, per tant,
--  no poden haver dos registres amb el mateix valor en aquest camp):

DELETE from repventas where  num_empl=200;
--DELETE 1

--fem l'INSERT, ara respectant l'ordre dels camps

INSERT INTO repventas2 VALUES (200, 'Annie Jump', 63, NULL, 'Rep desub', current_date, NULL, NULL, 0);
--INSERT 0,1
```

Fixa't en l'error que hauríem obtingut si haguéssim intentat fer aquest INSERT, on li falten camps:

```sql
INSERT INTO repventas VALUES (200, 'Annie Jump', 63, NULL, 'Rep desub');
ERROR:  null value in column "ventas" violates not-null constraint
DETAIL:  Failing row contains (200, Annie Jump, 63, null, Rep desub, 2020-05-16, null, null, null).
```

Si t'hi fixes, ha completat els camps que fataven amb nuls, i el problema és que el camp ventas no admet valors nuls (mira als detalls de dalt).

# DELETE

És molt senzill. Serveix per esborrar registres d'una taula (només una) que compleixin la condició especificada amb `WHERE`.

Ja hem vist abans com hem esborrat abans la nova treballadora inserida. Ara anem a esborrar aquells clients pels quals no tenim cap comanda:

```SQL
-- mirem quantes comandes té cada client i veurem que n'hi ha uns quants que en tenen 0:
select clientes.empresa, count(num_pedido) from clientes left join pedidos on clie=num_clie group by empresa;
empresa      | count
-------------------+-------
Chen Associates   |     1
Ian & Schmidt     |     1
Solomon Inc.      |     0
JCP Inc.          |     3
...
Acme Mfg.         |     4
Zetacorp          |     2
(21 rows)

--podem llistar els clients que NO tenen cap comanda o bé filtrant tot indicant que el count sigui 0, o bé d'aquesta altra manera:
select * from clientes where num_clie not in (select clie from pedidos);
num_clie |     empresa     | rep_clie | limite_credito
----------+-----------------+----------+----------------
    2123 | Carter & Sons   |      102 |       40000.00
    2115 | Smithson Corp.  |      101 |       20000.00
    2121 | QMA Assoc.      |      103 |       45000.00
    2122 | Three-Way Lines |      105 |       30000.00
    2119 | Solomon Inc.    |      109 |       25000.00
    2105 | AAA Investments |      101 |       45000.00
(6 rows)

I ja podem pensar doncs que una bona manera de fer el `delete` serà:

delete from clientes
  where num_clie not in (select clie from pedidos);
--DELETE 6
```
Ens diu quants registres ha esborrat. ÉS MOLT IMPORTANT provar abans de fer un delete la condició amb un select, o correm el risc d'esborrar moltes coses que no volíem. I malauradament no tenim un Ctrl-Z per recuperar les dades!

Comprovem que ja no hi són:

```sql
select * from clientes where num_clie not in (select clie from pedidos);
 num_clie | empresa | rep_clie | limite_credito
----------+---------+----------+----------------
(0 rows)
```

#UPDATE

L'[UPDATE](https://www.postgresql.org/docs/current/sql-update.html) serveix per actualitzar els valors d'un o més registres. Ens la podem imaginar com una barreja entre l'`insert` i el'`delete` (o el `select`): per una banda diem quins camps canvien i a quins valors, i per altra indiquem quines condicions tenen els registres (o el registre) pel qual fem aquests canvis.

La forma general (senzilla) és:

```SQL
UPDATE nom_taula
  SET (camp1 = valor, camp2 = valor2...)
  WHERE condició;
```

Si només hi ha un camp, no cal posar parèntesis.

Per exemple: suposem que ara volem assignar a la nova treballadora Annie Jump les empreses que porta el director, perquè el director vol ocupar-se d'altres assumptes. Sabem que el director és el Sam Clark, així que podríem fer:

```SQL
update clientes
  set rep_clie=200
  where rep_clie = 106;
--UPDATE 2
```

També podem fer coses com aquesta: volem reduir un 25% els preus d'aquells productes dels quals tenim existències majors a 100, per treure'ns-els de sobre. Indicarem al nom del producte que estan rebaixats. Per no sobrepassar el límit de 20 caràcters del camp `descripcion` (mira els detalls de la taula `productos`), retallem la descripció. Fixa't que ho estic fent també sobre una còpia de la taula i no l'original. Malgrat que estic treballant amb `training2`, també és bona idea anar fent còpies de les taules abans de fer les proves:

```SQL
--primer mirem què canviarà:
select * from productos2 where existencias >100;

id_fab | id_producto |    descripcion    | precio | existencias
--------+-------------+-------------------+--------+-------------
rei    | 2a45c       | V Stago Trinquete |  79.00 |         210
aci    | 41003       | Articulo Tipo 3   | 107.00 |         207
aci    | 41004       | Articulo Tipo 4   | 117.00 |         139
qsa    | xk48        | Reductor          | 134.00 |         203
fea    | 112         | Cubierta          | 148.00 |         115
imm    | 887h        | Soporte Riostra   |  54.00 |         223
aci    | 41001       | Articulo Tipo 1   |  55.00 |         277
aci    | 41002       | Articulo Tipo 2   |  76.00 |         167
(8 rows)



update productos2
  set precio = 0.75 * precio,
  descripcion = left(descripcion, 12) || ' REBAIXA'
  where existencias > 100;
--UPDATE 8
select * from productos2;

id_fab | id_producto |     descripcion      | precio  | existencias
--------+-------------+----------------------+---------+-------------
 aci    | 4100y       | Extractor            | 2750.00 |          25
 qsa    | xk47        | Reductor             |  355.00 |          38
 bic    | 41672       | Plate                |  180.00 |           0
...
imm    | 887x        | Retenedor Riostra    |  475.00 |          32
rei    | 2a44g       | Pasador Bisagra      |  350.00 |          14
rei    | 2a45c       | V Stago Trin REBAIXA |   59.25 |         210
aci    | 41003       | Articulo Tip REBAIXA |   80.25 |         207
aci    | 41004       | Articulo Tip REBAIXA |   87.75 |         139
qsa    | xk48        | Reductor REBAIXA     |  100.50 |         203
fea    | 112         | Cubierta REBAIXA     |  111.00 |         115
imm    | 887h        | Soporte Rios REBAIXA |   40.50 |         223
aci    | 41001       | Articulo Tip REBAIXA |   41.25 |         277
aci    | 41002       | Articulo Tip REBAIXA |   57.00 |         167
(25 rows)
```

Observa com ha canviat l'ordre dels registres a la taula (si havies fet un `select * from productos2;` abans ho hauries vist). Mai podem pressuposar un ordre concret als registres!.
