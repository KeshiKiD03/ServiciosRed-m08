### Exercicis clonació de disc

*Definim la clonació de disc com el procés de fer una imatge d'una partició o
d'un disc dur sencer. Les aplicacions directes serien les còpies de seguretat i
la recuperació de dades.

Hi ha moltes eines de clonació. Nosaltres, com sempre estudiarem els clàssics,
en aquest cas: `dd`.*

##### Exercise 0

Aquesta comanda que serveix per copiar i fer conversions (copy/convert) van
pensar de dir-li `cc` però aquest nom ja estava agafat pel compilador de C de
manera que van correr la lletra una posició `dd`. Cert o fals? Investiga.

```
Es cert
```
> Actually, it stands for `Copy and Convert' and was renamed to `dd` only because `cc' was reserved for the C compiler! This is the authentic information I got from the man pages of our Unix-V7 on our university PDP 11. 

##### Exercise 1

Crea un fitxer buit de 650MB amb blocs de 1024KB.
```
dd if=/dev/zero of=Disc1.img bs=1024K count=650 
```
##### Exercise 2

Crea un fitxer *iso* d'un *cd* o *dvd*.
```
dd if=/dev/cdrom of=cdimg1.iso
```
##### Exercise 3

Crea un backup del primer disc dur, i després de la 2a partició del 2on disc
dur.
```
dd if=/dev/sda of=backup_sda.img
```

```
dd if=/dev/sdb2 of=backup_sdb2.img
```
Un cop creats els backups, es podria xequejar la consistència de la imatge dels
backups? Si la resposta és afirmativa, com ho faries?
```
Amb la comanda e2fsck o fsck es pot xequejar.
```

##### Exercise 4

Quan fem una imatge d'un disc o partició ens podem trobar amb el disc originalmalmès i, per tant, que provoqui errors. En aquest cas l'ordre `dd` deixa de llegir i finalitza el programa. Existeix alguna opció perquè l'ordre continuicopiant i, per exemple ompli de *nulls* la resta del bloc que tingui errors i després continui amb el següent?
```
dd if=/dev/sda of=discdur.img conv=sync,noerror 
```
##### Exercise 5

Com faries un backup del MBR? i del MBR + la taula de particions? Com ho
restauraries? (Millor no ho feu a casa)

Backup MBR 
```
dd if=/dev/sdb of=my.mbr bs=466 count=1
```

Restaurar MBR
```
dd if=my.mbr of=/dev/sdb bs=466 count=1
```

Backup MBR + taula particions
```
dd if=/dev/sdb of=my.mbr_part.bin bs=512 count=1
```

Restaurar MBR + taula particions
```
dd if=my.mbr_part.bin of=/dev/sdb bs=512 count=1
```
##### Exercise 6

Com ho faries per netejar el disc completament, tot zeros, per exemple?
```
dd if=/dev/zero of=/dev/sda bs=1M
```
##### Exercise 7

De quina manera podríem clonar i comprimir una imatge d'una partició? Afegeix
alguna opció perquè la còpia vagi més ràpid.
```
dd if=/dev/sda2 status=progress | gzip -c > segona_part.img.gz
```
Com faries per restaurar després?
```
gunzip -c segona_part.img.gz | dd of=/dev/sda2 status=progress
```
##### Exercise 8 

A diferència d'altres eines com `clonezilla`, `Ghost` o `partimage`, `dd`
emmagatzemarà **tota la partició** incloent, per tant, els blocs lliures. En
principi aquest *treball extra* no és excessiu sempre i quan es comprimeixi la
imatge i els blocs lliures no tinguin molta dispersió (partició molt
defragmentada). 

Hi ha una altre problema però, si els blocs lliures prèviament havien estat
utilitzats, contindran restes de fitxers eliminats i això implicarà que la
compressió no serà trivial.

La solució al problema anterior és fàcil però, només cal aconseguir *buidar*
els blocs lliures (que els blocs lliures siguin omplerts per 0's). D'aquesta
manera la compressió serà trivial i ocuparà molt menys.

Clonarem comprimint de 2 maneres, primer sense utilitzar aquesta tècnica i
després fent-la servir:

+ Crearem una partició d'uns 3 GB. Per a la primera manera podem utilitzar
`/dev/urandom` per omplir tota la partició amb un fitxer *ple de brossa* i
després l'eliminem. Còpiem posteriorment una bona quantitat de fitxers, per
exemple 500 MB.

+ Procedim a crear la imatge d'aquesta partició comprimint al mateix temps
(poseu l'ordre `time` davant).

+ Per a la 2a manera heu d'executar diferents ordres separades per `;`
representant:

	```
	mostro l'espai d'ús de la partició on em trobo ; creo un fitxer ple de zeros que ocupi tot l'espai lliure de la partició; mostro l'espai d'ús de la partició on em trobo ; elimino el fitxer ple de zeros d'abans ; mostro l'espai d'ús de la partició on em trobo 
	```

+ Finalment procedim a crear la imatge d'aquesta partició comprimint al mateix
temps (poseu l'ordre `time` davant).

##### Exercise 9

A la partició /dev/sdb3 d'un pen usb no es poden llegir les dades perquè hi ha
sectors defectuosos. Amb quina instrucció podem recuperar tots els sector que
no siguin defectuosos? 

##### Exercise 10

Coneixeu alguna altra manera de comprovar si s'ha fet correctament la imatge
d'una partició? (Hint: md5sum)
```
La comanda md5sum permet verificar si l'arxiu ha tingut canvis anteriorment, retora un valor unic, només cal comprovar aquest valor.
```
##### Exercici 11

L'ordre `dd` també permet fer certes conversions curioses. Troba quina seria
l'instrucció que et permetria convertir tot a majúscules o a minúscules un cert fitxer.
```
dd if=prova_min.img of=prova_mayus.img conv=ucase
```
##### Exercici 12

Tinc la imatge d'una partició, `sda2.img`, i vull veure el seu
contingut, quina ordre em permetrà veure el seu contingut (sense
restaurar la partició en un cap disc)?  
```
mount -o loop sda2.img /mnt
```

