#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 6/2/2020

# Versió: 1
# Descripció: Exercici 1 , Funcio xifratge transposicio
# Especificacions d'entrada: Una cadena i un int >= 0
# Restriccions: Clau >= 0
# Jocs de prova:
# Entrada                                            Sortida
# "Com m'agraden els macarrons"     5           'mmoCdargasleneracam!snor
# "Hola Que Tal"   3                            loHuQaaTel


def treure_espais(cadena):
    '''
    Funcio que treu els espais d'una cadena
    input: str
    output: str
    '''
    cadena_s_e = ''
    for i in cadena:
        if not i == ' ':
            cadena_s_e = cadena_s_e + i

    return cadena_s_e

# Test Driver
# print(treure_espais("Holaa   Holaa")) # HolaaHolaa

def reverse(cad):
    '''
    Funcio que inverteix la cadena
    input: str
    output: str
    '''
    cad_reves = ''
    for i in cad:
        cad_reves = i + cad_reves

    return  cad_reves

# Test Driver
# print(reverse("Hola") # aloH

def xifratge_transposicio(missatge,clau):
    '''
    Funcio que fa un xifratge de transposicio
    input: cadena, int >= 0
    output: cadena
    '''
    # Triem espais
    missatge = treure_espais(missatge)
    missatge_nou = ''

    # Bucle
    for inici in range(0,len(missatge),clau):
        # Retallar
        part = missatge[inici:inici+clau]
        
        # Invertir
        part = reverse(part)
        missatge_nou += part

    return missatge_nou

# Test Driver
print(xifratge_transposicio("Com m'agraden els macarrons!",5)) # 'mmoCdargasleneracam!snor
print(xifratge_transposicio("Hola Que Tal",3)) # loHuQaaTel


