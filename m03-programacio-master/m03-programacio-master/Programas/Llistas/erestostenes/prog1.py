#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 4/3/2020

# Versió: 1
# Descripció:
# Jocs de prova:

import sys
max = int(sys.argv[1])
nums = []

for i in range(2,max+1):
	nums.append(i)

# Itera hasta la mitad de la llista
for pos in range(len(nums)+1//2):
	# Comprueba si no esta tachado
	if nums[pos] != 0:
		for pos2 in range(nums[pos]+1,len(nums)):
			if nums[pos2] % nums[pos] == 0:
				nums[pos2] = 0
print(nums)