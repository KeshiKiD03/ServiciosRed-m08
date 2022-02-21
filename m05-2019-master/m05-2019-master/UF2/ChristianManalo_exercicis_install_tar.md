### Exercicis instal·lació de fitxers tar 
## Christian Manalo
Instal·lació de paquets utilitzant fitxers `tarball` (*tgz/tar.gz*,
*tbz/tar.bz*, *txz/tar.xz*)

##### Exercici 1

Aquest tipus de paquet comprimit s'instal·la normalment en 4 etapes que amb
freqüència es descriuen en algun fitxer de tipus README o INSTALL (que es troba
a dintre del mateix paquet)

1. Descomprimir el paquet i entrar al directori pare del paquet descomprimit.
> tar -xvzf file.tar.gz
> cd file
2. Comprovar que el nostre sistema té totes les dependències necessàries d'aquest programa.
> ./configure
3. Compilar/generar l'executable, el binari i altres dades/fitxers necessaris.
> make
4. Instal·lar les binaris (i altres fitxers de configuració) al nostre sistema.
> make install

Tot i que poden haver diferències (en funció del llenguatge en el qual està
escrit el programa) quines són les ordres habituals per realitzar cadascuna
d'aquestes etapes?

##### Exercici 2

Alguna de les etapes anteriors necessita que siguem root (o utilitzar `sudo`)?
> Si volem instalar alguna cosa en el sistema hem  de ser sempre root o sudo.

##### Exercici 3

L'etapa 2, el `./configure` si existeix, ens dirà el que ens falta, però si
anem a compilar/fabricar un executable necessitarem que el nostre sistema
tingui les *eines de desenvolupament* que ens permetran fabricar un binari a
partir d'un fitxer de C, C++, Python ...

Quina ordre ens instal·laria aquestes *eines de desenvolupament* a una distribució
*Debian*? 
```
$ sudo apt-get update
$ sudo apt-get install build-essential
```

I a una *Fedora*? 
```
$ sudo dnf update
$ dnf groupinstall "Development Tools"
$ dnf groupinstall "C Development Tools and Libraries"
```
##### Exercici 4

Instal·leu a *Debian* el programa *sopcast*. Fes servir [aquesta
adreça](http://ronlut.blogspot.com.es/2014/06/installing-sopcast-on-debian-jessie-64.html)
tenint en compte que les instruccions estan fetes per a una versio anterior.

L'enllaç de *sopcast* està trencat. A la web de [Google Code es troba la versió
0.8.5](https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/sopcast-player/sopcast-player-0.8.5.tar.gz)

##### Exercici 5

