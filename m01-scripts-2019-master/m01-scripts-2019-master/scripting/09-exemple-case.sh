#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Febrer 2020
# Exemple Case
#-------------------------------

case $1 in 
	"dl"|"dt"|"dc"|"dc"|"dj"|"dv")
		echo "Es laborable";;
	"ds"|"dm")
		echo "Es festiu";;
	*)
		echo "No es un dia";;
esac
exit 0

case $1 in
	[aeiou])
		echo "Es vocal";;
	[bcdfghjklmnpqrstvwxyz])
		echo "Es consonant";;
	*)
		echo "Un altre caracter"
esac
exit 0

case $1 in 
	"pere"|"pau"|"joan")
		echo "es un nen";;
	"marta"|"anna"|"julia")
		echo "es una nena";;
	*)
		echo "indefinit";;
esac
exit 0
