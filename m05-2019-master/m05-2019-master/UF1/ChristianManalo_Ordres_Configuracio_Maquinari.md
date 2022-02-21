### Ordres configuració maquinari

##### Exercici 1.

Volem actualitzar el firmware (BIOS) del nostre pc. Abans però ens agradaria saber si això es pot fer.
Amb quina ordre podríem esbrinar-ho? És actualitzable el firmware del teu pc?

> **Amb l'orde dmicode**
****
##### Exercici 2.

Relaciona definicions amb termes a definir:

1. Permet dividir l'espai del disc dur per diferents usos (a cada espai). **PARTICIONAMENT**
2. Permet tenir redundància, és a dir dades duplicades, per si s'avaria un dels discs. **LVM**
3. Permet que uns quants discs s'agrupin com si només fossin un. **RAID**
4. És una interfície "antiga" que permetia connectar disc durs, CD-ROM, disquets ... **IDE o ATA**
5. Podria "substituir" la interfície PCI Express per als discs d'estat solid (SSD) **M.2**
6. Són diferents interfícies de transferència de dades. **SCSI, SATA, USB, FireWire, eSATA, ~~Apple~~ Intel Thunderbolt**


****
##### Exercici 3. 

Amb quina ordre podríem veure els diferents connectors que tenim al nostre pc?
O informació de la torre/caixa/carcassa?

>**Amb l'ordre lspci**
****
##### Exercici 4.

Fa molt, molt de temps, a l'època Unix, la manera com els programes obtenien informació
dels processos que s'estaven executant era accedint directament al fitxer de la memòria
i interpretant directament les dades sense estructura que es trobaven (/dev/mem).
Així és com l'ordre ``ps`` aconseguia la informació.
Jugarem una mica amb aquest fitxer que representa la memòria, *observant* el seu contingut.
Utilitzeu les ordres:

```
cat /dev/mem | less
```
així com:
```
cat /dev/mem | grep -a "BIOS"
```
Una altra ordre molt interessant és:
```
strings /dev/mem
```
****
##### Exercici 5.

El mètode anterior tenia molts inconvenients: aplicacions d'usuari accedint de
forma directa a dades del sistema, crides al sistema cada cop que es volia
accedir a una part de les dades, *inexistència* d'algun tipus d'estructura per
manegar millor aquesta informació ...  Com a conseqüència de l'anterior es va
crear una nova forma d'accedir a la informació de manera més ordenada: el
sistema de fitxers `/proc`.

Feu un cop d'ull al directori `/proc`:

```
ls /proc
```

* Que són els directoris *numèrics* que hi ha dintre de ```/proc``` ?
> **Son directoris que corresponen a un proces en execució, un autolink que apunto al proces actual.**
* Llisteu el contingut d'un d'aquests directoris *numèrics*.
>**ls -l /proc/3**
* Observeu la mida de cada un d'aquests fitxers, es normal?
> **La seva mida no es normal perque diu que te la mida 0**
* Escolliu un, per exemple *cmdline* i mireu el seu contingut. 
>**BOOT_IMAGE=/boot/vmlinuz-4.18.19-100.fc27.x86_64 root=UUID=8995a828-2f0b-44ee-b07f-56d4a11eead8 ro**
****
##### Exercici 6.

