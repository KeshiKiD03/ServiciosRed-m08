#!/bin/bash
# Christian Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 8. Fer un programa que rep com a argument noms d̉usuari, si existeixen en el sistema (en el fitxer /etc/passwd) mostra el nom per stdout. Si no existeix el mostra per stderr.i 
#--------------------------------------------------------
OK=0
usuari=$*
for user in $usuari
do
	buscar=$( egrep "^$user:" /etc/passwd | wc -l)
	if [ $buscar -eq 1 ]; then
		echo "$user"
	else
		echo "Error: $user no existeix" >> /dev/stderr
	fi
done
exit $OK

