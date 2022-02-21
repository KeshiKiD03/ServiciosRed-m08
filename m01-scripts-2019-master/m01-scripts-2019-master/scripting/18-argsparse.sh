#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# Separa els opcions i els arguments, file i edat
#--------------------------------
ERR_NARGS=1
ERR_DD=2
ERR_RF=3
OK=0

# Comprova arguments
if ! [ $# -ge 1 ]
then
	echo "Error: #num d'arguments incorrectes"
	echo "Usage: $0 [-a -b -c -d -e ] args[...]"
	exit $ERR_NARGS
fi

llista=$*
opcions=''
args=''
file=''
edat=''

while [ -n $1 ]
do 
	case $1 in 
		"-a")
			opcions="$opcions $1"
			shift
			file="$file $1";;
		"-d")
			opcions="$opcions $1"
			shift
			edat="$edat $1";;
		"-b"|"-c"|"-e")
			opcions="$opcions $1";;
		*)
			args="$args $1"
	shift
	esac
done

echo "File: $file"
echo "Edat: $edat"
echo "Opcions: $opcions"
echo "Arguments: $args"
exit $OK
