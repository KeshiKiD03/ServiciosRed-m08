#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# Copia file[...] donat a un dir desti
#--------------------------------
ERR_NARGS=1
ERR_DD=2
ERR_RF=3
OK=0

# Comprova arguments
if ! [ $# -ge 2 ]
then
	echo "Error: #num d'arguments incorrectes"
	echo "Usage: $0 regular_file[...] dirdesti"
	exit $ERR_NARGS
fi

# Comprova si es un directori
dirdesti=$( echo $* | sed 's/^.* //g')
llistafile=$( echo $* | sed 's/ [^ ]*$//g')
if ! [ -d $dirdesti ]; then
	echo "Error: $dirdesti no es un directori"
	echo "Usage: $0 regular_file dirdesti"
	exit $ERR_DD
fi

# Itera els arguments file 
for file in $llistafile
do 
	if ! [ -f $file ]; then
    		echo "Error: $origen no es un regular file" >> /dev/stderr
    		echo "Usage: $0 regular_file dirdesti" >> /dev/stderr
    		exit $ERR_RFO
	fi 
	cp $file $dirdesti
done
