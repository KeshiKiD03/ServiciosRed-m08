## Christian Manalo

### Targets d’arrencada

##### 1. En tots els casos verificar el target actual. Llisteu els processos i els serveis.
```
[root@laptop-asus cmanalo]# systemctl get-default
graphical.target
```
Listar todos los procesos
```
pstree -psa
```
##### 2. Configurar el sistema establint default.target a mode multi-user.target.
```
[root@laptop-asus cmanalo]# systemctl set-default multi-user.target
```
##### 3. Manualment canviar a graphical.target amb isolate.
```
[root@laptop-asus cmanalo]# systemctl isolate graphical.target
```
##### 4. Reiniciar el sistema i al grub etablir l’opció de iniciar en mode emergency.target.
Cuando estemos en el grub, pulsamos la tecla "e" y editamos esta linia.
```
linux16 /boot/vmlinuz-4.18.19-100.fc27.x86_64 root=/dev/sda5 ro rhgb quiet LANG=en_US.UTF-8
systemd.unit=emergency.target
```
##### 5. Reiniciar i indicar al grub l’opció del kernel per iniciar a rescue.target.
Cuando estemos en el grub, pulsamos la tecla "e" y editamos esta linia.
```
linux16 /boot/vmlinuz-4.18.19-100.fc27.x86_64 root=/dev/sda5 ro rhgb quiet LANG=en_US.UTF-8
systemd.unit=rescue.target
```
##### 6. Canviar de target amb l’ordre isolate activant multi-user.target.
```
[root@laptop-asus cmanalo]# systemctl isolate multi-user.target
```
##### 7. Restablit per defecte graphical.target i reiniciar el sistema.
```
[root@laptop-asus cmanalo]# systemctl set-default graphical.target && reboot
```
##### 8. Amb isolate indicar que es vol accedir al target poweroff.target.
```
[root@laptop-asus cmanalo]# systemctl isolate poweroff.target
```
##### 9. Iniciar el sistema en mode emergency.target. Llistar els processos, l’arbre de processos, els units i les dependencies. Cal indicar el password de root? Hi ha multiples sessions de consola?
Para iniciar el sistema en mode emergency hay que editar el grub, pulsando la tecla "e"
```
linux16 /boot/vmlinuz-4.18.19-100.fc27.x86_64 root=/dev/sda5 ro rhgb quiet LANG=en_US.UTF-8
systemd.unit=emergency.target
```
No hace falta introducir el password de root , tampoco hay multiples sesiones de consola

##### 10. Iniciar el sistema en mode init=/bin/bash. Llistar els processos, l’arbre de processos, els units i les dependencies. Cal indicar el password de root? Hi ha multiples sessions de consola?

Tenemos que ir a las opciones del kernel del grub y poner lo siguiente:
```
init=/bin/bash rw
```

No hace falta introducir el password de root , tampoco hay multiples sesiones de consola


### Gestió bàsica de serveis

##### 11. Instal-leu els serveis httpd, gpm, xinetd i ssh.
```
[root@laptop-asus cmanalo]# dnf -y install httpd gpm xinetd openssh
```
##### 12. Activeu els serveis httpd i ssh i configureu-los disabled. Verifiqueu que estan actius. Reiniciar el sistema i observar que no estan Iniciar el sistema.
```
[root@laptop-asus cmanalo]# systemctl start httpd
[root@laptop-asus cmanalo]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor pres>
   Active: active (running) since Sat 2020-05-09 14:53:42 CEST; 58s ago
     Docs: man:httpd.service(8)
 Main PID: 4787 (httpd)

```
```
[root@laptop-asus cmanalo]# systemctl start sshd
[root@laptop-asus cmanalo]# systemctl status sshd
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; disabled; vendor prese>
   Active: active (running) since Sat 2020-05-09 14:54:11 CEST; 2s ago
     Docs: man:sshd(8)
```
##### 13. Amb els serveis inactius configurar-los (httpd i sshd) com a enabled. Verificar que estan enables però inactius. Reiniciar el sistema i observar que estan actius i enabled.
```
[root@laptop-asus cmanalo]# systemctl stop httpd

[root@laptop-asus cmanalo]# systemctl enable httpd

Created symlink /etc/systemd/system/multi-user.target.wants/httpd.service → /usr/lib/systemd/system/httpd.service.
[root@laptop-asus cmanalo]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor prese>
   Active: inactive (dead)

[root@laptop-asus cmanalo]# systemctl is-active httpd
inactive

[root@laptop-asus cmanalo]# systemctl is-enabled http
enabled

```

```
[root@laptop-asus cmanalo]# systemctl stop sshd

[root@laptop-asus cmanalo]# systemctl enable sshd

Created symlink /etc/systemd/system/multi-user.target.wants/sshd.service → /usr/lib/systemd/system/sshd.service.

[root@laptop-asus cmanalo]# systemctl status sshd
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset>
   Active: inactive (dead)
     Docs: man:sshd(8)
           man:sshd_config(5)

[root@laptop-asus cmanalo]# systemctl is-active sshd
inactive

[root@laptop-asus cmanalo]# systemctl is-enabled sshd
enabled
```
##### 14. Fer mask del servei httpd i observar que no es pot fer enable. Fer unmask.

