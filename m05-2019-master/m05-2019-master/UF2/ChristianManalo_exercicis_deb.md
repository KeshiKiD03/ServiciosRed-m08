### Enunciats exercicis gestió de paquets i repositoris en distribucions Debian
 
Instal·lar software amb `aptitude`, `apt-get`, `dpkg`

##### Exercici 1

Quin és el fitxer de configuració dels repositoris (amb trajectòria completa)?
Descriu les diferents parts d'una línia d'aquest fitxer.

> Se encuentra en /etc/apt/sources.list

Este es el formato:
```
deb http://site.example.com/debian distribution component1 component2 component3
```

> La primera palabra, deb o deb-src indica el tipo de archivo- Deb indica que contiene paquetes binarios, los paquetes precompilados que normalmente usamos.

> Deb-src indica los paquetes fuente, que son las fuentes originales del programa más el archivo de control Debian (.dsc) y el diff.gz que contiene los cambios necesarios para empaquetar el programa.

> Lo siguiente es un URL, es donde se encuentra el repositorio donde se descargara la lista de paquetes de Debian.

> Distribution , aqui tenemos que poner el codigo de la release o el alias de la version del Debian (jessie, stretch, buster, sid) o tambien podemos poner la clase (oldstrable, stable, testing, unstable)

> Component1, main consiste en paquetes compatibles con DFSG, que no dependen de software fuera de esta area para operar, Estos son los unicos paquetes considerados parte de la distribucion de Debian.

> Component2, contrib contienen software compatible con DFSG, pero tienen dependenvias que no estan en main (posiblemente empaquetadas para Debian en versiones no gratuitas) 

> Component3, non-free contiene software que no cumple con el DFSG.

Si volguéssim que la nostra distro fos 100% lliure quin/quins serien els components?
>  Tenemos que borrar el non-free en el archivo sources.list.

##### Exercici 2

A les distribucions derivades de RedHat-Fedora l'ordre `dnf upgrade` (antigament a Fedora i a Centos ara: `yum update`) ens actualitza tots els paquets del sistema, quina/es ordres farien el mateix en una distribució tipus Debian?

> apt-get update
> apt update

##### Exercici 3

Instal·leu clementine, vlc, gimp, shotwell, gparted, gnome-disk-utility, libreoffice-writer, libreoffice-calc, libreoffice-impress, xournal, pgmodeler i aptitude

> apt install clementine vlc gimp shotwell gparted gnome-disk-utility libreoffice-writer libreoffice-calc libreoffice-impress xournal pgmodeler aptitude

> apt -get install clementine vlc gimp shotwell gparted gnome-disk-utility libreoffice-writer libreoffice-calc libreoffice-impress xournal pgmodeler aptitude

Trobeu algun paquet pel que sigui necessari fer servir *contrib* i/o
*non-free*. 

> No, tots els paquets estan en el main


##### Exercici 4

Volem afegir el repositori de *Riot*, per a això podríem afegir una línia al
final del fitxer de configuració d'abans, o fer un nou fitxer per a aquest
repositori. Optarem per aquesta 2a opció. [Ajuda](https://riot.im/desktop.html)
 
Seguiu les recomanacions de l'enllaç i actualitzeu el repositori, importeu les claus que garanteixen que el programa és de fonts fiables i finalment instal·leu el programa.

```
apt install -y lsb-release wget apt-transport-https
wget -O /usr/share/keyrings/riot-im-archive-keyring.gpg https://packages.riot.im/debian/riot-im-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/riot-im-archive-keyring.gpg] https://packages.riot.im/debian/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/riot-im.list
apt update
apt install riot-web
```
##### Exercici 5

Amb aptitude, en mode *interactiu*, instal·la i desinstal·la `mc` (o al revés si ja estava instal·lat) 

> Des del terminal ponemos el comando  aptitude
> Pulsamos / para buscar el paquete
> Pulsamos + o - para instalar o desinstalar
##### Exercici 6

El concepte de package group (grup de paquets) de Fedora com es diu a Debian ? 

>  Meta-packages
##### Exercici 7

Quin o quines ordres ens permeten instal·lar aquestes tasques ? 

> taskel 
> apt-get install command^ --> Para versiones anteriores de taskel

##### Exercici 8

Com puc llistar les possibles tasques de que disposo ? 
> tasksel --task-packages lamp-server
##### Exercici 9

Mostra amb `dpkg` el contingut del paquet xterm? I tots els paquets instal·lats, amb la mateixa ordre?
> dpkg-query -l xterm --> Contenido del paquete
> dpkg-query -l --> Todos los paquetes instaladosq
##### Exercici 10

Tradueix del "llenguatge RPM" al "llenguatge DEB" les següents instruccions: 

dnf upgrade  ----> apt-get upgrade
dnf downgrade foo-1.0 (downgrade el paquet foo a la versió 1.0) ----> apt-get install foo=1.0
dnf list --installed  ----->  apt list --installed
dnf search  paquet ----> apt-cache search paquet
rpm -ql paquet  (o repoquery -l) ----> dpkg-query -l paquet
rpm -qf /bin/ping  (o dnf provides */ping)  ----> dpkg -S /bin/ping

##### Exercici 11

Que fa la següent instrucció ? 

```
aptitude -v moo 
```
> Muestra la informacion del paquete
i aquesta ? 

```
aptitude -vv moo
```
>Muestra el doble de informacion
i aquesta ? 

```
aptitude -vvv moo
```
>Muestra el triple de informacion
OBS: Per fer aquest exercicis és molt recomanable utilitzar els man corresponents o alguns enllaços com per exemple:

[Package Management Basics: apt, yum, dnf, pkg](https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg)

