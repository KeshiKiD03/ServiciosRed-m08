#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 22/1/2020

# Versió: 1
# Descripció: Calcula el quadrat d'un nombre
# Jocs de prova:
# Entrada                     Sortida
#   2                           4
#   5                           25
#   6                           36

def quadrat(a):
    '''
    Funcio per calcular el cuadrat d'un numero
    input: int
    output: int
    '''
    resultat = a **2
    return resultat

print(quadrat(6))
