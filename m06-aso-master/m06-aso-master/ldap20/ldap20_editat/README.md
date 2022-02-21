# M06-ASO LDAP SERVER BASE
## Escola Del Treball
### 2HISX 2020-2021
### Christian Manalo Mañibo

- Tipus mdb, passwd xifrat secret i un unic fitxer ldif

**Detach**

`$ docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -d chriswar/ldap20:editat`

**Interactiu**

`$ docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -it chriswar/ldap20:editat /bin/bash`