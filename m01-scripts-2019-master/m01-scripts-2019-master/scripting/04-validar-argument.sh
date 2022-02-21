#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# valida argument que te exactament 2 args i mostrar-los
#-------------------------------
# Si num args no es correcte plegar
if [ $# -ne 2 ]; then
	echo "Error: #num args incorrectes"
	echo "Usage: prog 2 arguments"
	exit 1
fi

# xixa
echo "Els dos arguments son: $1 $2"
exit 0
