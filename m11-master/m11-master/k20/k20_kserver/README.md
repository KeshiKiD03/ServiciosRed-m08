# K20 Kerberos Server

@edt ASIX M11-SAD Curs 2020 - 2021


### Autenticació

**chriswar/k20:server**: servidor kerberos detach. 
   Crea els usuaris pere, pere/admin, pau, pau/admin, jordi, anna, 
   marta (admin)  i julia. Assignar-li el nom 
   de host: *kserver.edt.org*


'''
docker run --rm --name kserver.edt.org -h kserver.edt.org --net 2hisx -p 88:88 -p 464:464 -p 749:749 -d chriswar/k20:kserver
'''
