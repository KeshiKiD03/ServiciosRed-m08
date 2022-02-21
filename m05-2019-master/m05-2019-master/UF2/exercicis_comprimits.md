### Exercicis fitxers d'arxivament tar i compressió

Exercicis d'arxivament de fitxers (tar) i compressió/descompressió de fitxers
(gzip, bzip2, xz)

##### Introducció als fitxers d'arxivament i als fitxers de compressió

Definició de format d'arxivament:

> És un format de fitxer que permet l'agrupament de fitxers en un de sol, però
> òbviament conservant la informació relativa al grup de fitxers (metadades).

S'utilitzen fitxers d'arxivament amb diferents finalitats com la creació de
paquets de programari (*rpm*, *deb*), la creació de imatges de disc (*iso*) ...

A la wikipedia podem trobar [una comparativa molt
interessant](https://en.wikipedia.org/wiki/Comparison_of_archive_formats)

La següent taula ens mostra algunes característiques (*features*) dels diferents formats d'arxivament:

![comparativa de característiques de formats d'arxivament](archives_features_wikipedia.png)

L'exemple per excel·lència i amb el que treballarem nosaltres serà el fitxer de tipus *tar* i per tant l'ordre `tar`. 


Definició de format de compressió:

> Fitxer que conté la mateixa informació que l'original però 
> utilitzant menys dades.

Hi ha molts formats de compressió, nosaltres treballarem amb *gzip*, *bzip2* i *xz*.


##### Exercici -1 (el fem tots al mateix temps a classe)

És molt probable que el nostre sistema de fitxers estigui format per blocs
físics de mida 4KB. Ho podem comprovar amb diferents ordres:

```
fdisk -l /dev/sda
...
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
...
```

O també:

```
cat /sys/block/sda/queue/physical_block_size
4096
```

Anem a fer una prova, suposarem que no tenim cap altre servei al nostre sistema
que pugui estar enviant fitxers a `/tmp`.

Fem un cop d'ull a la utilització de l'espai amb `df` (*disk free*):

```
df
... # massa informació
```

Filtrem, només mirem `/tmp` i anem creant fitxers i observant com evoluciona
l'ús de l'espai de disc:

```
[john@i02 tmp]$  df | grep -w '/tmp'
tmpfs                                                            1969036     26272   1942764   2% /tmp
[john@i02 tmp]$ echo "soc un fitxer de pocs bytes que ocuparé 4K al disc dur" > f1
[john@i02 tmp]$  df | grep -w '/tmp'
tmpfs                                                            1969036     26276   1942760   2% /tmp
[john@i02 tmp]$ echo "soc un fitxer de pocs bytes que m'agrada tenir molt d'espai lliure al meu sector" > f2
[john@i02 tmp]$  df | grep -w '/tmp'
tmpfs                                                            1969036     26280   1942756   2% /tmp
[john@i02 tmp]$ echo "Soc un fitxer sobradíssim" > f3
[john@i02 tmp]$  df | grep -w '/tmp'
tmpfs                                                            1969036     26284   1942752   2% /tmp
[john@i02 tmp]$ echo -e "soc un fitxer de pocs bytes que ocuparé 4K al disc dur\nsoc un fitxer de pocs bytes que m'agrada tenir molt d'espai lliure al meu sector\nSoc un fitxer sobradíssim\n" > f123
[john@i02 tmp]$  df | grep -w '/tmp'
tmpfs                                                            1969036     26288   1942748   2% /tmp
```

Calculem la mida dels fitxers que acabem de crear (també ho podríem fer amb `wc -c`):

```
[john@i02 tmp]$ ls -l /tmp/f[1-3]*
-rw-r--r--. 1 john inf  56 Feb  5 15:30 /tmp/f1
-rw-r--r--. 1 john inf 165 Feb  5 15:32 /tmp/f123
-rw-r--r--. 1 john inf  81 Feb  5 15:30 /tmp/f2
-rw-r--r--. 1 john inf  27 Feb  5 15:31 /tmp/f3
```

Veiem que 3 fitxers de 56, 81 i 27 bytes ocupen 4K + 4K + 4K en disc, o sigui
12K, i en canvi un únic fitxer de la mateixa mida (de fet un byte més) *només*
ocupa un bloc de 4K.

Així es pot concloure que aconseguir transformar un grup de fitxers en únic de
sol ja té al menys un avantatge: **estalvi d'espai al disc dur**.

Recordem que el sistema de fitxers divideix la nostra partició en blocs i que
donat un fitxer s'utilitza almenys un bloc. Aquest bloc és exclusiu d'aquest
fitxer. Si sobra espai i en un futur es modifica el fitxer s'utilitza aquest
bloc i si s'omple es reserva un altre bloc per a aquest fitxer. Tot i que pugui
semblar un malbaratament d'espai, aquest disseny té molts avantatges, per
exemple al tenir tots els blocs (registres) la mateixa mida el seu accés sempre
és directe (no seqüencial) i per tant és més ràpid.

##### Exercici 0

Des de *Fedora* i *Debian* comproveu si teniu instal·lat al vostre sistema la documentació de *postgresql*.

El paquet a *Fedora 24* es diu `postgresql-docs` i a *Debian Stretch* `postgresql-doc`.

Comproveu amb l'ordre adient si està instal·lat el paquet o no. Si no està instal·lat,  baixeu-lo utilitzant el gestor de paquets del sistema en el qual us trobeu **sense instal·lar res**.
**Buscar si tenim el paquet instalat**


**Buscar a Fedora**
```
rpm -qa  | grep postgres
```
**Baixar el paquet sense instalar Fedora**
```
dnf download postgresql-doc
```

**Buscar a Debian**
```
apt list --installed | grep postgres
```

**Baixar el paquet sense instalar Debian**
```
apt-get download postgresql-docs
```
No el volem instal·lar. Volem obrir i descomprimir el paquet. Ho farem gràficament amb `file-roller` descomprimint a l'Escriptori. Podeu fer un cop d'ull amb el navegador per veure aquesta ajuda (heu de cercar on es troba el fitxer `index.html`.



##### Exercici 1

L'exercici anterior haurà creat un directori `usr` amb diferents subdirectoris i fitxers. Quina ordre em crea un fitxer de tipus *tar* (sense comprimir)? (Hint: `man tar`)

```
[isx9565961@j05 postgresql-docs]$ time tar -cf postgres.tar postgresql-9.6.10-US.pdf  
[isx9565961@j05 postgresql-docs]$ ls | grep *.tar
postgres.tar
```

##### Exercici 2

Quina ordre em fa el mateix d'abans però comprimint amb gzip? I amb bzip2? I amb
xz? Després de comprimir amb les 3 ordres fixa't bé en el procés de compressió
de tots 3. Hi ha alguna diferència de velocitat en l'execució de l'ordre
(recorda que si poses `time` davant d'una ordre et mostra el temps que triga
l'ordre)? I en la mida, hi ha diferències? Pots concloure que un compressor
serà millor que altre sempre? o depén de l'ús que es vulgui fer? (Hint: `man
tar`)

**Tar**
```
[isx9565961@j05 postgresql-docs]$ time tar -cf postgres.tar postgresql-9.6.10-US.pdf 

real	0m0.012s
user	0m0.001s
sys	0m0.010s
```

**Gzip**
```
[isx9565961@j05 postgresql-docs]$ time tar -czf postgres.tar.gz postgresql-9.6.10-US.pdf 

real	0m0.425s
user	0m0.397s
sys	0m0.022s
```

**Bzip2**
```
[isx9565961@j05 postgresql-docs]$ time tar -c postgresql-9.6.10-US.pdf | bzip2 > postgresql-9.6.10-US.pdf.tar.bz2
real	0m2.252s
user	0m2.167s
sys	0m0.035s
```

**xz**
```
[isx9565961@j05 postgresql-docs]$ time xz -k postgresql-9.6.10-US.pdf

real	0m4.020s
user	0m3.792s
sys	0m0.075s
```

**Conclusió**

**Hi ha diferencias a la hora de comprimir els fitxers, el que dura mes es xz i el mes rapid es tar. 
Pero també hi ha diferencias al tamany: 
Tar es el que ocupa mes i el que ocupa menys es el bzip2 amb tar, tambe depen de quin us farem.**
```
[isx9565961@j05 postgresql-docs]$ ls -l
total 35080
drwxr-xr-x. 2 isx9565961 hisx1   27580 Aug 27  2018 html
-rw-rw-r--. 1 isx9565961 hisx1 9157439 Aug  9  2018 postgresql-9.6.10-US.pdf
-rw-r--r--. 1 isx9565961 hisx1      14 Feb 19 09:24 postgresql-9.6.10-US.pdf.tar.bz2
-rw-rw-r--. 1 isx9565961 hisx1 8806180 Aug  9  2018 postgresql-9.6.10-US.pdf.xz
-rw-r--r--. 1 isx9565961 hisx1 9164800 Feb 19 09:19 postgres.tar
-rw-r--r--. 1 isx9565961 hisx1 8785604 Feb 19 09:20 postgres.tar.gz
```
##### Exercici 3

Continuem treballant a l'escriptori. Si tenim aquí el directori `usr` d'abans
eliminem-lo. 

+ Descomprimiu el fitxer d'extensió *tar.gz* al mateix escriptori. 
```
[isx9565961@j05 postgresql-docs]$ tar -zxf postgres.tar.gz
```
+ Feu el mateix amb el fitxer d'extensió *xz* però sense canviar el directori
  actiu (escriptori) volem que es descomprimeixi a `/tmp`.

```
[isx9565961@j05 postgresql-docs]$ xz -d postgresql-9.6.10-US.pdf.xz 	
```
##### Exercici 4

Quina ordre ens permet llistar el contingut d'un tar sense necessitat de descomprimir-lo?
```
[isx9565961@j05 postgresql-docs]$ tar -tf postgres.tar
postgresql-9.6.10-US.pdf
```
##### Exercici 5

Tenim estructures de directoris transformades en tar's comprimits. Quines ordres aconseguiran només descomprimir els diferents comprimits que tinc? I un cop tingui un tar, com puc passar del tar a l'estructura de directoris original?

##### Exercici 6

Executeu les següents ordres:

```
[john@i02 Desktop]$ cd ~/Desktop/
[john@i02 Desktop]$ mkdir -p  exercici6/dir1/dir11/dir12/{dir121,dir122}
[john@i02 Desktop]$ cd exercici6/
[john@i02 exercici6]$ echo "soc el fitxer fitxer1" > dir1/dir11/dir12/dir121/fitxer1.txt
[john@i02 exercici6]$ tree 
.
└── dir1
    └── dir11
        └── dir12
            ├── dir121
            │   └── fitxer1.txt
            └── dir122

5 directories, 1 file
```

+ Descriu que fa cadascuna d'aquestes ordres.
```
Canviar de directori
[john@i02 Desktop]$ cd ~/Desktop/

Crear directoris
[john@i02 Desktop]$ mkdir -p  exercici6/dir1/dir11/dir12/{dir121,dir122}

Entrar el directori exercici6
[john@i02 Desktop]$ cd exercici6/

Crear un fitxer a dir121
[john@i02 exercici6]$ echo "soc el fitxer fitxer1" > dir1/dir11/dir12/dir121/fitxer1.txt

Mostra l'arbre de directoris
[john@i02 exercici6]$ tree 
.
└── dir1
    └── dir11
        └── dir12
            ├── dir121
            │   └── fitxer1.txt
            └── dir122

5 directories, 1 file
```

+ Sense moure'ns de directori, quina ordre crearà un fitxer *tgz* que contigui tota l'estructura de directoris i fitxers (sense el directori *exercici6*)

##### Exercici 7

Es pot indicar el nivell de compressió o de velocitat quan s'utilitzen *gzip*, *bzip2* i *xz*? I per descomprimir?

##### Exercici 8

Baixa el paquet [r.tar.gz](r.tar.gz) i descomprimeix tot el que es pugui descomprimir.
