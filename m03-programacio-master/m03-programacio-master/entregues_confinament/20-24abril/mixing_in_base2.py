#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 22/4/2020

# Given a natural number x > 0 with n bits, we denote with xn−1… x0 its representation in base 2. For example, x = 8 in base 2 is 1000, so x3 = 1 and x2 = x1 = x0 = 0.

# Write a program to mix the base 2 representations of two given natural numbers x and y with the same number of bits n. That is, print xn−1 yn−1 … x0 y0.

# E.E Input consists of several cases, each with two natural numbers with the same number of bits, between 1 and 30.

import sys

def int_to_base2(elem):
	'''
	Retorna un int en base 2
	input: int
	output: str (0 i 1)
	'''
	return bin(elem)[2:]

def mix(cadena1, cadena2):
	'''
	Barreja les dues cadenas
	input: 2 str format binari (0 i 1)
	output: 1 str format binari (barreja dels dos)
	'''
	mix = ''
	for pos1 in range(0,len(cadena1)):
		mix = mix + str(cadena1[pos1]) + str(cadena2[pos1])
	return mix

num = sys.stdin.readline()
elem = num.split()


while num != "":
	elem1=int_to_base2(int(elem[0]))
	elem2=int_to_base2(int(elem[1]))

	print(mix(elem1,elem2))

	num = sys.stdin.readline()
	elem = num.split()


	
