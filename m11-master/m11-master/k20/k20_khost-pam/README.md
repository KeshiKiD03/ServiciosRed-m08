# K20 Kerveros host client

@edt ASIX M11-SAd Curs 2020 - 2021

### Autenticació


 * **chriswar/k20:khost-pam** host client de kerberos. Simplement amb eines kinit, klist i kdestroy . El servidor al que contacta s'ha de dir *kserver.edt.org*.


Accedir al kserver de AWS:

 * posar a /etc/hosts l'adreça IP del servidor

'''
A.B.C.D kserver.edt.org kserver
'''

```
docker run --rm --name khost-pam.edt.org -h khost-pam.edt.org --net 2hisx -it chriswar/k20:khost-pam
```

