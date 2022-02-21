#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 17/3/2020

# Versió: 1
#        7. Fes un programa que rebi per stdin un text i mostri un histograma 
#		de freqüències de longituds de les paraules.

#De moment, no passa res si suposem que l'entrada és una única línia
#quan treballem amb fitxers aprendrem a llegir línia a línia

#La funció long_frequencies segurament és la més natural que sen's ocorre 
#per començar. Poc a poc intentarem que sigui més modular
# D'entrada suposem que la long màxima és 10.
#En la segona versió es tracta d'afegir camps si una paraula té una longitud major
#una paraula és qualsevol cosa separada per un blanc

import sys

def long_frequencies(cadena):
	'''
	Calcula quant es la longitud de cada paraula que hi ha a la llista
	input: cadena amb paraules (EN AQUESTA VERSIÓ LA LEN MAXIMA ËS 10)
	output: llista d'enters, on a cada posició hi ha la quantitat de paraules
	que tenen aquella longitud
	'''

	# len maxima 10
	freq=[0]*11
	cadena_paraules = cadena.split()

	for paraula in cadena_paraules:
		# Busquem la posicio de la longitud de la paraula
		freq[len(paraula)] += 1

	return freq

def histograma(freqs):
	'''
	input: llista d'enters
	output: res (void)
	'''
	caracter = '*'

	for i in range(len(freqs)):
		freq = caracter * freqs[i]
		print(f'{i: 3}: {freq}')



#Calculem les frequencies
text=input("Introduce una cadena : ")
print(long_frequencies(text))

#dibuixem l'histograma
histograma(long_frequencies(text))