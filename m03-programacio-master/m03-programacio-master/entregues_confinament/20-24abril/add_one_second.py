#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 22/4/2020

# Write a program that adds one second to a clock time, given its hours, minutes and seconds.

# E.E Input consists of three natural numbers h, m and s that represent a clock time, that is, such that h<24, m<60 and s<60.

# Jocs de proves
# Entrada                       Sortida
# 11 33 15                     11:33:16
# 19 45 59                     19:46:00
# 12 59 59					   13:00:00

def construeixHora(hh,mm,ss):
	'''
	Agafa 3 variables que son hores, minuts i segons, el converteix
	en el format hora (hh:mm:ss)
	input: int, int, int
	output: str en format hh:mm:ss 
	'''
	return ('{:02}:{:02}:{:02}'.format(hh, mm, ss))

def get_hour(horastr):
	'''
	Agafa les hores del format hh:mm:ss
	input: str (hh:mm:ss)
	output: int
	'''
	return (int(horastr[:2]))

def get_minute(horastr):
	'''
	Agafa els minuts del format hh:mm:ss
	input: str (hh:mm:ss)
	output: int
	'''
	return (int(horastr[3:5]))

def get_seconds(horastr):
	'''
	Agafa els segons del format hh:mm:ss
	input: str (hh:mm:ss)
	output: int
	'''
	return (int(horastr[6:]))

def add_one_second(horastr):
	'''
	Retorna el format hh:mm:ss d'un segon despres
	input: str en format hh:mm:ss 
	output: str en format hh:mm:ss
	'''
	s = get_seconds(horastr)
	m = get_minute(horastr)
	h = get_hour(horastr)

	s += 1
	# Si segons arriba a 60 suma un minut
	if s == 60:
		s = 0
		m += 1
		# Si minut arriba a 60 suma una hora
		if m == 60:
			m = 0
			h += 1
			# Si hora arriba a 24 es reinicia 
			if h == 24:
				h = 0
	return construeixHora(h,m,s)

import sys

# Variables
elem_hour = sys.stdin.readline().split()
hour,minute,seconds = int(elem_hour[0]),int(elem_hour[1]),int(elem_hour[2])

cadena_hora=construeixHora(hour,minute,seconds)
print(add_one_second(cadena_hora))