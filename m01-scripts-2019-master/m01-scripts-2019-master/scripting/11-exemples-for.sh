#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# Exemples bucles for
#--------------------------------
OK=0

# iterar per la llista d'arguments
num=1
for arg in $*
do
	echo "$num: $arg"
	num=$((num+1))
done
exit $OK



# iterar per la llista d'arguments
for arg in "$@"
do
	        echo $arg
	done
	exit $OK

# iterar per la llista d'arguments
for arg in $*
do
	echo $arg
done
exit $OK

# iterar per un contingut d'una variable
llistat=$(ls)
for nom in $llistat
do
	echo $nom
done
exit $OK



# Iterar per el contingunt d'una cadena
# nomes itera un cop, perque nomes te un contingut
for nom in "pere pau marta anna"
do
	echo $nom
done
exit $OK



# iterar per un conjunt d'elements
for nom in "pere" "anna" "pau" "marta"
do
	echo $nom
done
exit $OK

