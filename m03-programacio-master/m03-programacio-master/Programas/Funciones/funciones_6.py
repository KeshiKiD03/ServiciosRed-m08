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
#    4                        2,3,5,7
#    5                         True
#    25                        False


def primers_primer(n):
    '''
    Funcio que mostra els n primers primers
    input: int >= 1
    output: int
    '''
    contador = 1
    primers = 2
    n_primers = ',2'
    while contador < n:
        # Calcular els primers i guardar a una variable
        if primers % 2 != 0:
            contador += 1
            n_primers = n_primers + ',' +  str(primers)

        primers += 1

    return n_primers[1:]




# Test Driver
while True:
    num = int(input())
    print(primers_primer(num))
