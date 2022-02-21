### Exercicis Màquines virtuals

Introducció: creació de Màquines Virtuals

##### Exercici 1

Utilitzeu la xuleta d'[instal·lació de kvm](instal_kvm.md) per poder
virtualitzar amb KVM i posteriorment creeu amb *virt-manager* alguna màquina
virtual a partir d'alguna _*.iso_ de les que es pot trobar a *gandhi*
consensuada amb el professor.

##### Exercici 2

El programa *virt-builder* ens permet construir VM d'una manera molt ràpida. Anem a treballar aquesta eina:
```
dnf install libguestfs-tools-c
```
* Llistem totes les imatges VM disponibles:
```
virt-builder --list
```

* Mostrem ara les notes d'instal·lació d'Ubuntu 18.04
```
virt-builder --notes ubuntu-18.04
```

* Quina ordre instal·la un fedora 28?
```
virt-builder fedora-28 
```

* Quin és el directori habitual a on es desen les _plantilles_ de les imatges baixades?
```
Es guarda al directori actiu
```

* Per defecte la imatge creada serà un fitxer _*.img_. Si vull canviar el nom del fitxer, quina opció he de fer servir?
```
Amb la opció -o de output
virt-builder fedora-28 -o mydisk.img
```
* I si vull canviar el format? _qcow2_ per exemple.
```
virt-builder fedora-28 --format qcow2
```

* Quina ordre m'instal·la un ubuntu 16.04 amb:
	* contrasenya de root *jupiter*
	* amb nom *ubuntu-16_04.qcow2*
	* al directori /var/lib/libvirt/images/ (tot i que virt-builder no necessita permís de root copiar en aquest directori¿?)
	* format _qcow2_
	* hostaname _virt.example.com_
	* instal·lant l'escriptori gràfic _xfce4_ 
	* actualitzant tots els paquets
	```
	virt-builder ubuntu-16.04 -o ubuntu-16_04.qcow2 --cache /var/lib/libvirt/images/ --root-password password:jupiter --format qcow2 --hostname virt.example.com --install "xfce4" --update
	```

##### Exercici 3

Creem amb virt-manager una VM a patir de la imatge Centos minimal de tipus
qcow2 que es troba a `/home/groups/inf/public/install/VM/`

------

*Tipus de xarxes a les VM*

##### Exercici 4

A partir de qualsevol de les VM instal·lades als exercicis anteriors, quina és la configuració (el tipus) de xarxa per defecte?

Quina IP té l'amfitrió del convidat
```
192.168.1.41
```
Quin *default gateway* té el convidat
```
192.168.122.1
```
Feu ping des de l'amfitrió al convidat:
```
[cmanalo@laptop-asus myimages]$ ping 192.168.122.182
PING 192.168.122.182 (192.168.122.182) 56(84) bytes of data.
64 bytes from 192.168.122.182: icmp_seq=1 ttl=64 time=0.368 ms
64 bytes from 192.168.122.182: icmp_seq=2 ttl=64 time=0.375 ms
```
Te conexió
Feu ping des del convidat a l’amfitrió
```
[root@localhost ~]$ ping 192.168.1.41
```
Te conexió

Feu ping des del convidat a un ordinador de la xarxa de classe
No te conexió
```
[root@localhost ~]$ ping 192.168.1.45
```
Feu ping des del convidat a internet (se suposa que hi ha internet des de l'amfitrió)
El convidat te internet ja que pot fer al domini google.com
```
[root@localhost ~]$ ping www.google.com
```
Feu ping des d'un altre ordinador de la xarxa de classe a l'ordinador convidat 

No te conexió, perque si anteriorment he fet la prova al reves, si el convidat no pot veure un altre ordinador de casa, aquell ordinador no pot veure el convidat.

##### Exercici 5

*[ALERTA: Per fer aquest exercici heu d'utilitzar al vostre ordinador amfitrió una interfície de xarxa ethernet, no pot ser wireless, tal i com podeu llegir auna de les notes importants del manual](https://wiki.libvirt.org/page/Networking#Bridged_networking_.28aka_.22shared_physical_device.22.29)*

Canvieu ara la xarxa per defecte que hi ha a una VM i feu servir una xarxa bridge amb *macvtap*.


Quina IP té l'amfitrió del convidat
```
192.168.1.55
```

Quin *default gateway* té el convidat
```
192.168.1.1
```

Feu ping des de l'amfitrió al convidat:
```
[cmanalo@laptop-asus ~]$ ping 192.168.1.52
PING 192.168.1.55 (192.168.1.55) 56(84) bytes of data.
64 bytes from 192.168.1.55: icmp_seq=1 ttl=64 time=0.368 ms
64 bytes from 192.168.1.55: icmp_seq=2 ttl=64 time=0.375 ms
```

Feu ping des del convidat a l’amfitrió
```
ping 192.168.1.55
```
Te conexió

Feu ping des del convidat a un ordinador de la xarxa de classe
```
No es troben
```

Feu ping des del convidat a internet (se suposa que hi ha internet des de l'amfitrió)
El convidat te internet ja que pot fer al domini google.com
```
[root@localhost ~]$ ping www.google.com
```

Feu ping des d'un altre ordinador de la xarxa de classe a l'ordinador convidat
```
No es troben
```

##### Exercici 6

Creeu una xarxa virtual *isolated* `192.168.150.0/24` amb DHCP i configureu dues màquines (clonant una abans si és necessari) responeu a les mateixes preguntes:

Quina IP té l'amfitrió del convidat
```
192.168.150.6
```

Quin *default gateway* té el convidat
```
192.168.150.1
```

Feu ping des de l'amfitrió al convidat:
```
[cmanalo@laptop-asus ~]$ ping 192.168.150.153
PING 192.168.150.153 (192.168.150.153) 56(84) bytes of data.
64 bytes from 192.168.150.153: icmp_seq=1 ttl=64 time=0.368 ms
64 bytes from 192.168.150.153: icmp_seq=2 ttl=64 time=0.375 ms
```

Feu ping des del convidat a l’amfitrió
```
ping 192.168.150.6
```
Te conexio


Feu ping des del convidat a un ordinador de la xarxa de classe

Feu ping des del convidat a internet (se suposa que hi ha internet des de l'amfitrió)
```
ping: www.google.com: Name or service not known
No te conexio
```
Feu ping des d'un altre ordinador de la xarxa de classe a l'ordinador convidat

##### Exercici 7 (virsh)

* Com podem veure amb l'ordre `virsh` totes les xarxes virtuals que gestiona
libvirtd? Opció interactiva i no interactiva.
```
virsh net-list
```
* Com desactivem una xarxa?
```
virsh net-destroy "network"
```

* Com llistem totes les xarxes, tant actives com inactives?
```
virsh net-list --all
```
* Com activem una xarxa inactiva?
```
virsh net-start "network"
```