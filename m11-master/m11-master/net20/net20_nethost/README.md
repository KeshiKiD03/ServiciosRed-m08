# SSHD Kerberitzat
## @edt ASIX M11-SAD Curs 2020-2021

**edtasixm11/net20:nethost** Servidor de serveis de xarxa, usant xinetd, redireccions, httpd, 
  vsftp, ftpd, etc. S'utilitza per fer tests de connectivitat, xinetd, tcpwrappers, túnels ssh i iptables.

 * serveis xinetd: echo(7), daytime(13) i chargen(19) stream (tcp).
 * serveis xinetd: echo(7), daytime(13) i chargen(19) dgram (udp).
 * serveis del paquet uw-imap: ipop3(110), imap(143), pop3s (995), imaps (993).
 * servei web httpd(80).
 * serveis xinetd redireccions: 2007 (7), 2013 (13) i 2080 (80). També 3080 (www.gmail.com 80)
 * serveis xinetd redireccions bnd al loopback: 4007 (7), 4013 (13), 4080 (80).
 * servei vsftpd(20,21).
 * servei sshd(22).
 * servei tftp (69).
 
Test
```
# telnet a.b.c.d port
# netstat -tan
# netstat -uan
# nmap localhost
# nmap a.b.c.d
```

Execució:

Sense mapejar els ports
```
docker netweork create mynet
docker run --rm --name nethost.edt.org -h nethost.edt.org --net 2hisx -d chriswar/net20:nethost
```

Amb ports mapejats
```
docker netweork create 2hisx
docker run --rm --name nethost.edt.org -h nethost.edt.org --net 2hisx -p 7:7 -p 13:13 -p 80:80 -d chriswar/net20:nethost
```





