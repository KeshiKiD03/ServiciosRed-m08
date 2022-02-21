# PAM

## @edt ASIX M06 2020-2021

* **chriswar/pam20:ldap** host pam per practicar *PAM* amb autenticació local
  unix (*pam_unix.so*) i autenticació LDAP (amb *pam_ldap.so*). Utilitza el paquet
  *nss-pam-ldapd*. Cal configurar: *ldap.conf*, *nslcd*, *nscd*, *nsswitch*.
  L'autentitació es configura al *system-auth*.


  Atenció, cal usar en el container --privileged per poder fer els muntatges nfs.

```
$ docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -d chriswar/ldap20:latest 
$ docker run --rm --name pam.edt.org --hostname pam.edt.org --net 2hisx --privileged -it chriswar/pam20:ldap
```

