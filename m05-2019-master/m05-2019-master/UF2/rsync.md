#### Christian Manalo - isx9565961

### Exercicis rsync

##### Exercici 0

Què vol dir rsync?
> remote sync (sincronització remota)

De quants formes es pot utilitzar rsync?
> Es pot utilitzar de dues formes, localment o remotament
##### Exercici 1

Imiteu el comportament de `cp [-a]` amb `rsync`, és a dir feu servir rsync de
forma local amb algun directori vostre. 

Mireu quina opció us manté parcialment els fitxers que es transfereixen (i per
tant en cas de que es deixi de transferir dades sense haver acabat la còpia els
fitxers que s'hagin transferit parcialment estiguin ja copiats al directori
destí).
> rsync -aP m05/ /tmp

##### Exercici 2

Ara volem que es mostri una barra de progrés durant la transferència.
> rysnc -a --info=progress2 m05/ /tmp
##### Exercici 3

Que fa l'opció `-a`? I l'opció `-vv`? I `-z`?
> -a: mode arxiu, permet copiar fitxers de forma recursiva y conserva enllaços simbolics, permisos fitxers, propietat de usuaris y grups...

> -vv: Mode detallat 

> -z: comprimeix les dades dels fitxers

##### Exercici 4

Hi ha alguna opció que faci una execució de prova (un test) sense fer realment
la còpia (la sincronització)?

> La opció -n fa una simulació.
##### Exercici 5

Per defecte s'esborren els fitxers a destí si a l'origen ja no existeixen (per
exemple, en una 2a sincronització)?

##### Exercici 6

Són equivalents les instruccions?

```
rsync -r origen desti
```

```
rsync -r origen/ desti
```

> No son equivalents. La primera instrucció copia tota la carpeta amb el seu contingut, pero la segona instrucció només copia el contingut de la carpeta.
##### Exercici 7

Com indico a l'ordre `rsync` que vull utilitzar el protocol `ssh`?
> Només hem de utilitzar la opció -e.
##### Exercici 8

Treballem com a sysadmins, ja tenim enllestida la configuració de `ssh`, hem
comprovat que rsync està instal·lat a la màquina client i procedeixo a fer una
primera sincronització remota. Que obvietat podria haver oblidat, de manera que
no es pogués fer la sincronització? 
> Hem de activar el dimoni del ssh
##### Exercici 9

Tot i que a casa o a l'escola els valors/noms siguin diferents, per tenir tots la mateixa resposta a l'exercici, suposarem que tenim dos ordinadors i dos usuaris amb les següents característiques:

* Servidor que farà el backup
	* hostname: servidor_backup
	* usuari: super_backup
	* directori a on es desa el backup: /opt/backup_rsync_docs/

* Ordinador que té les dades (de les quals es farà el backup)
	* hostname: ordinador_dades
	* usuari: super_dades
	* directori del qual es fa backup: /opt/docs

*Potser necessitareu que root crei els directoris adients a `/opt` i canviï el propietari*

Quina seria l'ordre que sincronitzaria, és a dir que copiaria el contingut de
`/opt/docs` a `/opt/backup_rsync_docs/` de manera que fos una còpia idèntica?
Estem suposant que l'ordre l'executem des de *servidor_backup*. Utilitzem les
opcions adients que hem comentat als exercicis anteriors.

**El meu cas (movil)**
> rsync -av -e "ssh -p 8022" u0_a194@192.168.1.36:/data/data/com.termux/files/home/ /home/chriswar/

**Practica**
> rsync -av -e "ssh -p 8022" super_dades@ordinador_dades:/opt/docs /opt/backup_rsync_docs/
##### Exercici 10

Si heu fet l'exercici anterior bé se us haurà demanat la contrasenya de
l'usuari *super_dades* al intentar connectar-vos mitjançant `ssh`. Com que serà
una tasca que es repetirà sovint es podria establir una *certa* confiança. 

En efect, l'únic que s'ha de fer és generar una parella de claus pública i
privada sense contrasenya i guardar-la a `.ssh/authorized_keys`. 

Des del servidor generem una clau de ssh, utilitzem la comanda 
> $ ssh-keygen


A banda de decidir quin user/pc ha de fer segons què, hi ha una ordre força
interessant per estalviar-vos la part final: `ssh-copy-id`
**Copiem la nostre clau publica i ho enviem el client**
> ssh-copy-id -p 8022 -i /home/chriswar/.ssh/id_rsa.pub u0_a194@192.168.1.36
##### VERSIÓ TELEMÀTICA

Només teniu un ordinador disponible de manera que no podeu jugar amb dos hosts
a la vostra xarxa? Teniu un Android? Llavors si el teniu connectat a la mateixa
xarxa que l'ordinador podreu jugar amb `ssh` i `rsync`:

Tot i que és possible fer servir Google Play, podeu activar la instal·lació de
programari de tercers al sistema android i un cop fet això:

* Instal·lar-se el [repositori d'aplicacions lliures
f-droid](https://f-droid.org/FDroid.apk) des de [la seva
web](https://f-droid.org/)

* Un cop actualitzats els respositoris de f-droid: instal·lar-se la terminal
[*termux*](https://wiki.termux.com/wiki/Main_Page) des de f-droid.

* Des de dintre de la terminal `termux` es poden instal·lar paquets, per
exemple:
	
	```
	pkg install openssh  # això instal·larà el servidor i client
	```

	```
	pkg install rsync
	```

* Per engegar el dimoni `ssh` haureu d'executar des de `termux` la instrucció
`sshd` i tenir en compte que el port del servidor ssh aquí és el 8022 en
comptes de l'habitual 22.


Finalment substituiu el que calgui de l'exercici 9 per fer el següent:

Volem tenir un backup (amb `rsync` és clar) de les fotos del nostre dispositiu Android, només les que es troben a /sdcard/DCIM

Si tenim el mòbil rootejat no haurem de fer res més, si no és així dintre de termux s'ha d'executar l'ordre:

```
termux-setup-storage
```

i quan es demani si permetem a *termux* accedir a les fotos, media i fitxers acceptem.

Com bons administradors que sou, abans de fer qualsevol experiment, fareu una còpia inicial de totes les fotos que tingueu.

> rsync -av --info=progress2 -e "ssh -p 8022" u0_a194@192.168.1.36:/sdcard/DCIM/Camera /home/chriswar/Pictures

##### LINKS

+ [Article molt interessant de rsync](http://www.mikerubel.org/computers/rsync_snapshots/)
+ [Un altre article de rsync](https://linuxgazette.net/104/odonovan.html)
+ [rsync ubuntu](https://help.ubuntu.com/community/rsync)
+ [rsync archlinux](https://wiki.archlinux.org/index.php/rsync)

