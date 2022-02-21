#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# Separa els opcions i els arguments
#--------------------------------
ERR_NARGS=1
ERR_DD=2
ERR_RF=3
OK=0

# Comprova arguments
if ! [ $# -ge 1 ]
then
	echo "Error: #num d'arguments incorrectes"
	echo "Usage: $0 [-a -b -c -d -e -f] args[...]"
	exit $ERR_NARGS
fi

llista=$*
opcions=''
args=''

for arg in $llista
do	
	case $arg in
		-[a-f])
			opcions="$opcions $arg";;
		*)
			args="$args $arg";;
	esac 
	
done

echo "Opcions: $opcions"
echo "Arguments: $args"
exit $OK
