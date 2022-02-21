# M06-ASO LDAP SERVER BASE
## Escola Del Treball
### 2HISX 2020-2021
### Christian Manalo Mañibo

* **chriswar/ldap20:entrypoint** Imatge amb varies opcions d'arrencada segons el valor que passem: start, initdb, initdbedt. Utilitzem volumes per tenir *permanencia* de dades.  
  * initdbedt crea tota la base de dades edt (esborra tot el que hi havia prèviament). Hi posa la xixa.

  * initdb esborra tot el que hi havia i crea la base de dades sense xixa.

  * start engega el servidor

Detach:

```
docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -v ldap-config:/etc/openldap/slapd.d -v ldap-data:/var/lib/ldap -d chriswar/ldap20:entrypoint initdb
```
  
