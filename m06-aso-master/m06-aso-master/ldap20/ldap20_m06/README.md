# M06-ASO LDAP SERVER BASE
## Escola Del Treball
### 2HISX 2020-2021
### Christian Manalo Mañibo

- ldap20:m06 Servidor Ldap Basic que funciona amb detach, carrega m06.cat, elements basics i usuaris basics.

**Detach**

`$ docker run --rm --name ldap.m06.cat -h ldap.m06.cat --net 2hisx -p 389:389 -d chriswar/ldap20:m06`

**Interactiu**

`$ docker run --rm --name ldap.m06.cat -h ldap.m06.cat --net 2hisx -p 389:389 -it chriswar/ldap20:m06 /bin/bash`