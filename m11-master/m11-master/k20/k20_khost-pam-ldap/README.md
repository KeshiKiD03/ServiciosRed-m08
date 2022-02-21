# K20 Kerveros host client

@edt ASIX M11-SAd Curs 2020 - 2021

### Autenticació


 * **chriswar/k20:khost-pam-ldap** host client de kerberos i ldap.
   Autentica usuaris contra aquests dos serveis. Connecta al servidor 
   kerberos *kserver.edt.org* i al servdior ldap *ldap.edt.org*.
   *nota* fet amb fedora27 per poder usar authconfig.
   
```
docker run --rm --name khost-pam-ldap.edt.org -h khost-pam-ldap.edt.org --net 2hisx -it chriswar/k20:khost-pam-ldap
```
