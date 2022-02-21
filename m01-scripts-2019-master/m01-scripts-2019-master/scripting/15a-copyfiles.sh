#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# Copia un element donat a un dir desti
#--------------------------------
ERR_NARGS=1
ERR_RFO=2
ERR_DD=3
OK=0

# Comprova arguments
if ! [ $# -eq 2 ]
then
	echo "Error: #num d'arguments incorrectes"
	echo "Usage: $0 regular_file dirdesti"
	exit $ERR_NARGS
fi

# Comprova si arg1 es regular file
origen=$1
if ! [ -f $origen ]; then
    echo "Error: $origen no es un regular file"
    echo "Usage: $0 regular_file dirdesti"
    exit $ERR_RFO
fi

# Comprova si arg2 es un directori
dirdesti=$2
if ! [ -d $dirdesti ]; then
    echo "Error: $dirdesti no es un directori"
    echo "Usage: $0 regular_file dirdesti"
    exit $ERR_DD
fi

# Fem un copy
cp $origen $dirdesti
echo "Succesfully Copied :3 ^-^"
exit $OK
