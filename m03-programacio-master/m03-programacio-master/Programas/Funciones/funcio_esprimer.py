#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 21/1/2020

# Versió: 1
# Descripció: Es primer
# E.E : 1 int > 1
# Jocs de prova:
# Entrada                    Sortida
#    2                         True
#    5                         True
#    25                        False


def es_primer(num):
    '''
    Funcio comprova si un nombre es primer
    input: int > 1
    output: boolean
    '''
    divisor = 2
    while divisor < num:
        # Si es divisible a al
        if num % divisor == 0:
            return False

        divisor += 1

    return True

# Test Driver
print(es_primer(2))
print(es_primer(3))
print(es_primer(8))
print(es_primer(22))
