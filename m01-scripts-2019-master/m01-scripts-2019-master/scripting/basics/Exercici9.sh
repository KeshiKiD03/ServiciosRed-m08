#!/bin/bash
# Christian Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 9. Fer un programa que rep per stdin noms d̉usuari (un per línia), si existeixen en el sistema (en el fitxer /etc/passwd) mostra el nom per stdout. Si no existeix el mostra per stderr.i
#--------------------------------------------------------
OK=0
while read -r user
do
	buscar=$( egrep "^$user:" /etc/passwd | wc -l)
	if [ $buscar -eq 1 ]; then
		echo "$user"
	else
		echo "Error: $user no existeix" >> /dev/stderr
	fi
done
exit $OK

