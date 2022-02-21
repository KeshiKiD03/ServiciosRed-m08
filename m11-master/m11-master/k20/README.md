### Authenticació

 * **chriswar/k20:kserver** servidor kerberos detach. 
   Crea els usuaris pere, pere/admin, pau, pau/admin, jordi, anna, 
   marta (admin)  i julia. Assignar-li el nom 
   de host: *kserver.edt.org*

 * **chriswar/k20:khost-pam** host client de kerberos.
   Simplement amb eines kinit, klist i kdestroy (no pam).
   El servidor al que contacta s'ha de dir *kserver.edt.org*.

 * **chriswar/k20:khost-pam-ldap** host client de kerberos i ldap.
   Autentica usuaris contra aquests dos serveis. Connecta al servidor 
   kerberos *kserver.edt.org* i al servdior ldap *ldap.edt.org*.
   *nota* fet amb fedora27 per poder usar authconfig.

### Servei SSH Kerberitzat

  * **chriswar/k20:sshd** Servidor SSHD *kerberitzat*. Servidor ssh que permet
    l'accés d'usuaris locals i usuaris de xarxa. El servidor s'ha de dir *sshd.edt.org*.
    Implementa sshd-pam-kerberos-ldap. Servidor SSH amb PAM amb autenticació 
    AP de  kerberos i IP de ldap.   El servidor kerberos al que contacta s'ha de dir
    *kserver.edt.org*. El servidor ldap   s'anomena *ldap.edt.org*. Aquest host es configura
    amb authconfig. S'ha generat partint del host *edtasixm11/k20:khost-pam-ldap* i se li 
    ha afegit la part del servidor sshd.


```
docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389  -d chriswar/ldap20:latest
docker run --rm --name kserver.edt.org -h kserver.edt.org -p 749:749 -p 88:88 -p 464:464 --net 2hisx -d chriswar/k20:kserver
docker run --rm --name sshd.edt.org -h sshd.edt.org -p 2022:22 --net 2hisx -d chriswar/k20:sshd
docker run --rm --name khost.edt.org -h khost.edt.org --net 2hisx -it chriswar/k20:khost-pam-ldap
```

## Teoria

### Authenticació 

**Autenticaction Provider AP**

Kerberos propoerciona el servei de proveïdor d'autenticació. No emmagatzema informació dels comptes d'usuari com
el uid, git, shell, etc. Simplement emmagatzema i gestiona els passwords dels usuaris, en entrades anomenades 
*principals* en la seva base de dades.

Coneixem els següents AP:

 * */etc/passwd* que conté els password (AP) i també la informació dels comptes d'usuari (IP).
 * *ldap* el servei de directori ldap conté informació dels comptes d'usuari (IP) i també els seus passwords (AP).
 * *kerberos* que únicament actua de AP i no de IP.

**Information Provider IP**

Els serveis que emmagatzemen la informació dels comptes d'usuari s'anomenen Information providers. Aquests
serveis proporcionen el uid, gid, shell, gecos, etc. Els clàssics són /etc/passwd i ldap.


### Model de pràctiques

El model que mantindrem a tot el mòsul ASIX M11-SAD és el següent:

 * **ldap** al servidor ldap tenim els usuaris habituals pere, marta, anna, julia, pau, jordi i 
   els usuaris user01..user10. El seu   password és el seu propi nom.

 * **/etc/passwd** en els containers hi ha els usuaris locals local01, local02 i local03 que tenen assignat 
  com a passeord el seu mateix nom.

 * **kerberos + IP** els usuaris kuser01, kuser02 i kuser03 són principals de kerberos amb passwords tipus kuser01,
  kuser02 i kuser03. La informació del seu compte d'usuari és local al */etc/passwd* on **no** tenen password
  assignat.

 * **kerberos + ldap** Al servidor kerberos hi ha també principals per als usuaris usuals ldap pere, marta, 
   anna, julia, jordi, pau i user01..user10. Els seus passwords són del tipus kpere, kmarta, kanna, kjulia, 
   kjordi, kpau i kuser01..kuser10. Kerberos actua de IP, i ldap actua de AP. Així doncs, és al ldap on hi
  ha la informació del compte d'aquests usuaris (uid, gid, etc).

Es resum, podem verificar l'accés/autenticació d'usuaris locals usant el prototipus *local01*, podem fer test de la
connectivitat kerberos amb comptes locals amb usuaris tipus *kuser01*.  I finalment podem verificar l'autenticació
d'usuaris kerberos (AP9 amb LDAP (AP)  amb els clàssics pere (kpere).


#### Desplegament:

  * **Local**:  desplegar al host de l'aula localment els tres containers, servidor kerberos, ldap i client khost.
    Verificar que el khost pot llistar la base de dades LDAP, pot obtenir tikets kerberos, autenticar com un 
    usuari administrador kerberos amb kadmin i iniciar sessions d'usuaris locals (local01) i usuaris LDAP+kerberos 
    com per exemple pere/kpere.

  * **Remot-container-khost**: desplegar a un entorn cloud (per exemple AWS EC2) els dos servidors LDAP i Kerberos, 
    configurar l'accés remot als seus ports (security groups) i desplegar localment el client khost verificat els
    mateixos passos que l'apartat anterior.

  * **Remot-host-real**: desplegar a un entorn cloud (per exemple AWS EC2) els dos servidors LDAP i Kerberos, 
    configurar l'accés remot als seus ports (security groups) i  configurar un *host real  de l'aula* per
    fer autenticació d'usuari contra els serveis al cloud. Verificar els mateixos passos que l'apartat anterior.


## Versions de Fedora

### Fedora 27

Amb Fedora 27 podem configurar fàclment l'autenticació amb *autgconfig* establint les opcions d'autenticació següents:
```
authconfig  --enableshadow --enablelocauthorize --enableldap \
            --ldapserver='ldap.edt.org' --ldapbase='dc=edt,dc=org' \
            --enablekrb5 --krb5kdc='kserver.edt.org' \
            --krb5adminserver='kserver.edt.org' --krb5realm='EDT.ORG' \
            --enablemkhomedir --updateall
```

### Fedora 32

Amb Fedora 32 no podem utilitzar authconfig de manera que cal treballar amb authselect o configurar a mà els fitxers
implicats en el procediment d'autenticació. En un container és més entretingut. En la màquina real podem practicar
a configurar la capa superior usant SSSD.



