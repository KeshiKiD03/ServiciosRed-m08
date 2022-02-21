# Server Ldap 2020-2021

### ASIX M06-ASO
#### Christian Manalo Mañibo - isx9565961

Imatge:

* **chriswar/phpldapadmin:20** Imatge amb un servidor phpldapadmin. Connecta a al servidor ldap
  anomenat *ldap.edt.org* per accedir a les bases de dades *dc=edt,dc=org* i *cn=config*. Aquesta imatge
  està basada en fedora:27 per evitar el canvi de sintaxis de PHP 7.4.


Detach:
```
$ docker run --rm  --name phpldapadmin.edt.org -h phpldapadmin.edt.org --net 2hisx -p 80:80 -d chriswar/phpldapadmin:20 
```


