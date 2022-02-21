## Christian Manalo

#### Fer un servei ​ myhello.service on generem un missatge de de benvinguda. Crear el .service de tipus ​ oneshot que significa que s’executa un cop i finalitza. Observeu que s’ha comentat la linia ​ StandardOutput perquè el echo no vagi al jorural sinó a la pantalla. El servei s’instal·larà en un target personalitzat anomenat ​ mytarget.target ​


```
[root@laptop-asus cmanalo]# vim /usr/lib/systemd/system/myhello.service 

[root@laptop-asus cmanalo]# cat /usr/lib/systemd/system/myhello.service 
[Unit]
Description=El meu primer servei

[Service]
Type=oneshot
ExecStart=/usr/bin/echo "Hola, este es mi primer service"
RemainAfterExit=true
ExecStop=/usr/bin/echo "Adios..."
#StandardOutput=journal

[Install]
WantedBy=mytarget.target

```
#### Fer un servei ​ myweb.service on creen un servei web basat en el servei de httpd. Cal instal·lar prèviament el paquet httpd. Crear-lo de tipus ​ fork engegant l’executable de httpd. El servei s’instal·larà en un target personalitzat anomenat mytarget.target .

```
[root@laptop-asus cmanalo]# cp /usr/lib/systemd/system/httpd.service /usr/lib/systemd/system/myweb.service 

[root@laptop-asus cmanalo]# cat /usr/lib/systemd/system/myweb.service 

[Unit]
Description=MY WEB SERVICE

[Service]
Type=forking
3ExecStart=/usr/sbin/httpd
ExecStop=/usr/bin/echo "Sayoonara web server myweb"
ExecStop=/usr/bin/pkill httpd
StandardOutput=journal

[Install]
WantedBy=mytarget.target
```

#### Fer un target d’arrencada personalitzat anomenat ​ mytarget.target basat en rescue.taget ​ que tingui el servei ​ gpm ​ , ​ myhello ​ i el ​ myweb ​ 
```
[root@laptop-asus cmanalo]# cat /usr/lib/systemd/system/mytarget.target

[Unit]
Description=MODE RESCAT mytarget
Documentation=man:systemd.special(7)
Requires=sysinit.target rescue.service gpm.service myhello.service myweb.service
After=sysinit.target rescue.service
AllowIsolate=yes

[Install]
Alias=rescat.target
```

#### Pensar a fer el ​ systemctl daemon-reload . ​ Sempre que es modifiquen els units (el contingut dels fitxers dels units) cal fer systemctl daemon-reload perquè systemd recarregi la configuració de les units.

#### Fer l’enable dels serveis ​ myhelo i ​ myweb . ​ Verificar amb list dependencies les dependències de ​ mytarget.target . ​ Llistar el seu directori ​ .wants ​
```
[root@laptop-asus cmanalo]# ln -s /usr/lib/systemd/system/myhello.service /etc/systemd/system/mytarget.target.wants/

[root@laptop-asus cmanalo]# ln -s /usr/lib/systemd/system/myweb.service /etc/systemd/system/mytarget.target.wants/

[root@laptop-asus cmanalo]# ls /etc/systemd/system/mytarget.target.wants/
myhello.service  myweb.service
```
myhello.target esta inactivo porque es tipo one shot

#### Reboot i iniciar el sistema indicant en el GRUB el target ​ mytarget.target ​Verificar amb ​ is-active ​ i ​ list-dependencies ​ que està actiu i què no està actiu.

#### Repetir-ho però en lloc de usar ​ myweb.service (apagar i disable de myweb) usar myssh.service o ​ myhttp.service ​ , tunejant els serveis originals http i sshd. Recordeu de fer el ​ daemon-reload ​ . Observar que si es requereix de xarxa per funcionar systemd ‘estira’ de ella.

```
[root@laptop-asus cmanalo]# cat /usr/lib/systemd/system/myhttpd.service 

[Unit]
Description=MY HTTPD

[Service]
Type=forking
ExecStart=/usr/sbin/httpd
ExecStop=/usr/bin/echo "Parando MY HTTPD"
ExecStop=/usr/bin/pkill httpd
StandardOutput=jounal

[Install]
WantedBy=mytarget.target
```

```
[root@laptop-asus cmanalo]# cat /usr/lib/systemd/system/mysshd.service 

[Unit]
Description=MY SSH

[Service]
Type=forking
ExecStart=/usr/sbin/sshd
ExecStop=/usr/bin/echo "Parando sshd"
ExecStop=/usr/bin/pkill sshd
StandardOutput=jounal

[Install]
WantedBy=mytarget.target
```