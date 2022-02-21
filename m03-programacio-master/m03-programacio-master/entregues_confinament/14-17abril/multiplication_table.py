#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 16/4/2020

# Write a program that reads a number n and prints the “multiplication table” of n.

# E.E Input consists of a natural number n between 1 and 9.

# joc de proves
# 2             2*1 = 2
#				2*2 = 4
#				2*3 = 6
#				2*4 = 8
#				2*5 = 10
#				2*6 = 12
#				2*7 = 14
#				2*8 = 16
#				2*9 = 18
#				2*10 = 20

num = int(input())

for n in range(1,11):
	resultado = num * n
	print(num,"*", n," = ", resultado, sep="")

