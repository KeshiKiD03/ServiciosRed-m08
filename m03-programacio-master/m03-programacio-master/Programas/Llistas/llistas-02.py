#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 15/3/2020

# Versió: 1
# E.E. nomes cadenes de text

def intersection(array1, array2):
	'''
	Donada dues llistes, compara i retorna les paraules que apareixen tant a la primera llista com a la segona
	input: 2 arrays
	output: 1 array (amb les paraules repetides)
	'''
	intersection_word = []
	# Bucle que itera cada paraula 
	for pos1 in array1:	
		# Bucle que compara array1 amb array2
		for pos2 in array2:
			if pos1 == pos2:
				intersection_word = intersection_word + [pos2]

	return intersection_word



def diferencia1(array1,array2):
	'''
	Donada dues llistas, llista les paraules que apareixen a la primera pero no en la segona
	input: 2 arrays
	output: 1 array (amb les paraules que no apareixen en la segona)
	'''
	diference1_word = []
	contador = 0
	# Bucle que itera cada paraula
	for pos1 in array1:	
		# Bucle que compara array1 amb array2
		contador=0
		for pos2 in array2:
			if pos1 != pos2:
				contador += 1
			if contador == len(array2):
				diference1_word += [pos1]
					
	return diference1_word

def diferencia2(array1,array2):
	'''
	Donada dues llistas, llista les paraules que apareixen a la segona pero no en la primera
	input: 2 arrays
	output: 1 array (amb les paraules que no apareixen en la primera)
	'''
	diference2_word = []
	contador = 0
	# Bucle que itera cada paraula
	for pos1 in array2:	
		# Bucle que compara array1 amb array2
		contador=0
		for pos2 in array1:
			if pos1 != pos2:
				contador += 1
			if contador == len(array1):
				diference2_word += [pos1]
					
	return diference2_word

def union(array1,array2):
	'''
	Donada dues llistes, llista paraules que apareixen en algunes de les dos
	input: 2 arrays
	output: 1 array (paraules que apareixen en les dos llistes)
	'''

	union=[]
	array=array1+array2

	for pos in range(0,len(array)):
		# Comprovem si esta tachat
		if array[pos] != '0':
			for pos1 in range(pos+1, len(array)):
				# Esborrem els que estan repetits
				if array[pos]==array[pos1]:
					array[pos1]='0'
	# Construim la nova array sense els tachats
	for unic in array:
		if unic != '0':
			union += [unic]

	return union



llista1=['hola','que','tal']
llista2=['adios','hola', 'que']


if __name__ == '__main__':
	if False:
		print("intersection: ",intersection(llista1,llista2))
	if False:	
		print("diferencia1: ",diferencia1(llista1,llista2))
	if False:	
		print("diferencia2: ",diferencia2(llista1,llista2))
	if True:	
		print("union: ",union(llista1,llista2))