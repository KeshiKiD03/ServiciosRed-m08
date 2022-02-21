--          Modificació
-------------------------------------------------------------------------------
-- Per cada exercici, posa la comanda o comandes que hagis necessitat, així com la resposta que donen.


-- 6.1-  Inserir un nou venedor amb nom "Enric Jimenez" amb identificador 1012, oficina 18, títol "Dir Ventas", contracte d'1 de febrer del 2012, director 101 i vendes 0.
insert into repventas(nombre,num_empl,oficina_rep,titulo,contrato,director,ventas)
values ('Enric Jimenez',1012,18,'Dir Ventas', '2012-02-01',101,0);

-- 6.2- Inserir un nou client "C1" i una nova comanda pel venedor anterior.
-- Fem una copia de clientes perque no tingui restriccions
create table clientes2 as table clientes;

insert into clientes2(empresa)
values ('C1');

-- Fem una copa de pedidos perque no tingui restriccions
create table pedidos2 as table pedidos;
insert into pedidos2(rep)
values ((select num_empl from repventas where nombre='Enric Jimenez'));

-- 6.3- Inserir un nou venedor amb nom "Pere Mendoza" amb identificador 1013, contracte del 15 de agost del 2011 i vendes 0. La resta de camps a null.
insert into repventas(nombre,num_empl,contrato,ventas)
values('Pere Mendoza',1013,'2011-08-15',0);

-- 6.4- Inserir un nou client "C2" omplint els mínims camps.
insert into clientes2
values (1,'C2',1012,null);

-- 6.5- Inserir una nova comanda del client "C2" al venedor "Pere Mendoza" sense especificar la llista de camps pero si la de valors.
insert into pedidos2
values (null,null,(select num_clie from clientes2 where empresa='C2'),(select num_empl from repventas where nombre='Pere Mendoza'),null,null,null,null);

-- 6.6- Esborrar de la còpia de la base de dades el venedor afegit anteriorment anomenat "Enric Jimenez".
delete from repventas
where nombre = 'Enric Jimenez';

-- 6.7- Eliminar totes les comandes del client "C1" afegit anteriorment.
delete from pedidos2 
where clie=(select num_clie from clientes2 where empresa='C2');

-- 6.8- Esborrar totes les comandes d'abans del 15-11-1989.
-- Compruebo els que he de borrar.
select * from pedidos2 where fecha_pedido <  '1989-11-15';

-- Esborro
delete from pedidos2
where fecha_pedido <  '1989-11-15';

-- 6.9- Esborrar tots els clients dels venedors: Adams, Jones i Roberts.
-- Llisto els clients 
select num_empl from repventas where nombre LIKE '%Adams' or  nombre LIKE '%Jones' or nombre LIKE '%Roberts';

-- Esborro
delete from clientes2
where rep_clie IN (select num_empl from repventas where nombre LIKE '%Adams' or  nombre LIKE '%Jones' or nombre LIKE '%Roberts');


-- 6.10- Esborrar tots els venedors contractats abans del juliol del 1988 que encara no se'ls ha assignat una quota.
-- Llisto 
select * from repventas where contrato < '1988-07-01' and cuota is NULL;

-- No fa falta esborrar perque no hi ha ningu

-- Pero la comanda seria aquesta
delete from repventas
where contrato < '1988-07-01' and cuota is NULL;

-- 6.11- Esborrar totes les comandes.
delete from pedidos2;

-- 6.12- Esborrar totes les comandes acceptades per la Sue Smith (cal tornar a disposar  de la taula pedidos)
drop table pedidos2;
create table pedidos2 as table pedidos;

-- LListar
select * from pedidos where rep = (select num_empl from repventas where nombre = 'Sue Smith');

-- Esborrar
delete from pedidos2
where rep = (select num_empl from repventas where nombre = 'Sue Smith');

-- 6.13- Suprimeix els clients atesos per venedors les vendes dels quals són inferiors al 80% de la seva quota.
-- Llistar els venedors
select * from repventas where ventas < 0.8 * cuota;

-- Llistar els clients
select * from clientes2 where rep_clie IN (select num_empl from repventas where ventas < 0.8 * cuota) ;

-- Esborrar
delete from clientes2
where rep_clie IN (select num_empl from repventas where ventas < 0.8 * cuota) ;

-- 6.14- Suprimir els venedors els quals el seu total de comandes actual (imports) és menor que el 2% de la seva quota.
-- Llistar
select  num_empl
from repventas 
JOIN pedidos2 ON rep = num_empl 
group by nombre, cuota,num_empl 
having sum(importe) < 0.02 * cuota;

-- Eliminar
delete from repventas
where num_empl IN (select  num_empl
from repventas 
JOIN pedidos2 ON rep = num_empl 
group by nombre, cuota,num_empl 
having sum(importe) < 0.02 * cuota);

