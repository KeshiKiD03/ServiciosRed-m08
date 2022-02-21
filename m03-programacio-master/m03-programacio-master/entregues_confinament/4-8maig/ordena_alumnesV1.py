#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 6/5/2020

# Versió: 1

#Programa per o ordenar segons diferents criteris una llista de llistes d'alumnes

#V1: Tenim les dades estructurades en una llista de llistes (guarrada)
#En la següent versió s'estructuraran amb diccionaris


def mostraAlumne(l_alumne):
	'''
	Funció que ens mostra les dades d'un alumne d'aquesta manera:
	maria casas, dni: 72345678A,  mitjana: 5
	Entrada: llista d'alumne [dni, nom, cognom, [nota1, nota2, nota3]]
	Sortida: str
	'''
	return f'{l_alumne[1]} {l_alumne[2]}, dni: {l_alumne[0]}'
	
	

def llistat_Alumnes(tots):
	'''
	Funció que em mostra tots els alumnes, un per línia, utilitzant la funció 
	mostraAlumne
	Entrada: llista de llistes d'alumnes
	sortida: res
	'''
	for alumne in tots:
		print(mostraAlumne(alumne))		


def take_second(elem):
	'''
	Key function per a ordenar segons el segon camp
	input: element a ordenar, enter que representa el numero del camp
	output: segon camp
	'''
	return elem[1]
    
def take_third(elem):
	'''
	Key function per a ordenar segons el tercer camp
	input: element a ordenar, enter que representa el numero del camp
	output:
	'''
	return elem[2]
	

	

dadesAlumnes = [['12345678A', 'jordi', 'perez'], ['52345678A',
	'manel', 'garcia'], ['62345678A', 'joan-ramon', 'vila'],
	 ['72345678A', 'maria', 'casas'], ['11111111D', 'josep-lluís', 'márquez']]

print('llista de un alumne')
print(dadesAlumnes[0])
print()

#mostrar un alumne així és molt lleig. Definim una funció que ens mostra l'alumne de manera 'maca'
print('alumne ben escrit')
print(mostraAlumne(dadesAlumnes[0]))
print()

print( 'alumnes sense ordenar:')
llistat_Alumnes(dadesAlumnes)
print()

print ('alumnes ordenats segons el dni')
#El dni és el primer camp de la llista. Recordeu que les llistes tenen ordre
#natural (i és el lexicogràfic, comparant element a element)
dadesAlumnes.sort()
llistat_Alumnes(dadesAlumnes)
print()

print('alumnes ordenats segons el nom')
# El nom és el segon camp de la llista. Cal definir una key function que ens retorni
#el segon camp
dadesAlumnes.sort(key=take_second)
llistat_Alumnes(dadesAlumnes)
print()

print('alumnes ordenats segons el cognom')
# El cognom és el tercer camp de la llista. Cal definir una key function que ens retorni
#el tercer camp
dadesAlumnes.sort(key=take_third)
llistat_Alumnes(dadesAlumnes)
print()

