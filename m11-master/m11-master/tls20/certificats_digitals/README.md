# M06-ASO LDAP SERVER BASE
## Escola Del Treball
### 2HISX 2020-2021
### Christian Manalo Mañibo

Servidor ldapserver amb base de dades d'usuaris per UID i amb grups posix ben configurats.

**Detach**

`$ docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -d chriswar/ldap20:group`

**Interactiu**

`$ docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -it chriswar/ldap20:group /bin/bash`
