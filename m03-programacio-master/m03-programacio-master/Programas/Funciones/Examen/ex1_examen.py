#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 6/2/2020

# Versió: 1
# Descripció: Exercici 1 , Funcio xifratge transposicio
# Especificacions d'entrada: Una cadena i un int > 0
# Restriccions: Clau > 0
# Jocs de prova:
# Entrada                                            Sortida
# "Com m'agraden els macarrons"     5           'mmoCdargasleneracam!snor
# "Hola Que Tal"   3                            loHuQaaTel



def xifratge_transposicio(missatge,clau):
    '''
    Funcio que fa un xifratge de transposicio
    input: cadena, int > 0
    output: cadena
    '''
    # Triem espais
    missatge_s_e = ''
    for i in missatge:
        if not i == ' ':
            missatge_s_e = missatge_s_e + i

        missatge_s_e
    # Dividim i reordem el missatge
    missatge_reves = ''
    inicial = 0
    contador = 0
    inicial = 0
    final = clau
    xifrat = ''
    while contador <= len(missatge_s_e):
        for i in missatge_s_e[inicial:final]:
            missatge_reves= i + missatge_reves

        # Juntem tot el missatge
        xifrat = xifrat + missatge_reves

        missatge_reves = ''
        inicial = final
        final += clau
        contador += clau

    return xifrat

# Test Driver
print(xifratge_transposicio("Com m'agraden els macarrons!",5)) # 'mmoCdargasleneracam!snor
print(xifratge_transposicio("Hola Que Tal",3)) # loHuQaaTel
