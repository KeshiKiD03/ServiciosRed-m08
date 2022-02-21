#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 16/4/2020

# Descripció: Write a program that reads an integer number that represents a temperature given in degree
# Celsius, and that tells if the weather is hot, if it’s cold, or if it’s ok. Suppose that it’s hot
# if the temperature is higher than 30 degrees, that it’s cold if the temperature is lower than
# 10 degrees, and that it’s ok otherwise. Moreover, warn if with the given temperature water
# would boil, or if water would freeze. Assume that water boils at 100 or more degrees, and
# that water freezes at 0 or less degrees.
# E.E Input consists of an integer number.

# Joc de proves
#  16                           it’s ok
#  -5                          it’s cold 
#                            water would freeze
#  99                           it’s hot
#  100                          it’s hot
#                            water would boil


num = int(input())
if num < 10 :
	print("it's cold")
	if num <= 0:
		print("water would freeze")
elif num >= 10 and num <= 30:
	print("it's ok")
else: 
	print("it's hot")
	if num >= 100:
		print("water would boil")



