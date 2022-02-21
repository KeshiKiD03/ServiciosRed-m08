#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# Ens diu si es directori o no
#-------------------------------
# Validar argument
if [ $# -ne 1 ]; then
	echo "Error: #num args incorrectes"
	echo "Usage: $0 directori"
	exit 1
fi

# Validar directori
if ! [ -d $1 ]; then
	echo "Error: $1 no es directori"
	echo "Usage: $0 directori"
	exit 2

fi
# Mostrar directori
dir=$1
ls $dir





