#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 22/1/2020

# Versió: 1
# Descripció: Diu si una cadena es enter o no, i real o no



def enter(a):
    '''
    Funcio que comprova si una cadena es enter o no.
    input: 1 cadena
    output: Boolean
    '''
    # Cadena buida
    if a == '':
        return False

    if a.isdigit() or (a[0] in '+-' and a[1:].isdigit()):
        return True

    return False

def real(a):
    '''
    Funcio que comprova si una cadena es numero real o no.
    input: 1 cadena
    output: Boolean
    '''
    # Cadena buida
    if a == '':
        return False

    # Si te dos signes seguits no es real
    if a[0] in '+-.' and a[1] in '+-.':
        return False

    # Si acaba amb un signe o caracter punt no es real
    if a[-1] in '+-':
        return False


    # Es real si es enter
    if a.isdigit() or (a[0] in '+-' and a[1:].isdigit()):
        return True

    # Comprovem si es float
    comprova_punts = 0
    for i in a:

        # Comprovar si es caracter
        if not i.isdigit() and not i in '+-.':
            return False

        # Si te dos punt a la cadena no es real
        if i == '.':
            comprova_punts += 1
            if comprova_punts == 2:
                return False

    # Comprova si hi ha un signe al mig
    comprova_signe = a[1:]
    for i in comprova_signe:
        if i in '+-':
            return False

    return True

while True :
    num = input()
    print("E: ",enter(num),"R: ",real(num))

'''
# Enter i num real
print("E: ",enter('1'),"R: ",real('1')) # True True
print("E: ",enter('-1'),"R: ",real('-1')) # True True
print("E: ",enter('+1'),"R: ",real('+1')) # True True


# Float i num real
print("E: ",enter('1.0'),"R: ",real('1.0')) # False True
print("E: ",enter('-1.0'),"R: ",real('-1.0')) # False True
print("E: ",enter('+1.0'),"R: ",real('+1.0')) # False True
print("E: ",enter('+1.'),"R: ",real('+1.')) # False True
print("E: ",enter('.1'),"R: ",real('.1')) # False True

# Cadena letras
print("E: ",enter('abc'),"R: ",real('abc')) # False False
print("E: ",enter('1abc'),"R: ",real('1abc')) # False False
print("E: ",enter('abc1'),"R: ",real('abc1')) # False False
print("E: ",enter('+abc'),"R: ",real('+abc')) # False False
print("E: ",enter('-abc'),"R: ",real('-abc')) # False False

# Altres

print("E: ",enter('.1.0'),"R: ",real('.1.0')) # False False
print("E: ",enter('--1.0'),"R: ",real('-+1.0')) # False False
print("E: ",enter('+-1.0'),"R: ",real('+-1.0')) # False False
print("E: ",enter('+-1'),"R: ",real('-+1')) # False False
print("E: ",enter('+-1'),"R: ",real('-+1')) # False False
print("E: ",enter('232+123'),"R: ",real('232+123')) # False False
print("E: ",enter('+232+123'),"R: ",real('+232+123')) # False False
print("E: ",enter('+232+123'),"R: ",real('+232.123.123')) # False False
print("E: ",enter(''),"R: ",real('')) # False False
'''