-- 6.15- Suprimeix els clients que no han realitzat comandes des del 10-11-1989.
-- Llistar
select * from pedidos2 where fecha_pedido < '1989-11-10';

-- Eliminar
delete from clientes2
where num_clie IN (select clie from pedidos2 where fecha_pedido < '1989-11-10');

-- 6.16 Eleva el límit de crèdit de l'empresa Acme Manufacturing a 60000 i la reassignes a Mary Jones.
update clientes
set limite_credito = 60000, rep_clie = (select num_empl from repventas where nombre = 'Mary Jones')
where empresa LIKE 'Acme%';

-- 6.17- Transferir tots els venedors de l'oficina de Chicago (12) a la de Nova York (11), i rebaixa les seves quotes un 10%.
update repventas
set oficina_rep = 11 , cuota = cuota-(cuota * 0.1)
where oficina_rep = 12;

-- 6.18- Reassigna tots els clients atesos pels empleats 105, 106, 107, a l'emleat 102.
update clientes2
set rep_clie = 102
where rep_clie IN (105,106,107);


-- 6.19- Assigna una quota de 100000 a tots aquells venedors que actualment no tenen quota.
update repventas
set cuota = 100000
where cuota is null;

-- 6.20- Eleva totes les quotes un 5%.
update repventas
set cuota = cuota + (cuota * 0.05);

-- 6.21- Eleva en 5000 el límit de crèdit de qualsevol client que ha fet una comanda d'import superior a 25000.
update empresa
set limite_credito = limite_credito + 5000
where num_clie IN (select clie from pedidos where importe > 25000);
   
-- 6.22- Reassigna tots els clients atesos pels venedors les vendes dels quals són menors al 80% de les seves quotes. Reassignar al venedor 105.
update clientes2
set rep_clie = 105
where rep_clie = (select num_empl from repventas where ventas < cuota * 0.8);
   
-- 6.23- Fer que tots els venedors que atenen a més de tres clients estiguin sota de les ordres de Sam Clark (106).
update repventas
set director = 106
where num_empl IN (select num_empl from repventas join clientes2 on num_empl = rep_clie group by num_empl having count(rep_clie) > 3);

-- 6.24- Augmentar un 50% el límit de credit d'aquells clients que totes les seves comandes tenen un import major a 30000.
update clientes2
set limite_credito = limite_credito +(limite_credito* 0.5)
where num_clie IN (select clie from pedidos group by clie having sum(importe) > 30000);

-- ALERTA sense l'EXISTS augmenta el limit de credit dels clients que no tenen comandes.

-- 6.25- Disminuir un 2% el preu d'aquells productes que tenen un estoc superior a 200 i no han tingut comandes.
update productos
set precio = precio - (precio*0.02)
where existencias > 200 and id_producto not IN (select producto from pedidos);


-- 6.26- Establir un nou objectiu per aquelles oficines en que l'objectiu actual sigui inferior a les vendes. 
-- Aquest nou objectiu serà el doble de la suma de les vendes dels treballadors assignats a l'oficina.
update oficinas
set objetivo = 2*(select sum(ventas) from repventas group by oficina_rep)
where objetivo < ventas;

-- 6.27- Modificar la quota dels directors d'oficina que tinguin una quota superior a la quota d'algun empleat de la seva oficina. 
-- Aquests directors han de tenir la mateixa quota que l'empleat de la seva oficina que tingui una quota menor.
update repventas
set cuota = (select cuota from repventas order by cuota asc limit 1)
where ... 

-- 6.28- Cal que els 5 clients amb un total de compres (cantidad) més alt siguin transferits a l'empleat Tom Snyder i que se'ls augmenti el límit de crèdit en un 50%.
update clientes
set limite_credito = limite_credito + (limite_credito*0.5), rep_clie = (select num_empl from repventas where nombre = 'Tom Snyder')
where num_clie IN (2124,2120,2118,2117,2114)

-- clients 
select clie,sum(cant) from pedidos group by clie order by 1 desc limit 5;

-- 6.29- Es volen donar de baixa els productes dels que no tenen existències i alhora no se n'ha venut cap des de l'any 89.
delete from productos
where id_producto IN (select producto from pedidos join productos on fab=id_fab and producto= id_producto where fecha_pedido > '1989-01-01' and existencias = 0)


-- 6.30- Afegir una oficina de la ciutat de "San Francisco", regió oest, el director ha de ser "Larry Fitch", les vendes 0, 
-- l'objectiu ha de ser la mitja de l'objectiu de les oficines de l'oest i l'identificador de l'oficina ha de ser el següent valor després del valor més alt.

insert into oficinas (ciudad,region,dir,ventas,objetivo,oficina)
values ('San Francisco','Oest',(select num_empl from repventas where nombre = 'Larry Fitch'),0,(select round(avg(objetivo),2) from oficinas where region = 'Oeste'),1+(select oficina from oficinas order by 1  desc limit 1))
