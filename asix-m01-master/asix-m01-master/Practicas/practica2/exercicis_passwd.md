# ASIX-M01 Escola del Treball
#### Christian Manalo Mañibo - isx9565961

**Haureu identificat que els camps del /etc/shadow són:**
```
● Login
● Password
● Date of last password change
● Minimum password age
● Maximun passord age
● Password warning period
● Password inactivity period
● Account expiration date
```

**El què cal és que entengueu què significa i per a què serveix cada camp. La manera
d’aprendre-ho serà practicant.**
**Les ordres amb les que treballarem aquest apartat i de les que heu de practicar-ne les
opcions són:**
```
❏ passwd
❏ chage
❏ cat /etc/shadow
❏ cat /etc/login.defs (observeu-ne els valors relacionats)
```

**Les principals accions a realitzar són: (​ heu de fer-les totes!​ )**

1.Identificar el contingut del camp password quan encara no se n’ha assignat cap.
> Només apareix amb 2 exclamacions (!!)

2.Identificar-ne el contingut quan té un password assignat
> Apareix un password encriptat ($6$QO5Y86jxyvRjFYmN$OmmWWuAgxSPYRd03WeRDtYUQQFy53.jh6Nb9tgZ7n5lrrDCVxx3O023TXmotyjgcm6Nfv/4yD/TwHV6qrOHHl0) 

3.Identificar-ne el contingut quan el password està bloquejat.
> Per poder bloquejar una password hem d'utilitzar la comanda **passwd -l new1**.
> Surt una exclamació davant de la password encriptat. (!$6$QO5Y86jxyvRjFYmN$OmmWWuAgxSPYRd03WeRDtYUQQFy53.jh6Nb9tgZ7n5lrrDCVxx3O023TXmotyjgcm6Nfv/4yD/TwHV6qrOHHl0s)

4.Identificar-ne el contingut quan és un usuari passwordless
> Amb la comanda **passwd -d new1** farem que l'usuari sigui un usuari passwordless. Només es pot utilitzar si ets root. No surt res al camp del password ( new1::18365:0:99999:7::: )

5.Bloquejar un compte d’usuari
> passwd -l new1

6.Desbloquejar un compte d’usuari
> passwd -u new1

7.Generar un compte d’usuari passwordless
> useradd new2 
> **No fa falta fer res mes perque per defecte el useradd crea usuaris sense contrasenya**

8.Amb l’ordre passwd veure les característiques del password d’un compte d’usuari.
> passwd -S new1

9.Amb l’ordre chage veure les característiques del password d’un compte d’usuari.
> chage -l new1

10.Establir a un password una determinada política (max, min, warning, etc).
> passwd -e -n -x -w -i new1

11.Modificar a un password valors de la seva política d’expiració.

### Politica password
**A. Posar un password que per exemple expira d’aqui tres dies. Preparar una cerveseta
(preferiblement voll dam) unes olivetes i pacientment esperar tres dies i verificar si un
cop transcorreguts el password ha expirat.**

```
[root@asus ~]# passwd --maximum=3 user1
Adjusting aging data for user user1.
passwd: 

[root@asus ~]$ su user1
Password: 
Warning: your password will expire in 3 days
```
B. Posar un password que per exemple expiri d’aquí tres dies i tot seguit canviar la data
del sistema i posar-la avançada tres dies per verificar si el password s’ha bloquejat o
no. L’inconvenient de provar-ho així és que usualment acabem deixant malament la
data del sistema. Per exemple a l’aula, a classe, no podem fer això perquè llavors es
queda penjat el kerberos i el nfs en no coincicir les dates del vostre ordinador i les
del servidor gandhi.

C. Fer trampa ​ (això mola) i modificar manualment el 3r camp on consta la data en que
hem establert el password. Aquest és el mecanisme ​ més perillós però és ​ el que
usarem!​ .

