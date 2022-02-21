#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 18/5/2020

# Versió: 1
# Descripció: 
# En aquest problema haureu de decidir si una paraula es un palındrom (si es llegeix igual
# d’esquerra a dreta que a l’inreves), si es un palındrom de Morse (si la traducci o a codi
# Morse, ignorant els espais, es un palındrom), si es les dues coses alhora (d’aix `o en direm
# un superpalındrom), o si no te cap d’aquestes propietats.

import sys

def trad_morse(morse,string):
	'''
	Retorna el string en morse.
	input: 1 str
	output: 1 str (morse)
	'''
	string_morse = ''
	for i in range(len(string)):
		string_morse = string_morse + morse[string[i]]
	
	return string_morse


def es_palindrom(string):
	'''
	Retorna si un string es palindrom, (si es llegeix igual d’esquerra a dreta que a l’inreves
	input: 1 str
	output: Boolean
	'''
	
	string_invertida=''
	for i in range(len(string)):
		string_invertida = string[i] + string_invertida

	if string == string_invertida:
		return True 
	else:
		return False

# Programa
# Diccionari Morse
morse = {'A': '.-', 'B': '-...', 'C': '-.-.', 'D': '-..', 'E': '.', 
	'F': '..-.', 'G': '--.', 'H': '....', 'I': '..', 'J': '.---', 'K': '-.-', 
	'L': '.-..', 'M': '--', 'N': '-.', 'O': '---', 'P': '.--.', 'Q': '--.-', 
	'R': '.-.', 'S': '...', 'T': '-', 'U': '..-', 'V': '...-', 'W': '.--', 
	'X': '-..-', 'Y': '-.--', 'Z': '--..'}



palabra = sys.stdin.readline().strip()

while palabra != '': 
	# Comprobar si es palindromo
	palindromo = es_palindrom(palabra)
	
	# Traducir a morse 
	morse_palabra = trad_morse(morse,palabra)

	# Comprobar si la palabra morse es palindromo
	morse_palabra_palindromo = es_palindrom(morse_palabra)
	
	# Resultados
	if palindromo == True or morse_palabra_palindromo == True:
		if palindromo == True and morse_palabra_palindromo == True:
			print("SUPERPALINDROM")

		elif palindromo == True and morse_palabra_palindromo == False:
			print("PALINDROM")
			
		else:
			print("PALINDROM DE MORSE")
	else:
		print("RES")
	
	palabra = sys.stdin.readline().strip()

# --------------------------------- TEST DRIVER --------------------------------# 
if __name__ == "__main__":
	if False:
		print("ANNA---> ", es_palindrom("ANNA"))
		print("IVET--->", es_palindrom("IVET"))
		print("POP---> ", es_palindrom("POP"))

	
	if False:
		print("ANNA---> ", trad_morse(morse,"ANNA"))
		print("IVET--->", trad_morse(morse,"IVET"))
		print("PULP---> ", trad_morse(morse,"PULP"))
