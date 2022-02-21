#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 27/2/2020

# Versió: 1
# Descripció: Programa que calcula el lloguer d'un local
# E.E : str (hh:mm:ss) , str (hh:mm:ss)  
# E.E : hh >= 0 and <= 23 
# E.E : mm >= 0 and <= 59 
# E.E : ss >= 0 and <= 59

# JOC DE PROVES
#    ENTRADA                      SORTIDA
#    10:00:00  24:00:01           Finalitza: 10:00:01
# 								  Cost: 42
#    03:00:00  04:00:01           Finalitza: 07:00:00
# 								  Cost: 8 €
#    10:00:00  25:00:01           Finalitza: 11:00:01
# 								  Cost: 44 € 
#    10:00:00  50:00:01           Finalitza: 11:00:01
# 								  Cost: 84 € 
#    10:00:00  00:00:05           Finalitza: 10:00:05
# 								  Cost: 2

import sys, examen_ex2_modulhores

def final_activitat(inici,durada):
	'''
	Calcula la hora de l'activitat final
	input: str (hh:mm:ss), str (hh:mm:ss)
	output: str (hh:mm:ss)
	'''
	es_final = False
	contador = 0
	durada_restant = durada
	while es_final == False:
		examen_ex2_modulhores.segon_despres(inici)





		if contador == durada:
			es_final = True



def calcular_lloguer(activitat_durada):
	'''
	Calcular quant ha de pagar
	input: str (hh:mm:ss) SEMBLANT
	output: int 
	'''
	hour = examen_ex2_modulhores.get_hour(activitat_durada)
	minute = examen_ex2_modulhores.get_minute(activitat_durada)
	seconds = examen_ex2_modulhores.get_seconds(activitat_durada)

# Calcular la hora que acaba l'activitat

# Calcular el preu que ha de pagar

hora_inici = sys.argv[1]
hora_durada = sys.argv[2]
final = 
print("Finalitza: ", )
print("Cost: ", )
