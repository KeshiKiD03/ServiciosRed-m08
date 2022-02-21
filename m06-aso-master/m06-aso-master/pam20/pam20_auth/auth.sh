#!/bin/bash 
authconfig --enableshadow --enablelocauthorize --enableldap --enableldapauth --ldapserver='ldap.edt.org' --ldapbase='dc=edt,dc=org' --enablemkhomedir --updateall

