#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 16/4/2020
# Write a program that, given a number n, prints a “triangle of size n”.
# E.E Input consists of a natural number n.

# joc de proves
# 4              *
#			     **
#                ***
#                ****

num = int(input())
for n in range(1,num+1):
	print("*" * n)
