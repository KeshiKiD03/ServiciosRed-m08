#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 22/1/2020

# Versió: 1
# Descripció: Funcions

def quadrat(a):
    '''
    Funcio per calcular el cuadrat d'un numero
    input: int
    output: int
    '''
    resultat = a **2
    return resultat


def es_major(b):
    '''
    Funcio per comprovar si es major de edat
    input: int
    output: boolean
    '''
    return b >= 18

def es_primer(c):
    '''
    Funcio comprova si un nombre es primer
    input: int > 1
    output: boolean
    '''
    divisor = 2
    while divisor < c:
        # Si es divisible a al
        if c % divisor == 0:
            return False

        divisor += 1

    return True

def segons_formathora(d):
    '''
    Funcio que passa de segons a format hora hh:mm:ss
    input: int
    output: int:int:int
    '''
    hora = 0
    minuts = 0
    segons = 0

    # Calcular quants segons
    segons = d % 60

    # Calcular quants minuts
    minuts = d // 60

    # Calcula la hora
    hora = minuts // 60


    return "{} : {} : {}".format(hora,minuts,segons)

def lletra_dni(e):
    '''
    Funcio que retorna la lletra del DNI
    input: string que correspon a un dni
    output: str que correspon a la lletra
    '''
    #Mostrar lletra
    lletra = ['T','R','W','A','G','M','Y','F','P','D','X','B','N','J','Z','S','Q','V','H','L','C','K','E']
    validat = lletra[int(b)%len(lletra)]

    return validat

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