Instal·leu a *Fedora* el programa de consola `jq` per poder tractar els fitxers
[json](https://en.wikipedia.org/wiki/JSON#Example). A qualsevol distribució
*GNU/Linux* ja tenim un paquet que normalment no és la darrera versió del
programa. Si volem la darrera versió hem de baixar-nos el repositori git
corresponent.En aquest cas, que no és el que demanem, podríem seguir les
instruccions que es troben a [la seva pàgina
web](https://stedolan.github.io/jq/download/).

Nosaltres el que farem serà treballar amb el codi (*sources*), per a això ens
baixarem el paquet que es troba en [aquest
enllaç](https://github.com/stedolan/jq/releases/download/jq-1.6/jq-1.6.tar.gz)
i seguirem les etapes habituals.

Un cop instal·lat podem treballar amb un exemple, farem servir el fitxer JSON
que conté la [informació dels bicings de
Barcelona](http://api.citybik.es/bicing.json).

Podeu fer servir l'ordre:

```
curl http://api.citybik.es/bicing.json > bicing.json
```

I jugar amb aquest fitxer, on cada element representa una estació del bicing.

Per exemple si volgués trobar la següent informació:

1. Mostra quin tipus d'argument (arrai, nombres, objectes ...) representa el
   fitxer *JSON*.
```
[root@j05 jq-1.6]# cat bicing.json  | jq type
"array"
```
2. Mostra quants elements hi ha. 
```
[root@j05 jq-1.6]# cat bicing.json  | jq length
434
```
3. Mostra tota la informació de tots els elements (sabent que tenim un arrai).
```
{
  "bikes": 3,
  "name": "C/ PUJADES, 103",
  "idx": 0,
  "lat": 41398389,
  "timestamp": "2020-02-26T07:39:17.809000Z",
  "lng": 2196261,
  "id": 0,
  "free": 19,
  "number": 428
}
{
  "bikes": 20,
  "name": "C/ DE SANT PAU, 119/ RONDA SANT PAU",
  "idx": 1,
  "lat": 41375336,
  "timestamp": "2020-02-26T07:39:17.811000Z",
  "lng": 2168007,
  "id": 1,
  "free": 0,
  "number": 427
}

[...]
```
4. Mostra tota la informació de l'element 0 de l'arrai.
```
{
  "bikes": 3,
  "name": "C/ PUJADES, 103",
  "idx": 0,
  "lat": 41398389,
  "timestamp": "2020-02-26T07:39:17.809000Z",
  "lng": 2196261,
  "id": 0,
  "free": 19,
  "number": 428
}

```
5. Mostra el camp *name* de tots els elements (sabent que tenim un arrai).
```
"C/ PUJADES, 103"
"C/ DE SANT PAU, 119/ RONDA SANT PAU"
"C/ DE RIBES, 59 B"
"C/ DE CERVELLÓ, 5"
"PG. MARÍTIM DE LA BARCELONETA"
"C/ HONDURAS, 32-34"
"PL. DE JOAN PEIRÓ"
"GRAN VIA DE LES CORTS CATALANES, 361"
"PG.DE LLUíS COMPANYS (ARC DE TRIOMF)"
"PG. DE LLUíS COMPANYS (ARC DE TRIOMF)"

[...]
```
6. Mostra tota la informació d'aquells elements que tinguin el camp *bikes*
   superior a 30 (més de 30 bicis disponibles)
```
{
  "bikes": 31,
  "name": "C/ VILLARROEL, 39",
  "idx": 150,
  "lat": 41382206,
  "timestamp": "2020-02-26T07:39:18.305000Z",
  "lng": 2160644,
  "id": 150,
  "free": 1,
  "number": 261
}
{
  "bikes": 37,
  "name": "PG. MARÍTIM DE LA NOVA ICÀRIA, 83",
  "idx": 233,
  "lat": 41391986,
  "timestamp": "2020-02-26T07:39:18.538000Z",
  "lng": 2203699,
  "id": 233,
  "free": 16,
  "number": 171
}
{
  "bikes": 31,
  "name": "PL. PAU VILA",
  "idx": 291,
  "lat": 41381046,
  "timestamp": "2020-02-26T07:39:19.037000Z",
  "lng": 2186576,
  "id": 291,
  "free": 13,
  "number": 39
}
{
  "bikes": 32,
  "name": "C/ GRAN VIA CORTS CATALANES, 760",
  "idx": 325,
  "lat": 41397952,
  "timestamp": "2020-02-26T07:39:19.158000Z",
  "lng": 2180042,
  "id": 325,
  "free": 14,
  "number": 1
}
```
7. Mostra el nom d'aquells elements que tinguin el camp *bikes* superior a 30
   (més de 30 bicis disponibles)
```
[root@j05 jq-1.6]# cat bicing.json  | jq '.[] | select (.bikes > 30) | .name'
"C/ VILLARROEL, 39"
"PG. MARÍTIM DE LA NOVA ICÀRIA, 83"
"PL. PAU VILA"
"C/ GRAN VIA CORTS CATALANES, 760"
```
8. Mostra tota la informació d'aquells elements que al seu camp *name*
   contingui la cadena "Rosselló" i el camp *bikes* superior a 10.
```
[root@j05 jq-1.6]# cat bicing.json | jq '.[] |  select(.name | contains("ROSSELLÓ")) | select(.bikes > 10)'
{
  "bikes": 18,
  "name": "C/ DE ROSSELLÓ I PORCEL, 1/AV.MERIDIANA",
  "idx": 115,
  "lat": 41436505,
  "timestamp": "2020-02-26T07:39:18.248000Z",
  "lng": 2183877,
  "id": 115,
  "free": 15,
  "number": 296
}
{
  "bikes": 17,
  "name": "C/ ROSSELLÓ, 108-110",
  "idx": 382,
  "lat": 41388424,
  "timestamp": "2020-02-26T07:39:18.902000Z",
  "lng": 2150783,
  "id": 382,
  "free": 0,
  "number": 90
}
{
  "bikes": 24,
  "name": "C/ ROSSELLÓ,  101",
  "idx": 383,
  "lat": 41388154,
  "timestamp": "2020-02-26T07:39:18.908000Z",
  "lng": 2150342,
  "id": 383,
  "free": 0,
  "number": 89
}
```
Hauria d'executar, respectivament les següents ordres a la consola:

```
cat bicing.json  | jq type
cat bicing.json  | jq length
cat bicing.json  | jq '.[]'
cat bicing.json  | jq '.[0]'
cat bicing.json  | jq '.[].name'
cat bicing.json  | jq '.[] | select (.bikes > 30)'
cat bicing.json  | jq '.[] | select (.bikes > 30) | .name'
echo "aquest no me'l diu el profe i l'he de fer jo"
```

