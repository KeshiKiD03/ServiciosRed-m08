#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# Ens diu si te 28, 30 o 31 dias
#-------i------------------------
ERR_NARGS=1
ERR_ARGVL=2
OK=0

# Validar argument
if [ $# -ne 1 ]; then
	echo "Error: #num args incorrects"
	echo "Usage: $0 mes"
	exit $ERR_NARGS
fi

# Help
if [ "$1" = "-h" -o "$1" = "--help" ]; then
	echo "@edt Christian Manalo"
	echo "$0 mes [1-12]"
	exit $OK
fi

# Validar mes
if [ $1 -lt 1 -o $1 -gt 12 ]; then
	echo "Error: Mes no valid [1-12]"
	echo "Usage: $0 mes"
	exit $ERR_ARGVL
fi

mes=$1
case $mes in
	"2")
		echo "28 dias";;
	"4"|"6"|"9"|"11")
		echo "30 dias";;
	*)
		echo "31 dias";;

esac
exit $OK




