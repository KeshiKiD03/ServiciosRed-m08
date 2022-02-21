# !/usr/bin/python
#  -*- coding:utf-8 -*-
# Autor: Christian Manalo Mañibo - isx9565961
# 11/05/2020

#Descripcio: MODUL DICCIONARIS


def crea_dicc_freq_patro(frase,carac_a_buscar):
	"""
	Funcio que rep per parametre una seqüència qualsevol(str/list) i una
	llista de caracters/elements a buscar i et compta les repeticions
	Input: Una seqüència qualsevol(string/list) i una altra (string/list)
	amb els caràcters/elements  a buscar 
	Output: Les claus amb els seus respectius valorsnumérics
	"""
	diccionari = {}
	# Creem el diccionari
	for clau in carac_a_buscar:
		diccionari[clau] = 0
	
	for pos1 in range(0,len(carac_a_buscar)):
		for i in frase:
			if carac_a_buscar[pos1] == i: 
				diccionari[carac_a_buscar[pos1]] =  diccionari.get(carac_a_buscar[pos1]) + 1
	
	return diccionari
	
	
def frequencies(seq):
	"""
	Funcio que compta la frequencia dels caràcters/elements que passem
	i ens retorna la quantitat de vegades que es repeteix cada paraula o caracter
	Input: cadena o llista
	Output: claus amb els seus respectius valors numérics
	"""

	diccionari = {}
	# Creem el diccionari
	# Per cada element de la secuencia
	for i in seq:
		#Si no esta al diccionari , creem l'entrada
		if not i in diccionari and i != ' ':
			diccionari[i] = 1
		# incrementem 1 a la frecuencia
		elif i in diccionari and i != ' ':
			diccionari[i] = diccionari.get(i) + 1
		
	return diccionari
 

def diccionari_maco(dic):
	""" 
	Funció que ens mostra un diccionari de manera 'maca'. És a dir, a cada 
	línia ens mostra un element (clau, valor) així:
	clau: clau	valor:valor
	Input: diccionari
	Output: res  (la pròpia funció printa)
	"""
	for key in dic:
		print("clau:",key,"   valor:",dic[key])

	
###################################################################
#TEST DRIVER
if __name__ == "__main__" :		
	if False:
		print(crea_dicc_freq_patro(['hola','com','hola','estas','tu','jo','be','i','tu'],['hola','tu','be']))
		print(crea_dicc_freq_patro('hola com estas jo be i tu',['a','e','i','o','u']))
		
	if False:
		print(frequencies('hola com estas jo be i tu'))
		print(frequencies(['hola','com','estas','jo','be','i','tu','jo','be','hola']))
	
	if True:
		print(diccionari_maco(crea_dicc_freq_patro(['hola','com','hola','estas','tu','jo','be','i','tu'],['hola','tu','be'])))
		print(diccionari_maco(crea_dicc_freq_patro('hola com estas jo be i tu',['a','e','i','o','u'])))
		print(diccionari_maco(frequencies('hola com estas jo be i tu')))
		print(diccionari_maco(frequencies(['hola','com','estas','jo','be','i','tu','jo','be','hola'])))