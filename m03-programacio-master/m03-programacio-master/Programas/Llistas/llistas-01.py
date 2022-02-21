#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 13/2/2020

# Versió: 1
# Descripcio: Mostra el maxim dels arguments passats
# E.E  1 a n numeros enters

import sys

def max(llista):
	'''
	Retorna el numero mes gran d'una llista
	input: llista (nombres)
	output: int
	'''
	maximo=llista[0]
	for nombre in llista:
		if int(nombre) > int(maximo):
			maximo = nombre
	return maximo	

# Control d'error
if len(sys.argv) < 2 :
	# 💩 
	print("Error: Num d'argument incorrectes")
	print("Usage:" , sys.argv[0], "arg[...]")
	exit(1)

llista_numeros=sys.argv[1:]
print(f"El màxim és: " , max(llista_numeros))