# Server Ldap 2020-2021

### ASIX M06-ASO
#### Christian Manalo Mañibo - isx9565961
- ldap20:base Imatge base de un servidor ldap que funciona amb detach carrega edt.org, els elements bàsics i els usuaris bàsics.

- ldap20:editat Server ldap tipus mdb, password manager xifrat, tot els usuaris a un sol fitxer ldif a la base de dades.

- ldap20:m06 Server ldap tipus mdb, password manager xifrat que funciona amb detach, carrega m06.cat, elements basics i usuaris basics.

- ldap20:acl Imatge ldap20:editat servidor base amb fitxers d'exemple per inserir dinàmicament acls diferents i practicar-les.

- ldap20:schema Afegim a la BD edt,org nous objectClass i atributs definits per nosaltres en un schema inventat: futbolistes.schema

Per cada schema s'han definit dades a inserir en la base de dades. S'han fet tres exemples de esquemes de 'fulbolistes':

    A) objecte structural derivat de inetOrgPerson
    B) objecte structural derivat de TOP
    C) objecte auxiliar (implementat acompanyant els usuaris actuals inetOrgPerson i posixAccount)

- phpldapadmin:20 Imatge amb un servidor phpldapadmin. Connecta a al servidor ldap
anomenat ldap.edt.org per accedir a les bases de dades dc=edt,dc=org i cn=config. Aquesta imatge
està basada en fedora:27 per evitar el canvi de sintaxis de PHP 7.4

- ldap20:group Servidor ldapserver amb base de dades d'usuaris per UID i amb grups posix ben configurats.

- ldap20:practica Afegim un nou objectClass i atributs definits per un schema inventat: master.schema
