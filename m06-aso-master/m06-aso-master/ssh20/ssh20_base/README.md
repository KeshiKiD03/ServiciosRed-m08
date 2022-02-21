# PAM

## @edt ASIX M06 2020-2021


ASIX M06-ASO Escola del treball de barcelona

### Imatges:

**chriswar/ssh20:base** Host base amb el servei SSH engegat. El host està configurat 
  amb PAM per permetre usuaris locals (unix01, etc) i usuaris de LDAP (pere,...). Cal
  engegar el container conjuntament amb el servei LDAP.

```
$ docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -d chriswar/ldap20:latest 
$ docker run --rm --name ssh.edt.org  -h ssh.edt.org  --net 2hisx -p 2022:22 -d chriswar/ssh20:base
```

Es pot engegar amb docker-compose:
```
$ docker-compose up -d
$ docker compose down
```
