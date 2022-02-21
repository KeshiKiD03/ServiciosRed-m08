# M06-ASO LDAP SERVER BASE
## Escola Del Treball
### 2HISX 2020-2021
### Christian Manalo Mañibo

- Servidor bàsic ldap, amb organització dc=edt,dc=org, usuaris bàsics pere, marta, anna... Configuració client ldap.conf: ldap.edt.org / dc=edt,dc=org

**Detach**

`$ docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -d chriswar/ldap20:base`

**Interactiu**

`$ docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -it chriswar/ldap20:base /bin/bash`

