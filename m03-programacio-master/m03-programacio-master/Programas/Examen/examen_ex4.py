#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 27/2/2020

# Versió: 1
# Descripció: Rep una hora de rolletge per argument i mostri el segon seguent
# E.E : str (hh:mm:ss)  

# Joc de proves:
#   ENTRADA                             SORTIDA
#	00:00:00							00:00:01
#   00:00:59                            00:01:00
#   00:59:59                            01:00:00                             
#   23:59:59                            00:00:00

import sys, examen_ex2_modulhores

def segon_despres(horastr):
	'''
	Retorna el format hh:mm:ss d'un segon despres
	input: str en format hh:mm:ss
	output: str en format hh:mm:ss
	'''

	hour = examen_ex2_modulhores.get_hour(horastr)
	minute = examen_ex2_modulhores.get_minute(horastr)
	seconds = examen_ex2_modulhores.get_seconds(horastr)

	seconds += 1

	# Si segons arriba a 60 suma un minut
	if seconds == 60:
		seconds = 0
		minute += 1
		# Si minut arriba a 60 suma una hora
		if minute == 60:
			minute = 0
			hour += 1
			# Si hora arriba a 24 es reinicia 
			if hour == 24:
				hour = 0

	return  examen_ex2_modulhores.construeixHora(hour, minute, seconds)	

# Test Driver
if __name__ == '__main__':
	if False:
		print("segon_despres")
		print("00:00:00", segon_despres("00:00:00"))
		print("00:00:59", segon_despres("00:00:59"))
		print("00:59:59", segon_despres("00:59:59"))
		print("23:59:59", segon_despres("23:59:59"))

# JOC DE PROVES - Control d'errors
#    ENTRADA                      SORTIDA
#    24:00:00                     ERROR
#    00:60:00                     ERROR
#    00:00:60                     ERROR
#    2:0:1                        ERROR
#                                 ERROR

# Control d'errors
if not len(sys.argv) == 2:
	print("Error: Num arguments incorrecte")
	print("Usage: hh:mm:ss ")
	exit()

if not examen_ex2_modulhores.es_hora_correcte(sys.argv[1]):
	print("Error: Argument invalid")
	print("Usage: Ha de ser una hora valida hh:mm:ss") 
	exit(2)

# Programa
hora = sys.argv[1]

print(segon_despres(hora))