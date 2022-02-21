#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# Ens diu si tenim suspes, aprovat, notable o excelent
#-------------------------------
# Validar argument
if [ $# -ne 1 ]; then
	echo "Error: #num args incorrectes"
	echo "Usage: $0 nota"
	exit 1
fi

# Validar nota 
if [ $1 -lt 0 -o $1 -gt 10 ]; then
	echo "Error: #nota $1 no valida [0-10]"
	echo "Usage: $0 nota"
	exit 2
fi
# Xixa
nota=$1
if [ $nota -lt 5 ]; then
	msg="Suspés"

elif [ $nota -eq 5 -o $nota -eq 6 ]
then
	msg="Aprovat"

elif [ $nota -eq 7  -o $nota -eq 8 ]
then
	msg="Notable"

else
	msg="Excel·lent"

fi
echo $msg
exit 0


