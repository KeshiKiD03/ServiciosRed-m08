# PAM

## @edt ASIX M06 2020-2021


* **chriswar/pam20:auth**host pam que configura l'autenticació unix i ldap usant *authconfig*.
  Es crea automàticament el directori home dels usuaris de ldap (filtrat per uid) i es munta un recurs tmpfs de 100MB.

  Atenció: fabricat usant Fedora-27 en lloc de Fedora-32 per usar *authconfig* en lloc de *authselect* 

  Atenció: cal usar en el container --privileged per poder fer els muntatges.

```
$ docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -d chriswar/ldap20:latest 
$ docker run --rm --name pam.edt.org --hostname pam.edt.org --net 2hisx --privileged -it chriswar/pam20:auth
```

