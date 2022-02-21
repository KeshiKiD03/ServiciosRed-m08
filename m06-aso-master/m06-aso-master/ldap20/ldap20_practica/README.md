# M06-ASO LDAP SERVER BASE
## Escola Del Treball
### 2HISX 2020-2021
### Christian Manalo Mañibo

**chriswar/ldap20:practica** Afegim un nou objectClass i atributs definits per un schema inventat: master.schema

#### attributeTypes

Exemples d'atributs que té un master:

 * *EstudiatMaster* Atribut que indica si l'alumne ha fet el master, un boolean.

 * *NomMaster* Descripcio del master del alumne. Atribut tipus text amb una longitud limitada de 50.

 * *Nota* Atribut numeric on s'indica la nota final del alumne. 

 * *Web*  atribut amb una URL de la seva pàgina web. 
   Pot ser multi-valued perquè pot tenir més d’una pàgina web.

 * *Photo*  Atribut amb una foto JPG del alumne. Pot ser multi-value.

 * *Documents* Atribut binari per contenir documents del alumne. 
```
attributetype ( 1.1.2.1.1 NAME 'x-EstudiatMaster'
        DESC 'true/false Master'
        SYNTAX 1.3.6.1.4.1.1466.115.121.1.7
        SINGLE-VALUE)

attributetype ( 1.1.2.1.2 NAME 'x-NomMaster'
	DESC 'Nom del Master'
	EQUALITY caseIgnoreMatch
	SUBSTR caseIgnoreSubstringsMatch
	SYNTAX 1.3.6.1.4.1.1466.115.121.1.15{50}
	SINGLE-VALUE )

attributetype ( 1.1.2.1.3 NAME 'x-Nota'
	DESC 'Nota Final del Alumne'
	EQUALITY integerMatch
	ORDERING integerOrderingMatch
	SYNTAX 1.3.6.1.4.1.1466.115.121.1.27
	SINGLE-VALUE )

attributetype ( 1.1.2.1.4 NAME 'x-Web'
        DESC 'Pagina(s) web del Alumne'
	SYNTAX 1.3.6.1.4.1.1466.115.121.1.26
        )

attributetype ( 1.1.2.1.5 NAME 'x-Photo'
        DESC 'Fotografia del Alumne'
        SYNTAX 1.3.6.1.4.1.1466.115.121.1.28
        )

attributetype ( 1.1.2.1.6 NAME 'x-Documents'
        DESC 'Resguard del Master'
        SYNTAX 1.3.6.1.4.1.1466.115.121.1.5
        )
```

**Detach**
```
$ docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -d chriswar/ldap20:practica
```

**Interactiu per implementar el nou objectClass amb ldapmodify**
```
$ docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -it chriswar/ldap20:practica /bin/bash
```

**Afegir dades x-Master a usuaris existents**
```
$ ldapmodify -x -D 'cn=Manager,dc=edt,dc=org' -w secret -f mod-master-edt.org.ldif
```

**Afegir nous usuaris amb x-Master**
```
$ ldapmodify -x -D 'cn=Manager,dc=edt,dc=org' -w secret -f add-usuaris-master.ldif
```


