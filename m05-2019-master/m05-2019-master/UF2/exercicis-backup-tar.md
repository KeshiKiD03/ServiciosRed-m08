## Exercicis backups amb tar

### Creació de backups de dades amb tar

##### Exercici 1

Genereu un paquet-1 comprimit (al màxim) amb tota la documentació d'apunts dels
crèdits M01, M05, M07.

Suposarem que tenim una estructura tipus:

```
[eve@pc666 ~]$ tree  prova_public_backup_ASIX/
prova_public_backup_ASIX/
├── M01-Operatius
│   ├── 00-Substitucio
│   │   ├── 1-Introduccio_SO.pdf
│   │   ├── 2-AlgoritmeShell.pdf
│   │   ├── 3-Ordres_Basiques_GNU_Linux.pdf
│   │   ├── 5-exerciciExpresionsRegulars.txt
...

├── M03-Programacio
│   ├── documents
│   │   ├── capsalera.py
│   │   ├── estil_python.odt
│   │   ├── Introducci\303\263n\ a\ la\ programaci\303\263n\ con\ Python.pdf
│   │   └── presentacio_curs_2017-18_2HISX(1).odp
│   ├── examens
│   │   ├── examen1
...
└── M05-Hardware
    ├── exercicis_comprimits.md
    ├── exercicis_deb.md
    ├── exercicis_mastering_time.md
    ├── git_class
    │   ├── 01-primers_passos.md
...
43 directories, 236 files
```
**Solució**
> gzip -r --best prova_public_backup_ASIX/M01 prova_public_backup_ASIX/M05 prova_public_backup_ASIX/M07 > paquet-1.gz 

##### Exercici 2

Genereu un paquet-2 comprimit amb tota la documentació pdf respectant la seva
estructura de directoris.
**Solució**
> find prova_public_backup_ASIX/ -name \*.pdf | gzip -r --best > paquet-2.gz


##### Exercici 3

Afegiu al paquet anterior tota la documentació .txt i afegir-hi les noves
versions de documents pdf (si cal simular-ne actualitzacions).
**Solució**
```
1- Descomprimir
tar -xzvf paquet-2.gz
2- Añadir nuevas vesiones
f
3- Comprimir
```
##### Exercici 4

Genereu un paquet-4 comprimit amb tota la documentació dels crèdits M01, M05 i
M07 que permeti la instal·lació automàtica amb ruta absoluta a
`/usr/share/doc/ASIX`.

##### Exercici 5

Restaureu tots els fitxers txt del paquet-1 a una nova ubicació a tmp.

##### Exercici 6

Elimineu del paquet-2 tots els fitxers txt del crèdit M05. 

### Tipus de Backups: complet, diferencial, incremental


Estratègia de backup que utilitza el millor dels 3 *mons*: 

	* es fa un backup a l'inici de més. 
	* es fa un incremental cada dos dies.
	* es fa un diferencial cada setmana.

##### Exercici 7

Genera un backup complet (usant `tar`) del home de l'usuari pere complint:

+ El fitxer de backup es dirà "pere-complet-\<data\>.tgz", és a dir,
+ El fitxer tindrà la data en que s'ha fet el backup.
+ Els fitxers de backup es desen a /tmp/backups.

##### Exercici 8

Genera un backup incremental (usant `tar`) del home del'usuari pere. El fitxer
de backup es dirà "pere-incremental-\<data\>.tgz", és a dir, el fitxer tindrà la
data en que s'ha fet el backup. Fer-ne un cada dos dies.

##### Exercici 9

Genera un backup diferencial (usant tar) del home de l'usuari pere. El fitxer
de backup es dirà "pere-diferencial-\<data\>.tgz". Fer-ne un passada una setmana
del backup complet. (es fa a partir del complet)

##### Exercici 10

*Opcional*

Genereu un paquet-10 tar comprimit que conté tots aquells fitxers inclosos en
una llista de fitxers (trajectòries absolutes) a desar. Suposem que el fitxer que conté la llista es files-list.txt

##### Exercici 11

*Opcional*

Genereu un paquet-11 tar comprimit que desi tota la documentació dels crèdits
M01, M05 i M07 exceptuant els fitxers .sh, .pka, .img, .tgz i .zip. 

