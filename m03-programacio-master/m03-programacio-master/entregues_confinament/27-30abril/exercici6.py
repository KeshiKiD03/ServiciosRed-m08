#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 30/4/2020

# Versió: 1
import dates_ISO_8601, sys

def bombolla_dates(llista):    
	'''
	Funció que ordena una llista de dates forma ascendent
	input: llista de cadenes
	output: llista de cadenes ordenat
	'''
	for i in range(len(llista)-1,0,-1):
		for j in range(i):
			if dates_ISO_8601.compara_data(llista[j],llista[j+1]) == 1:
				# Intercanvi de variables
				t = llista[j]
				llista[j] = llista[j+1]
				llista[j+1] = t
	return llista

# Control d'errors
#llista = sys.argv[1:]
llista = ['2012/03/22' , '2012/04/23'  ,'2012/01/31' , '2012/12/01',  '2012/11/14'  ,'2012/03/22']

for i in llista:
    # Validar si anys, mesos i dias son valids  + validar longitud == 10 + validar format YYYY/MM/DD  
    if dates_ISO_8601.es_data_valida_str(i) == False:
        print("Error: " , i, "Date incorrect.")
        print("Usage: Date format YYYY/MM/DD")
        exit()

# Programa
print(bombolla_dates(llista))