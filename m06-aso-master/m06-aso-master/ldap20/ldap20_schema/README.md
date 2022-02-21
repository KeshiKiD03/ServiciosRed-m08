# M06-ASO LDAP SERVER BASE
## Escola Del Treball
### 2HISX 2020-2021
### Christian Manalo Mañibo
Imatge:

* **chriswar/ldap20:schema** Afegim a la BD edt,org nous objectClass i 
  atributs definits per nosaltres en un schema inventat: futbolistes.schema

  Per cada schema s'han definit dades a inserir en la base de dades. 
  S'han fet tres exemples de esquemes de 'fulboliestes':

  *  A) objecte structural derivat de inetOrgPerson
  *  B) objecte structural derivat de TOP
  *  C) objecte auxiliar (implementat acompanyant els usuaris actuals inetOrgPerson 
     i posixAccount)


#### attributeTypes

Exemples d'atributs que té un futbolista:

 * *equip* atribut de text que conté el nom de l’equip al que pertany. 
   Ha de ser un nom únic (potser en Figo opina diferent…)

 * *dorsal*  atribut numèric amb el valor del dorsal que utilitza. 
   Ha de ser un valor únic.

 * *webpage*  atribut amb una URL de la seva pàgina web personal de merchandising. 
   Pot ser multi-valued perquè pot tenir més d’una pàgina web.

 * *photo*  attribut amb una foto JPEG del futbolista. Pot ser multi-value.

 * *lesionat*  atribut que indica l’estat de lesionat o no del futbolista, un boolean.

```
attributetype ( 1.1.2.1.1 NAME 'x-equip'
    DESC 'nom del equip'
    EQUALITY caseIgnoreMatch
    SUBSTR caseIgnoreSubstringsMatch
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.15
    SINGLE-VALUE )


attributetype ( 1.1.2.1.2 NAME 'x-dorsal'
    DESC 'dorsal del jugador'
    EQUALITY integerMatch
    ORDERING integerOrderingMatch
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.27
    SINGLE-VALUE )

attributetype ( 1.1.2.1.3 NAME 'x-web'
    DESC 'pagina(s) web del jugador'
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.26
    )

attributetype ( 1.1.2.1.4 NAME 'x-photo'
    DESC 'fotografia dle jugador'
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.28
    )

attributetype ( 1.1.2.1.5 NAME 'x-lesionat'
    DESC 'true/false lesionat'
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.7
    SINGLE-VALUE
    )
```

#### objectClass

Tres exemples de objectClass de *futbolista* diferents:

 * **A) Estructural derivat de inetOrgPerson**

   Crear un objectClass Futbolista que sigui estructural i derivat de inetOrgPerson. 
   Això implica que a més a més dels atributs que tindrà com a futbolista hereterà els
    de inetOrgPerson (on cn i sn són obligatoris).

```
objectclass ( 1.1.2.2.1 NAME 'x-Futbolista'
    DESC 'Futboleros crazys'
    SUP inetOrgPerson
    STRUCTURAL
    MUST x-equip
    MAY (x-dorsal $ x-web $ x-photo $ x-lesionat)
    )
```


 * **B) Estructural derivat de TOP**

    Crear un objectClass Futbolista que sigui estructural i derivat de TOP, és a dir, de ningú.
    Ara ja no herata cap atribut de inetOrgPerson de manera que les entitats no poden tenir els
    atributs cn, sn etc que tenien en l’exemple anterior. 

    Apareix el problema del dn. Com s’identifica un futbolista si no hi ha cn? 
    Això exigeix modificar l’schema i afegir un nou atribut amb el nom del futbolista, que es únic i actúa de RDN.

```
attributetype ( 1.1.2.1.6 NAME 'x-lonom'
    DESC 'lo nom de lo jugador'
    EQUALITY caseIgnoreMatch
    SUBSTR caseIgnoreSubstringsMatch
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.15
    SINGLE-VALUE )
```

```
objectclass ( 1.1.2.2.1 NAME 'x-Futbolista'
    DESC 'Futboleros crazys'
    SUP TOP
    STRUCTURAL
    MUST ( x-lonom $ x-equip )
    MAY (x-dorsal $ x-web $ x-photo $ x-lesionat)
    )
```



 * **C) Auxiliary derivat de TOP**

   Es crearà un objectClass auxiliary. Es pot decidir si es fa derivat de TOP o de inetOrgPerson
   o d’un altre objectClass, però en aquest exemple es farà derivat de TOP. 
   
   En ser auxiliary caldrà que una entitat (per exemple usuari)  tingui a un altre objecte
   structural (per exemple inietOrgPerson). Així per exemple els futbolistes en realitat seran
    entitats inetOrgPerson i x-Futbolista (els dos objectClass).

```
objectclass ( 1.1.2.2.1 NAME 'x-Futbolista'
    DESC 'Futboleros crazys'
    SUP TOP
    AUXILIARY
    MUST x-equip
    MAY ( x-lonom $ x-dorsal $ x-web $ x-photo $ x-lesionat )
    )
```


Funcionament en detach:
```
docker run --rm --name ldap.edt.org -h ldap.edt.org --net 2hisx -p 389:389 -d chriswar/ldap20:schema
```