```
[root@laptop-asus cmanalo]# systemctl mask httpd
Created symlink /etc/systemd/system/httpd.service → /dev/null.

[root@laptop-asus cmanalo]# systemctl enable httpd
Failed to enable unit: Unit file /etc/systemd/system/httpd.service is masked.
```


### Serveis i Units

##### 15. Identificar el fitxer .service del servei xinetd. Identificar l’executable.
```
[root@laptop-asus cmanalo]# rpm -ql xinetd | egrep ".service"
/usr/lib/systemd/system/xinetd.service

[root@laptop-asus cmanalo]# rpm -ql xinetd | egrep "/usr/sbin"
/usr/sbin/xinetd
```
##### 16. Configurar manualment amb symlinks el enable del servei xinetd i verificar-ho.
```
[root@laptop-asus cmanalo]# ln -s /usr/lib/systemd/system/xinetd.service /etc/systemd/system/multi-user.target.wants/xinetd.service

[root@laptop-asus cmanalo]# systemctl is-enabled xinetd
enabled
```
##### 17. Eliminar el enable del servei xinetd manualment amb el symlink. Verificar-ho.
```
[root@laptop-asus cmanalo]# rm /etc/systemd/system/multi-user.target.wants/xinetd.service
rm: remove symbolic link '/etc/systemd/system/multi-user.target.wants/xinetd.service'? y

[root@laptop-asus cmanalo]# systemctl is-enabled xinetd
disabled
```



### Arquitectura de systemd

##### 18. Instal·la el paquet xinetd. Llista els seus components.
```
[root@laptop-asus cmanalo]# dnf -y install xinetd
```
```
[root@laptop-asus cmanalo]# rpm -ql xinetd
/etc/xinetd.conf
/etc/xinetd.d
/etc/xinetd.d/chargen-dgram
/etc/xinetd.d/chargen-stream
/etc/xinetd.d/daytime-dgram
/etc/xinetd.d/daytime-stream
/etc/xinetd.d/discard-dgram
/etc/xinetd.d/discard-stream
/etc/xinetd.d/echo-dgram
/etc/xinetd.d/echo-stream
/etc/xinetd.d/tcpmux-server
/etc/xinetd.d/time-dgram
/etc/xinetd.d/time-stream
/usr/lib/.build-id
/usr/lib/.build-id/56
/usr/lib/.build-id/56/8c97511f366a49d15a4ec747637f66d80ff6e1
/usr/lib/systemd/system/xinetd.service
/usr/sbin/xinetd
/usr/share/doc/xinetd
/usr/share/doc/xinetd/CHANGELOG
/usr/share/doc/xinetd/COPYRIGHT
/usr/share/doc/xinetd/README
/usr/share/doc/xinetd/empty.conf
/usr/share/doc/xinetd/sample.conf
/usr/share/man/man5/xinetd.conf.5.gz
/usr/share/man/man5/xinetd.log.5.gz
/usr/share/man/man8/xinetd.8.gz
```
##### 19. Identifica el fitxer de servei de xinetd i llista’l. Identifica l’executable del servei i a quin target s’instal·la.
```
[root@laptop-asus cmanalo]# rpm -ql xinetd | egrep ".service|bin"
/usr/lib/systemd/system/xinetd.service
/usr/sbin/xinetd

```

```
[root@laptop-asus cmanalo]# cat $(rpm -ql xinetd | egrep .service)
[Unit]
Description=Xinetd A Powerful Replacement For Inetd
After=syslog.target network.target
Documentation=man:xinetd
Documentation=man:xinetd.conf
Documentation=man:xinetd.log

[Service]
Type=forking
PIDFile=/var/run/xinetd.pid
ExecStart=/usr/sbin/xinetd -stayalive -pidfile /var/run/xinetd.pid
ExecReload=/usr/bin/kill -HUP $MAINPID

[Install]
WantedBy=multi-user.target
```
Se instala en multi-user.target

##### 20. Llista el directori on hi ha els fitxers de les units de servei de multi-user.target. Identifica el fitxer corresponent al servei xientd.
```
[root@laptop-asus cmanalo]# ls /etc/systemd/system/multi-user.target.wants/ | egrep xinetd
```
No sale nada porque no esta enable
##### 21. Fes enable del servei xinetd. S’ha creat un link. Llista el directori origen i el directori destí del link. On s’ha creat el link? Perquè?
```
[root@laptop-asus cmanalo]# systemctl enable xinetd
Created symlink /etc/systemd/system/multi-user.target.wants/xinetd.service → /usr/lib/systemd/system/xinetd.service.

[root@laptop-asus cmanalo]# ls /etc/systemd/system/multi-user.target.wants/ | egrep xinetd
xinetd.service
```
Se ha creado en /etc/systemd/system/multi-user.target.wants porque alli se encuentra los services en enable

