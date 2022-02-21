# K20 Kerberos Server

@edt ASIX M11-SAD Curs 2020 - 2021


### Autenticació


 * **chriswar/k20:khost** host client de kerberos. Simplement amb eines kinit, klist i kdestroy (no pam). El servidor al que contacta s'ha de dir *kserver.edt.org*.

```
docker run --rm --name khost.edt.org -h khost.edt.org --net 2hisx -it chriswar/k20:khost
```

