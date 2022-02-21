#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 21/1/2020

# Versió: 1
# Descripció: DNI correcte
# E.E : 8 digits amb una lletra

def dni(a):
    '''
    Funcio per comprovar si dni es correcte
    input: cadena de 9 caracters: 8 digits i una lletra
    output: boolean
    '''

    # Comprova longitud
    if len(a) != 9:
        return False

    # Retallem
    num = a[:8]
    lletra = a[8]

    # Comprovar que el numero es enter
    if not num.isdigit():
        return False

    # Comprovem la lletra (funcio)
    return lletra == lletra_dni(num)



def lletra_dni(b):
    '''
    Funcio que retorna la lletra del DNI
    input: string que correspon a un dni
    output: str que correspon a la lletra
    '''
    #Mostrar lletra
    lletra = ['T','R','W','A','G','M','Y','F','P','D','X','B','N','J','Z','S','Q','V','H','L','C','K','E']
    validat = lletra[int(b)%len(lletra)]

    return validat

print(dni('47328890L')) # True
print(dni('47328890F')) # False
print(dni('473288L')) # False
print(dni('47328890')) # False
print(dni('F47328890')) # False
