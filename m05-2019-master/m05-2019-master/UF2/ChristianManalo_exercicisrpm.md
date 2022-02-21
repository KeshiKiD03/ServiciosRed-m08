### Enunciats dels exercicis del gestor de paquets rpm
## Christian Manalo Mañibo
Gestió de paquets i repositoris a Fedora. Instal·lació de software amb *rpm*

#### **Consultes**

##### Exercici 1

Llisteu tots els paquets instal·lats
> rpm -qa

##### Exercici 2

Descarregeu localment i instal·leu el paquet `tftp-server`.
> wget -c ftp://ftp.pbone.net/mirror/archive.fedoraproject.org/fedora/linux/releases/27/Everything/x86_64/os/Packages/t/tftp-server-5.2-22.fc27.x86_64.rpm

> rpm -ivh tftp-server-5.2-22.fc27.x86_64.rpm

##### Exercici 3

Llisteu els components del paquet `tftp-server`.
>

##### Exercici 4

Llisteu els fitxers de documentació del paquet `tftp-server`.
> rpm -ql tftp-server

##### Exercici 5

Llisteu els fitxers de configuració del paquet `tftp-server`.
> rpm -qc tftp-server

##### Exercici 6

Llisteu els fitxers executables del paquet `tftp-server`.
>

##### Exercici 7

Mostreu informació del paquet `tftp-server`.
>rpm -qi tftp-server

##### Exercici 8

Llisteu les dependències del paquet `dhclient`.
>

##### Exercici 9

Llisteu les capabilities del paquet `dhclient`.
>

##### Exercici 10

Llisteu els scripts pre i post instal·lació del paquet `dhclient`.
>

##### Exercici 11

Identifiqueu a quin paquet pertany l'ordre `useradd`.
> rpm -qf /usr/sbin/useradd

##### Exercici 12

Identifiqueu a quin paquet pertany el `grub`.
>rpm -qf /boot/grub2/grub.cfg

#### **Instal·lar, actualitzar i esborrar**

##### Exercici 13

Actualitzeu el paquet `mc`.
> rpm -Uvh mc

##### Exercici 14

Elimineu el paquet `mc`.
> rpm -e mc

#### **Rebuild**

##### Exercici 15

Regenereu la base de dades de `rpm`.
> rpm --rebuilddb
