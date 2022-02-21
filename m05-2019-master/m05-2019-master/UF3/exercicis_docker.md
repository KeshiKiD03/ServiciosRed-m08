## Exercicis introducció DOCKER
### Christian Manalo - isx9565961

##### Exercici 1

A partir del que s'ha fet al document d'introducció a docker, crea 5 containers més de noms pc02, pc03, pc04, pc05, pc06, però amb una única ordre. Fes servir un `for` al bash i tampoc estaria de més fer servir {1..3}, {a..z} {900..999}).
Abans de fer-ho, creus que es baixarà 5 vegades la imatge de dockerhub `jamoros/fedora:software_xarxes` ?

```
La imatge de dockerhub no es baixarà perque ja la tenim localment
```
> $ for nom in pc0{1..6}; do docker run --cap-add=NET_ADMIN  --name $nom -h $nom -it jamoros/fedora:software_xarxes ; done

##### Exercici 2

Com s'aconsegueix entrar en un container del qual estem "detached" ? Escriu i executa una ordre de manera que puguis accedir al pc01.
> docker attach pc01

##### Exercici 3

Un cop estem dintre podem executar ordres com per exemple:

```
[root@pc01 /]# echo $HOSTNAME 
pc01
[root@pc01 /]# ip a show dev eth0
4: eth0@if5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
```

però sense necessitar d'entrar en cada una de les màquines una a una, com podríem automatitzar les ordres anteriors per als 6 pc's?
```
[cmanalo@laptop-asus ~]$ for i in pc0{1..6}; do docker start $i &>/dev/null ; docker exec $i bash -c 'echo $HOSTNAME'; docker exec $i ip a show dev eth0; done
pc01
55: eth0@if56: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
pc02
57: eth0@if58: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:03 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.3/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
pc03
59: eth0@if60: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:04 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.4/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
pc04
61: eth0@if62: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:05 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.5/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
pc05
63: eth0@if64: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:06 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.6/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
pc06
65: eth0@if66: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:07 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.7/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
[cmanalo@laptop-asus ~]$ 
```


##### Exercici 4

- Escolliu ara dos contenidors, per exmple pc01 i pc02, per poder fer-los servir un de servidor de ftp i l'altre de client ftp.
```
SERVIDOR: pc01
CLIENT: pc02
```
- Quin servidor ftp és el clàssic que s'utiliza en entorns linux? Quin és el client ftp més habitual? Instal·leu-los a les màquines respectives.
```
El mes habitual en servidors es VSFTPD i en client  es FTP.
```
**Des de pc01**
> dnf -y install vsftpd

**Des de pc02**
> dnf -y install ftp


- Aquest contenidors linux que teniu són molt bàsics, tant que no existeix l'ordre `systemctl` i per tant no podreu engegar el servidor `ftp` tal i com heu fet altres vegades. Haureu de trobar on està l'executable i executar-lo.

**Des de pc01**

```
Instalem la comanda which per saber on es troba l'executable
[root@pc01 /]# dnf -y install which

Busquem l'executable
[root@pc01 /]# which vsftpd
/usr/sbin/vsftpd

Executem
[root@pc01 /]# /usr/sbin/vsftpd 

```


- Com penseu parar el servei quan feu algun canvi i necessiteu reiniciar-lo ?
```
Per poder parar el servei podem fer un kill del proces
```

- Finalment feu una prova senzilla, poseu un fitxer amb un missatge breu al servidor ftp, connecteu-vos des del client anònimament per descarregar-lo.

**Des de pc01**
```
[root@pc01 /]# cat > /var/ftp/pub/provaFTP
PROVA FTP

```
**Des de pc02 client**
```
[root@pc02 /]# ftp 172.17.0.2
Connected to 172.17.0.2 (172.17.0.2).
220 (vsFTPd 3.0.3)
Name (172.17.0.2:root): anonymous
331 Please specify the password.
Password:
230 Login successful.
Remote system type is UNIX.
Using binary mode to transfer files.
ftp> ls
227 Entering Passive Mode (172,17,0,2,240,140).
150 Here comes the directory listing.
drwxr-xr-x    2 0        0            4096 Jun 01 20:06 pub
226 Directory send OK.
ftp> cd pub
250 Directory successfully changed.
ftp> ls
227 Entering Passive Mode (172,17,0,2,34,213).
150 Here comes the directory listing.
-rw-r--r--    1 0        0              10 Jun 01 20:06 provaFTP
226 Directory send OK.
ftp> get provaFTP
local: provaFTP remote: provaFTP
227 Entering Passive Mode (172,17,0,2,148,49).
150 Opening BINARY mode data connection for provaFTP (10 bytes).
226 Transfer complete.
10 bytes received in 2.5e-05 secs (400.00 Kbytes/sec)
```
(No configureu la resolució de noms interna i feu servir les IP's de les màquines per connectar-vos)


###### OBS: Recordeu sempre que estigui executant-se el servei docker i que l'usuari habitual que feu servir pertanyi al grup `docker`.

 



