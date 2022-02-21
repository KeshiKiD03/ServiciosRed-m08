#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# Iterar nota a nota i dir si es suspes, aprovat, notable, o excelent
# prog nota [...]
#--------------------------------
ERR_NARGS=1
ERR_ARGVL=2
OK=0

# Validar argument
if [ $# -eq 0 ]; then
	echo "Error: #num args incorrects [1-n]"
	echo "Usage: $0 nota"
	exit $ERR_NARGS
fi


# Iterar argument a argument
arg=$*
for nota in $arg
do
	
	
	if ! [ $nota -ge 0 -a $nota -le 10 ]; then
		echo "Error: nota $nota invalida [0-10]" >> /dev/stderr
		echo "Usage: $0 nota" >> /dev/stderr

	elif [ $nota -le 4 ]; then
		msg="Suspés"

	elif [ $nota -le 6 ]; then
	        msg="Aprovat"

	elif [ $nota -le 8 ]; then
	        msg="Notable"

	else
	        msg="Excel·lent"

	fi
	
	echo "$msg" 

done
exit $OK



