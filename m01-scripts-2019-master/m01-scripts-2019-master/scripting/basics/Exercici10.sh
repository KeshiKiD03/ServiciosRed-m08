#!/bin/bash
# Christian Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 10. Fer un programa que rep com a argument un número indicatiu del número màxim de línies a mostrar. El programa processa stdin línia a línia i mostra numerades un màxim de num línies.
#--------------------------------------------------------
OK=0

num=$1
contador=1
while [ $contador -le $num ]
do
	read -r line
	echo "$contador: $line"
	contador=$((contador+1))
done
exit $OK

