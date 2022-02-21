#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 13/2/2020

# Versió: 1


def es_any_traspas(year):
	'''
	Comprova si es un any de traspas
	input: int
	ouptut: boolean
	'''
	# Són de traspàs els anys en que les dues darreres xifres de l'any son multiples de 4, excepte si aquestes xifres son 00.
	# Aleshores cal tenir en compte les dues primers xifres de l'any. Si son multiples de 4, l'any tamber sera de traspas.

	return year % 400 == 0 or (year % 4 == 0 and year % 100 != 0)

def ultim_dia_mes(mes,anyo):
	'''
	Retorna l'ultim dia del mes per a un any
	input: int (1..12, int)
	output: int
	'''
	
	if es_any_traspas(anyo):
		febrer=29
	else:
		febrer=28
	
	ultim_dia=[31,febrer,31,30,31,30,31,31,30,31,30,31]
		
	return ultim_dia[mes-1]

# Comprovem que va be (test driver)
if __name__ == '__main__':
	print('es_any_traspas')
	print(2020, es_any_traspas(2020))
	print(2019, es_any_traspas(2019))
	print(2017, es_any_traspas(2017))
	print('-------')
	print('ultim_dia_mes')
	print(2, 2020, ultim_dia_mes(2,2020))
	print(2, 2017, ultim_dia_mes(2,2017))
	print(1,2020,ultim_dia_mes(1,2020))
	print(4,2019,ultim_dia_mes(4,2019))