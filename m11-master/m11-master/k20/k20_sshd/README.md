# K20 SSH Server

@edt ASIX M11-SAd Curs 2020 - 2021

### Autenticació


 * **chriswar/k20:sshd** Servidor SSH amb PAM amb autenticació AP de kerberos i IP de ldap. 
   El servidor kerberos al que contacta s'ha de dir *kserver.edt.org*. El servidor ldap 
   s'anomena *ldap.edt.org*. Aquest host es configura amb *authconfig*. Generat a partir de
   la imatge chriswar/k20:khost-pam-ldap que és un host amb PAM kerb5+ldap. Se li ha afegit:


####  Configurar al servidor

```
 *  el servei sshd (cal generar les claus de host)
 *  el keytab contenint el princpial host/sshd.edt.org@EDT.ORG
 *  la configuració sshd_config per permetre connexions kerberitzades
 *  la configuració ssh_config per pode fer test des del propi host (connexions kerberitzades) 
```

```
KerberosAuthentication yes
KerberosTicketCleanup yes
KerberosUseKuserok yes
GSSAPIAuthentication yes
GSSAPICleanupCredentials no
```

#### Configurar al client

  * No cal fer res d'especial en el client per configurar-lo. Evidentment ha de tenir els
    paquets openssh-clients i krb5-workstation (amb /etc/krb5.conf) ben configurat.

  * Simplement amb això en el client un usuari *pere* amb tiket ja pot accedir de manera
    desatesa al servdidor sshd kerveritzat. Però en la sessió remota (en el destí)
    no tindrà ticket.

  * Si es configura en el client les dues directives apropiades llavors en la sessió remota
    (en el destí) es propagarà el ticket i també el tindrà.

```
GSSAPIAuthentication yes
GSSAPIDelegateCredentials yes

```



#### Accés i desplegament

Accedir al kserver de AWS:

 * posar a /etc/hosts l'adreça IP del servidor

'''
A.B.C.D sshd.edt.org kserver.edt.org kserver ldap.edt.org ldap
'''

```
docker run --rm --name sshd.edt.org -h sshd.edt.org -p 2022:22 --net 2hisx -d chriswar/k20:sshd
```

