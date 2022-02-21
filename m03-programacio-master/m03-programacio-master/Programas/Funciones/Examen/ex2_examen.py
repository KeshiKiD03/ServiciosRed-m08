#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 22/1/2020

# Versió: 1
# Descripció: Programa que xifra segons el codi de Vigenère 
# Especificacions d'entrada: 1 cadena i 1 paraula
# Jocs de prova: 
#   Entrada                                              Sortida
#  macarro            sol                                eonsfcg
#  'vull macarrons'   sol                                niwdaluocjcyk



import sys
LLETRES = 'abcdefghijklmnopqrstuvwxyz'

def sense_espais(cadena):
    '''
    Funcio que esborra els espais d'una cadena
    input: 1 cadena amb espai
    output: 1 cadena sense espai
    '''
    cadena_s_e = ''

    for i in cadena:
        if not i == ' ':
            cadena_s_e = cadena_s_e + i

    return cadena_s_e

# Test Driver
# print(sense_espais("Hola    Que   Tal")) # HolaQueTal
# print(sense_espais("   Hola     Hola          Hola  ")) #HolaHolaHola

def transformar_caracter(lletra,clau_lletra):
    '''
    Funcio que tranforma els dos caracters en nombres, es suma i retorna
    el caracter resultant.
    input: 2 caracters
    output: 1 caracter
    '''
    # Calcula el nombre de cada lletra
    lletra = ord(lletra) - ord('a')
    clau_lletra = ord(clau_lletra) - ord('a')

    # Suma la lletra i la clau
    nombre = clau_lletra + lletra

    # Fem el modul i calcular lletra
    nombre_xifrat = LLETRES[nombre%26]

    return nombre_xifrat

# Test Driver
# print(transformar_caracter('m','s')) # e
# print(transformar_caracter('a','o')) # o

missatge = sys.argv[1]
paraula_clau = sys.argv[2]

# Esborrar l'espai del missatge
missatge_s_e = sense_espais(missatge)
paraula_clau_s_e = sense_espais(paraula_clau)
# Transforma cada lletra del missatge amb la clau
pos_m = 0
pos_c = 0
missatge_xifrat = ''

while pos_m <= len(missatge_s_e)-1:   
    # Agafem cada lletra per transformar
    lletra_m = missatge_s_e[pos_m]
    lletra_c = paraula_clau_s_e[pos_c]

    xifrat = transformar_caracter(lletra_m,lletra_c)

    # Guardar el resultat
    missatge_xifrat = missatge_xifrat + xifrat

    # Reiniciar la posicion de la paraula clau
    if pos_c == len(paraula_clau_s_e)-1:
        pos_c = 0
        pos_m += 1

    else:

        pos_m += 1
        pos_c += 1
        

# Mostrar resultat
print(missatge_xifrat)