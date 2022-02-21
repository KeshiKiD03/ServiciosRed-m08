#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 18/5/2020

# Versió: 1
# Descripcio: Fes un programa compti les línies d'un fitxer passat per argument. Usage: exercici1.py file

import sys
if len(sys.argv) != 2:
    print("Error: Numero de argumentos incorrectos")
    print("Usage: python3 exercici1.py file")
    exit()
else: 
    try:
        # Argumento
        nombre = sys.argv[1]
        
        # Abrir el fichero
        fichero = open(nombre,'r')

        # Contar lineas
        contador = 0
        for linea in fichero:
            contador += 1
        print(contador)

        # Cerrar el fichero
        fichero.close()

    except IOError:
        print("Error: Archivo",nombre,"no existe")
