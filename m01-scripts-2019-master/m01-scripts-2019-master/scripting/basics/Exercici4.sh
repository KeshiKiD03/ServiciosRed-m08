#!/bin/bash
# Christian Manalo Mañibo
# Febrer 2020
# ASIX-M01
# 4. Fer un programa que rep com a arguments números de més (un o més) i indica per a cada mes rebut quants dies té el més.
# ----------------------------------------------------------
OK=0
ERR_ARG=1
if ! [ $1 -ge 1 -a -le 12 ]; then
	echo "Error: Mes invalid"
	echo "Usage: $0 [1-12]"
	exit $ERR_ARG


for mes in $*
do
  case $mes in
    "4"|"6"|"9"|"11")
      echo "$mes 30 díes";;
    "2")
      echo "$mes 28 díes";;
    *)
      echo "$mes 31 díes";;
  esac      
done
exit $OK
