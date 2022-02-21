#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 22/1/2020

# Versió: 1
# Descripció: Calcula una cadena binaria a decimal
# E.E : 32 digits de 1 o 0
# Jocs de prova:
# Entrada                                         Sortida
#  11111111.11111111.11111111.11111111            255.255.255.255
#  11000000.10101000.00000001.01000001            192.168.1.65

def binari_decimal(ip_valid):
    '''
    Funcio que calcula una cadena binaria a decimal
    input: 1 cadena de 35 digits (Cada 8 digits 1 punt)
    output: 1 cadena de 4 digits separats en punts
    '''
    bit = 7
    ip_casi_final = 0
    ip_final = ''

    for i in ip_valid:

        # Mirem si el caracter es 0 o 1
        if i == '1' or i == '0':

            # Fem la conversio a decimal
            ip_valid = 2 ** bit *int(i)

            # Guardem el resultat a una variable temporal
            ip_casi_final = ip_valid + ip_casi_final

            # Pasem el següent bit
            bit -=1

        # Si es punt
        else:
            # Convertim el resultat a un string i posem un punt
            ip_casi_final = str(ip_casi_final) + '.'

            # Guardem el resultat a la variable final
            ip_final = ip_final + ip_casi_final

            # Buidem la variable temporal per poder sumar
            ip_casi_final = 0

            # Tornem el seté bit per tornar a calcular
            bit = 7

    # Juntem l'ultim camp amb la variable final
    ip_final = ip_final + str(ip_casi_final)

    return ip_final


# PROGRAMA #
# Variables
#contador = 0
#ip = ''
#ip_longitud = 8
#ip_correcte=''

# Bucle per posar la ip
#while contador < 32:
#    ip = str(input())
#    ip_correcte = ip_correcte + ip
#    contador += 1

    # Poso punts cada 8 caracters
#    if len(ip_correcte) == ip_longitud:
#        if ip_longitud < 35:
#            ip_correcte = ip_correcte + '.'
#            ip_longitud = ip_longitud + 9


# Mostrar el resultat de la funcio
print(binari_decimal('11111111.11111111.11111111.11111111'))
print(binari_decimal('11000000.10101000.00000001.01000001'))
