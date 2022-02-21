### Exercicis del gestor de paquets DNF

Gestió de paquets i repositoris a Fedora. Instal·lació de software amb *dnf*

##### Exercici 1.

Llisteu tots els paquets instal·lats.
> dnf list installed

##### Exercici 2.

Amb quina opció `dnf` ens mostra a quin paquet pertany l’ordre `useradd`?
> dnf provides useradd

> dnf search useradd
##### Exercici 3.

Instal·leu el paquet mc.
> dnf install mc

##### Exercici 4.

Intenteu instal·lar de nou del paquet mc.
> dnf reinstall mc

##### Exercici 5.

Quina ordre em troba tots els paquets que continguin la cadena libreoffice?
(Filtra el langpack de català)
> dnf search libreoffice-langpack-ca

##### Exercici 6.

Actualitzeu (que no instal·leu) el pack de català de libreoffice a la darrera
versió. (Si ja està instal·lat català, castellà i anglès prova amb el francès: *fr*). Com actualitzaries tot el sistema?
> dnf downgrade libreoffice-langpack-ca

> dnf upgrade libreoffice-langpack-ca

##### Exercici 7.

Instal·leu el grup Virtualization, al menys de dues maneres diferents.
> dnf install @virtualization

> dnf group install virtualization

##### Exercici 8.

Llisteu tots els grups de paquets.
> dnf group list

##### Exercici 9.

Llisteu tots els repositoris configurats

- Per defecte, que ens surt? És a dir, l'ordre que hem utilitzat ens mostra
  tots els repositoris o només els habilitats (*enabled*)?
> dnf repolist   `#  Només mostra els habilitats`

- si els volem tots, tants els habilitats com els que no (*enabled/disabled*),
  quina seria l'ordre?
> dnf repolist all

##### Exercici 10.

Instal·leu el repositori necessari per poder instal·lar després `riot` (un
client del protocol matrix)

En realitat, que hem fet instal·lant aquest repositori? Quines variables em
diuen si el respoitori està activat? Quina variable em diu a quina adreça va a
buscar els paquets del repositori?

##### Exercici 11.

Deshabiliteu el repositori anterior amb una ordre des de la consola i després
comproveu que ha canviat la variable a la que es feia referència abans.
Comproveu que no es pot instal·lar *riot*. Torneu a activar-lo després i
instal·leu riot.

##### Exercici 12

(Exercici descriptiu) Instal·leu amb `dnf` el paquet `qvwm` d'[aquest
enllaç](http://pkgs.org). Si no trobeu exactament la vostra distribució feu
servir la que més s'aproximi.

`qvwm` és un gestor de finestres (en anglès *window manager*), una mica
especial i antic. La majoria d'aplicacions no funcionen perquè són paquets que
no estan instal·lats.

Un cop estigui instal·lat podeu canviar-vos a una consola de text
(\<Ctrl\>+\<Alt\>+\<F3\> per exemple) i *loguejar-vos*.

Un cop dintre podeu executar com a root les següents ordres:

* Arrenco el servidor de les X's  i l'envio al display (pantalla) número 1 (se
  suposa que el 0 està ocupat)

    ```
    Xorg :1 &
    ```

* Executo aplicacions gràfiques (que fan el paper de client) passant-li el
  display del servidor, com per exemple:

    ```
    firefox --display=:1 &
    ```

*  Arrenco el window manager `qvwm` perquè gestioni les finestres de les
   aplicacions que utilitzin el servidor arrencat prèviament.

    ```
    qvwm --display :1 &
    ```

* Altres aplicacions gràfiques que podríem executar:

    ```
    chromium-browser --display=:1 &
    nautilus --display=:1 &
	```

NOTA: Si no funciona l'enllaç per trobar `qvwm` feu servir un altre *windows manager* com per exemple `twm` i/o `fvwm` (un cop instal·lat feu man per esbrinar com li passem el número de *display*)

> dnf install fvwm

> fvwm -d :1 &


OBS: @System no és un repositori sinó la manera d'indicar que el paquet ja està
instal·lat al sistema
