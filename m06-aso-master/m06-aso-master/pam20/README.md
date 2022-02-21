# PAM

## @edt ASIX M06 2020-2021

### Imatges:

* **chriswar/pam20:base** host pam per practicar *PAM* amb chfn i system-auth. Es tracten els types
  auth i session amb chfn practicant el significat de optional, sufficient, required i requisite i el 
  mòdul pam_unix.so. El type password amb pwquality. El type account amb pam_time.so. 
  El type sessions amb pam_mkhomedir.so i pam_mount.so. Es practica pam_mount.so amb un muntatge tmpfs
  i un de nfs4.

  Atenció, cal usar en el container --privileged per poder fer els muntatges nfs.

  ```$ docker run --rm --name pam.edt.org --hostname pam.edt.org --net 2hisx --privileged -it chriswar/pam20:base```


* **chriswar/pam20:ldap** host pam per practicar *PAM* amb autenticació local
  unix (*pam_unix.so*) i autenticació LDAP (amb *pam_ldap.so*). Utilitza el paquet
  *nss-pam-ldapd*. Cal configurar: *ldap.conf*, *nslcd*, *nscd*, *nsswitch*.
  L'autentitació es configura al *system-auth*.


  Atenció, cal usar en el container --privileged per poder fer els muntatges nfs.

```
$ docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -d chriswar/ldap20:latest 
$ docker run --rm --name pam.edt.org --hostname pam.edt.org --net 2hisx --privileged -it chriswar/pam20:ldap
```

