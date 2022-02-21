### Exercicis introducció a SSH

_Treballarem ara amb informació encriptada mitjançant SSH. Primer de tot hem de
comprovar que tenim instal·lats els paquets adients. Aquest servei és tan útil
per a a les comunicacions que normalment els paquets necessaris ja es troben
instal·lats._

_Aquesta llista d'exercicis eminentment pràctica s'adapta a una infraestructura
domèstica. Suposant que hi ha al menys un ordinador a casa i un mòbil o tableta
android. Si algú disposa de dos ordinadors amb Linux no cal el dispositiu
android, tot i que no deixa de ser una pràctica interessant._


##### Exercici 1

Que vol dir *SSH*? Defineix *SSH*. A quina capa del model *TCP/IP* es troba
aquest protocol?

> SSH vol dir secure shell, es un protocol que facilita les comunicacions segures ente dos sistemes utilitzant l'arquitectura client/servidor. I es troba a la capa d'aplicació.

##### Exercici 2

*ESCRIPTORI*

Quin és el paquet server per a Fedora 27? I el paquet client per a Fedora 27?
```
El paquet de server es openssh-server i el de client es openssh-clients
```

Per saber si un cert paquet està instal·lat al nostre sistema:

```
rpm -aq | grep paquet
```

Per trobar tots els paquets disponibles (instal·lats i no instal·lats) que es
diuen com el paquet que busquem:

```
dnf search paquet
```

I amb l'ordre:

```
rpm -qi paquet
```

es troba informació extra del paquet «paquet»

*MÒBIL*

Instal·larem l'app repositori d'aplicacions lliures *f-droid*. Quin permís ens
demanarà el nostre dispositiu android al no ser una app que es troba a la *Play
store*?

Instal·larem l'emulador de terminal android *termux* des de *f-droid*. Un cop instal·lat termux, l'executem, i instal·lem des de la terminal *termux* el paquet de nom semblant al de Fedora que ens proporciona el client i el servidor SSH alhora.

##### Exercici 3

Com inicialitzem el servei ssh al servidor ? i perquè arrenqui cada cop que
s'iniciï el sistema?
> systemctl start sshd 

> systemctl enable sshd
##### Exercici 4 

On es troba el fitxer de configuració del servidor? I del client? Quina
directiva (i de quin fitxer?) permet [o no] accedir a l'usuari root remotament?
I quina directiva podria permetre (i de quin fitxer?) permet [o no] filtrar
usuaris per accedir remotament?

> Els fitxers de configuració del servidor i del client es troba a /etc/ssh. El del servidor es sshd_config es pot filtrar per usuaris i permet accedir l'usuari root, i el del client es sshd_config.


##### Exercici 5

Què contè el fitxer `~/.ssh/known_hosts`? (podem tornar a fer un cop d'ull a
aquest fitxer després de fer l'exercici següent)
**Abans de fer la conexió**
> No mostra res perque no s'ha conectat ningú

**Despres de fer l'exercici**
> Mostra el host que s'ha connectat anteriorment.
```
$ cat .ssh/known_hosts
|1|jmkuud40JJq2hLq5bBrKwFyUlqk=|vTO2zLOSJeekNM7/2IJQBnmts/0= ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBAN+JNGAkYi8fYhWQraRm646YHiobEomfB06pmxuUtNGak3ZWO9fBpLD73kKnjD5sbfeFCCQOZYjZjZyDYmie10
```
##### Exercici 6

Com fem una connexió des del client al servidor, mantenint una sessió interactiva? 
> ssh *usuari*@*hostservidor/ipservidor*

##### Exercici 7

I si l’usuari per accedir al servidor és el mateix que l’usuari que utilitzem
al client, com escriuries l’ordre anterior?
> ssh *hostservidor/ipservidor*

##### Exercici 8

Com executem una única comanda des del client al servidor? Per exemple si volem
llistar el directori tmp del servidor `ls -l /tmp`
> ssh *usuari*@*hostservidor/ipservidor* && ls -l /tmp && exit

##### Exercici 9

Quin és el port per defecte amb el protocol SSH?
> El seu port per defecte es el 22

Per a Android també?
> Si.

Com s'indica un port diferent del 22 que és el port per defecte, com seria l’ordre per obrir una sessió `ssh`?
> ssh *hostservidor/ipservidor* -p 26

##### Exercici 10 

Ara sense connectar-nos remotament volem copiar un fitxer de la màquina remota,
	el nom del qual coneixem, que es troba a `/tmp`. Quina seria l'ordre?
	Comproveu-lo. I si fos un directori?

> scp *hostservidor/ipservidor*:/tmp/ .

**Si fos un directori només hem de posar el -r de recursiu.**
> scp -r *hostservidor/ipservidor*:/tmp .

##### Exercici 11

I si volem copiar com abans (de forma remota) però el port per on escolta SSH
també ha canviat, per exemple el 8022?

> scp -P 8022 -r *hostservidor/ipservidor*:/tmp .
##### Exercici 12

Com faries la connexió ssh des de el navegador d'arxius (Files, nautilus)?
> Nautilus > otras ubicaciones > Conectar servidor > sftp://ipservidor o ssh://ipservidor
##### Exercici 13

Per si de cas, feu una còpia del fitxer original `/etc/ssh/sshd_config` (`/etc/ssh/sshd_config.bak`) i feu els següents canvis a `/etc/ssh/sshd_config`:

+ No permetre l'accès a *root*.
+ Permetre només l'accès a un isxXXXX i a un usuari local.
+ Comproveu que tot funciona

Considerem que el servidor és l'escriptori.

**Hem d'editar el fitxer sshd_config. Per defecte esta restringit l'acces de root pero si volem cambiar només hem de posar PermitRootLogin Yes/No i si volem filtrar per usuaris només hem de posar AllowUsers nom_usuari.**


> vim /etc/ssh/sshd_config

```
# Authentication:

#LoginGraceTime 2m
PermitRootLogin No
AllowUsers isx9565961 
#StrictModes yes
#MaxAuthTries 6
#MaxSessions 10

```

**Per comprovar només hem de reiniciar el servidor.**

> systemctl restart sshd

##### Troubleshooting

* La versió de termux no és compatible amb el teu sistema android.
* Una possible solució és habilitar els repositori de versions antigues a f-droid (a la PLAY STORE això o no es pot fer, o té més dificultat): [Incompatible versions](https://github.com/termux/termux-app/issues/1353)