##### 22. Llista les dependències de multi-user.target: totes; només els targets; només els serveis.
```
[root@laptop-asus cmanalo]# systemctl list-dependencies multi-user.target
multi-user.target
● ├─abrt-journal-core.service
● ├─abrt-oops.service
● ├─abrt-vmcore.service
● ├─abrt-xorg.service
● ├─abrtd.service
● ├─atd.service
● ├─auditd.service
● ├─avahi-daemon.service
● ├─chronyd.service
● ├─crond.service
● ├─cups.path
.
.
.
```

```
[root@laptop-asus cmanalo]# systemctl list-dependencies multi-user.target | grep .target
multi-user.target
● ├─basic.target
● │ ├─paths.target
● │ ├─slices.target
● │ ├─sockets.target
● │ ├─sysinit.target
● │ │ ├─cryptsetup.target
● │ │ ├─local-fs.target
● │ │ └─swap.target
● │ └─timers.target
● ├─getty.target
● ├─nfs-client.target
● │ └─remote-fs-pre.target
● └─remote-fs.target
●   └─nfs-client.target
●     └─remote-fs-pre.target
```

```
[root@laptop-asus cmanalo]# systemctl list-dependencies multi-user.target | grep .service
● ├─abrt-journal-core.service
● ├─abrt-oops.service
● ├─abrt-vmcore.service
● ├─abrt-xorg.service
● ├─abrtd.service
● ├─atd.service
● ├─auditd.service
● ├─avahi-daemon.service
● ├─chronyd.service
● ├─crond.service
● ├─cups.service
● ├─dbxtool.service
● ├─dkms.service
● ├─firewalld.service
● ├─flatpak-add-fedora-repos.service
● ├─gpm.service
.
.
.
```
##### 23. Llista les dependències de xinetd.service.
```
[root@laptop-asus cmanalo]# systemctl list-dependencies xinetd
xinetd.service
● ├─system.slice
● └─sysinit.target
●   ├─dev-hugepages.mount
●   ├─dev-mqueue.mount
●   ├─dmraid-activation.service
●   ├─dracut-shutdown.service
●   ├─import-state.service
●   ├─iscsi.service
●   ├─kmod-static-nodes.service
●   ├─ldconfig.service
●   ├─lvm2-lvmpolld.socket
●   ├─lvm2-monitor.service
●   ├─multipathd.service
.
.
.
```

##### 24. Fes l’ordre systemctl show del servei xinetd i identifica els elements: After i WantedBy.
```
[root@laptop-asus cmanalo]# systemctl show xinetd | egrep "^After|^WantedBy"
WantedBy=multi-user.target
After=systemd-journald.socket sysinit.target basic.target network.target syslog.target system.slice

```

##### 25. Es pot iniciar sessió en el sysinit.target? Explica el perquè documentant-ho.
No se puede
```
[root@laptop-asus cmanalo]# systemctl show sysinit.target | egrep AllowIsolate
AllowIsolate=no
```



### Arrencada de targets diferents

##### 26. Mostra les dependències de recue.target: totes; targets; serveis.
```
[root@laptop-asus cmanalo]# systemctl list-dependencies rescue.target
[root@laptop-asus cmanalo]# systemctl list-dependencies rescue.target
rescue.target
● ├─rescue.service
● ├─systemd-update-utmp-runlevel.service
● └─sysinit.target
●   ├─dev-hugepages.mount
●   ├─dev-mqueue.mount
●   ├─dmraid-activation.service
●   ├─dracut-shutdown.service
●   ├─import-state.service
●   ├─iscsi.service
●   ├─kmod-static-nodes.service
●   ├─ldconfig.service
.
.
.
```

```
[root@laptop-asus cmanalo]# systemctl list-dependencies rescue.target | grep .target
rescue.target
● └─sysinit.target
●   ├─cryptsetup.target
●   ├─local-fs.target
●   └─swap.target
```

```
[root@laptop-asus cmanalo]# systemctl list-dependencies rescue.target | grep .service
● ├─rescue.service
● ├─systemd-update-utmp-runlevel.service
●   ├─dmraid-activation.service
●   ├─dracut-shutdown.service
●   ├─import-state.service
●   ├─iscsi.service
●   ├─kmod-static-nodes.service
●   ├─ldconfig.service
●   ├─lvm2-monitor.service
●   ├─multipathd.service
.
.
.
```
##### 27. Mostra les dependències de emergency.target: totes; targets; serveis.
```
[root@laptop-asus cmanalo]# systemctl list-dependencies emergency.target 
emergency.target
● └─emergency.service
```

```
[root@laptop-asus cmanalo]# systemctl list-dependencies emergency.target | grep .target
emergency.target
```

```
[root@laptop-asus cmanalo]# systemctl list-dependencies emergency.target | grep .service
● └─emergency.service
```
##### 28. Estableix com a target per defecte reboot.target i reinicia la màquina.
```
[root@laptop-asus cmanalo]# systemctl set-default reboot.target
```
##### 29. Punyeta! Arregla-ho!
```
[root@laptop-asus cmanalo]# systemctl set-default graphical.target
```