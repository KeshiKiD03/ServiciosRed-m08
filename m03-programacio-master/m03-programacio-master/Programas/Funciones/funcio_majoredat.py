#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 21/1/2020

# Versió: 1
# Descripció: Major edat
# E.E : 1 int >= 0
# Jocs de prova:
# Entrada                       # Sortida
#    0                           False
#    17                          False
#    18                          True
#    19                          True

def es_major(a):
    '''
    Funcio per comprovar si es major de edat
    input: int
    output: boolean
    '''
    return a >= 18

print(es_major(10)) # False
print(es_major(0)) # False
print(es_major(17)) # False
print(es_major(18)) # True
print(es_major(19)) # True
print(es_major(20)) # True
