### Exercicis Màquines virtuals

#### Christian Manalo Mañibo - isx9565961

##### Exercici 0

* Mostreu informació dels paquets que s'instal·len amb el grup de
virtualització (a Fedora):
```
[cmanalo@laptop-asus UF3]$ dnf group info "Virtualization"
Last metadata expiration check: 0:02:34 ago on Wed 13 May 2020 08:42:31 PM CEST.

Group: Virtualization
 Description: These packages provide a graphical virtualization environment.
 Mandatory Packages:
   virt-install
 Default Packages:
   libvirt-daemon-config-network
   libvirt-daemon-kvm
   qemu-kvm
   virt-manager
   virt-viewer
 Optional Packages:
   guestfs-browser
   libguestfs-tools
   python3-libguestfs
   virt-top

```
* Instal·leu els paquets opcionals, que ens permetra jugar amb les *virt tools*.
```
[cmanalo@laptop-asus UF3]$ sudo dnf -y install virt-top
```
* Si volem que qualsevol usuari (no root) pugui utilitzar virt-manager, com ho
podem fer?

* Amb l'ordre `qemu-kvm` volem arrencar el nostre GRUB i seleccionar una
entrada que no utilitzi la partició que conté el sistema de fitxers de
l'amfitrió. Afegiu la RAM que sigui necessària.

* A quin directori s'emmagatzemmen els discos virtuals?

* A quin directori s'emmagatzemem les característiques de les *VM*? I de les
xarxes?

* Si intentem editar *a pèl* un dels fitxer XML que contenen les configuracions
  *hardware* de les MV que es troben al directori anterior veurem un warning
alertant-nos de quina és la manera dient de fer canvis en aquest fitxer. Quina
és aquesta forma?

##### Exercici 1

Munteu un servidor ssh amb una màquina virtual. Per a això:

* Decidiu amb quin tipus de xarxa serà més fàcil (o possible).

* Configureu el *guest* amb el tipus de xarxa escollit per a que pugui
funcionar com a servidor ssh.

* Intenteu fer un accés ssh des d'un ordinador extern.

##### Exercici 2

Munteu un servidor ftp amb una màquina virtual. Per a això:

* Decidiu amb quin tipus de xarxa serà més fàcil (o possible).

* Configureu el *guest* amb el tipus de xarxa escollit per a que pugui
funcionar com a *servidor ftp*:  `vsftp`. Activeu el dimoni.

* Intenteu fer un accés ftp des d'un ordinador extern. Utilitzeu un *client
ftp*: `ftp`. Nota: l'usuari que fareu servir com a login, `anonymous`, al servidor te com a nom `ftp`, comproveu que existeix al fitxer `/etc/passwd` i feu un cop d'ull al seu directori personal.

##### Exercici 3

Conversió entre plantilles de VM. A partir d'una imatge de VirtualBox `*.ova`
crearem una VM, convertint prèviament al format `*.qcow2`.

Utilitzarem el fitxer `Fedora24_CiscoPakcetTracer_DocumentacioCisco_6_9_16.ova`
que es troba tant a public. Podem però fer servir udpcast per distribuir per
broadcast el fitxer i no congestionar l'ample de banda.

Des de l'ordinador que ofereix el fitxer

```
udp-sender --file Fedora24_CiscoPakcetTracer_DocumentacioCisco_6_9_16.ova
```

Des dels receptors:

```
udp-receiver --file Fedora24_CiscoPakcetTracer_DocumentacioCisco_6_9_16.ova
```

* El primer pas serà *extreure* la imatge de disk continguda al fitxer
`Linkat.ova` amb l'ordre `tar`.

* Que representen cadascun dels fitxers trobats?

* Quina utilitat QEMU ens permet fer conversions d'imatges de disc?

* Comprova si està instal·lada aquesta eina i instal·la-la si fos necessari per
  després fer la conversió a format `qcow2`.

* Utilitzant l'eina `virt-install` instal·leu la imatge que acabeu de crear (i que hauria d'estar al directori habitual d'imatges) amb les següents característiques:
    * nom: F24
    * ram: 1024 (MB)
    * sist. op.: linux

##### Exercici 4

Quina ordre del paquet `libguestfs-tools` ens permet, entre d'altres coses:

* *Resetejar* una màquina virtual de manera que es pugui clonar una VM sense
  configuracions posteriors. Per exemple, eliminant claus de host SSH,
configuracions persistents de la xarxa o comptes d'usuaris

* *Customitzar* una màquina virtual de manera que es pugui
  clonar una VM amb una configuració concreta. Per exemple,
afegint claus SSH, comptes d'usuaris, etc.

(Per fer qualsevol de les operacions anteriors s'ha de apagar la
VM primer i si ens interessa preservar l'estat inicial del
guests'haurà de fer algun tipus de clonatge primer)

Quina ordre també del paquet `libguestfs-tools` ens permet alliberar cert espai
no utilitzat del disc imatge? 

##### Exercici 5 (virsh)

* A quin paquet es troba *virsh*?
* Llistar **totes** les màquines virtuals (les engegades i les que no ho estan)
* Arrenca una VM que està apagada:
* Mostrem ara només les VM's que estiguin engegades
* Amb quina eina es podrà mostrar la consola gràfica d'una VM concreta? El
  protocol utilitzat per accedir a aquesta consola gràfica és VNC o SPICE.
(Hint: virt-whatever...)
* Com s'apaga una VM? I com es reinicia? I si a l'apagar no ens fa gaire cas?
com hiverna? que es guarda al fitxer d'hibernació? i com desperta? com es
suspen? com es reprèn? I si vull saber l'estat de només una VM concreta? I si vull tenir tota la info d'una VM concreta? I si vull eliminar una VM? I si vull eliminar-la carregant-me el disc dur virtual?

##### Exercici 6

Volem connectar-nos a una consola de text d'una VM amb virsh, però per a fer
això no només necessito descobrir quina és l'opció per a virsh sinó també
configurar algun fitxer i algun *tweak* extra a la VM.

Configureu la VM per a poder permetre l'acces a una consola de text.

OBS: Per sortir de la sessió s'ha de fer \<Ctrl>\+\<Alt. Gr.\>+\<]\>

#####  Extras

Habitualment les eines que corren per sobre de `libvirt`, com poden ser
`virt-manager` o `virsh`, necessiten comptes d'usuari amb privilegis: root o
usuaris quepuguin fer servir root. Si volem però tenir alguns usuaris diferents
d'aquests amb privilegis per a aquests casos existeixen certes solucions; [en
aquest
enllaç](https://major.io/2015/04/11/run-virsh-and-access-libvirt-as-a-regular-user/)
podem trobar una possibilitat.  




