#!/bin/bash
# Christian Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 7. Processar línia a línia l'entrada estàndard, si la línia té més de 60 caràcters la mostra, si no no.
# ----------------------------------------------------------

while read -r line
do
	caracter=$(echo -n $line | wc -c)	
	if [ $caracter -gt 60 ]; then
		echo "$line"
	fi
done
	