Veiem un exemple de com tunejar algun dels valors del sistema mitjançant /proc.
Quan fem un ping a broadcast (i.e a tots les pc's de la nostra xarxa) per defecte Fedora no els retorna (per evitar atacs DoS)
Això ho podem veure amb:

```
cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts
1
```
Si volem que no els ignori, aquest fitxer hauria de contenir un 0, com ho faríem?
> **vim /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts**
****

##### Exercici 7.

Amb quina altra ordre es poden canviar aquests paràmetres?
> **echo 0 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts**
****
##### Exercici 8.

Malauradament ```/proc``` va *morir* d'èxit. La seva facilitat d'us va provocar que cada cop
més i més dades del sistema utilitzessin aquest directori, creixent de manera desmesurada fins a convertir-se
en un embolic difícil de gestionar.
De manera que es va dissenyar un un nou sistema per desfer l'embolic de /proc i proporcionar una mica d'estructura:
el sistema de fitxers *sysfs* o */sys*
Tot i així, tal i com hem vist, hi ha molta informació del sistema que és accessible amb ```/proc```.
Però els nous busos o drivers mostraran la seva informació a /sys

Mostreu el contingut d'algun fitxer dintre de /sys que us doni informació de la mida de la partició de disc del matí:

>**ls /sys/block/sda/sda5**
****
##### Exercici 9.

Com es diu el gestor de dispositius dinàmic (o sigui hot plugging)?
Quin és el sistema de fitxers virtual que conté informació sobre els dispositius actius?
Quan un dispositiu s'afegeix al sistema o es treu (es canvia el seu estat)
aquest gestor funciona executant certes regles (*rules*). A quins directoris es troben aquestes regles?
Feu un cop d'ull dintre.


****
##### Exercici 10.

Els dispositius PCI, aquells dispositius que es connecten amb una interfície tipus PCI,
es poden llistar amb l'ordre ```lspci```.
Quin fitxer del sistema conté la informació de tots els possibles dispositius PCI?
Si un dispositiu lspci no es troba al fitxer anterior, es pot fer alguna cosa?
Feu els listings 12, 13 i 14
>**Amb el listing 12, llista tots els dispositius PCI. $ lspci**
>**El listing 13 mostra l'arbre de topologia per a dispositius de la ranura 00 del meu sistema, utilitzant les opcions -t i -v. $ lspci ‑tvv ‑s \:00 **
>**El listing 14 mostra la sortida per als dispositius de so i gràfics NVIDIA del meu sistema amb aquest ordre $ lspci ‑d 10de\:**
****
##### Exercici 11.

Anàlogament els dispositius usb es poden llistar amb l'ordre ...?
>**Amb l'orde lsusb**
****
##### Exercici 12.

Relacioneu els elements de la primera llista amb amb els de la segona:

1. HID, dispositiu d'interfície humana. **teclat**
2. Dispositius de comunicació. **ethernet interface**
3. Dispositiu d'emmagatzematge de dades. **disc dur**
4. Dispositiu d'àudio. **microfon**
5. Dispositius irda **dispositius mèdics per raigs infraroigs**
6. Dispositius de vídeo. **webcam**

****
##### Exercici 13.

Fa molt de temps si un dispositiu no era configurat amb el kernel del sistema ja no podia ser utilitzat.
Al crèixer la quantitat de dispositius d'una banda i d'altra la necessitat de connectar dispositius hot plug,
el disseny del kernel va canviar.
Ara el kernel és mínim i es carreguen diferents mòduls (podem pensar que són drivers) per als diferents dispositius.

* Quina és l'ordre que ens llista tots els mòduls del kernel?
>**Amb l'ordre lsmod**
* Quina ordre ens mostra informació més detallada d'un modul concret?
>**Amb l'ordre modinfo**
* Quines ordres, que ja *no s'utilitzen*, serveixen per eliminar un mòdul o per afegir-lo?
>**Amb l'ordre insmod i rmmod**
* Quina és l'ordre que s'utilitza ara? Entre d'altres quines millores trobes respecte a les anteriors?
>**S'utilitza modprobe, amb un sol comanda es pot afegir o eliminar moduls.**
* Que fa el listing 22?
>**Carga el modul irnet**
****
##### Exercici 14.

Acabem d'instal·lar una targeta SCSI del fabricant Adaptec.
Amb quina ordre podríem esbrinar si ha estat reconeguda i quina entrada a /dev representa?
>**Amb l'ordre dmesg**
---

tags:
```
biosdecode
dmidecode
ls /sys/block
sysctl
lspci
lsusb
lsdev
cat
echo
lsmod
modprobe
modinfo
dmesg
>
```
