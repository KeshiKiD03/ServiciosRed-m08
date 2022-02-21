#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 18/5/2020

# Versió: 1
# Descripció: Fes un programa que simuli la ordre cat. Usage cat.py file[...]
import sys


lista_ficheros = sys.argv[1:]
for nombre_fichero in lista_ficheros:

    try:
        # Abrir el fichero
        fichero = open(nombre_fichero,'r')

        # Imprimir lineas
        for linea in fichero:
            if linea[-1] == '\n':
                linea = linea[:-1]
            print(linea)

        # Cerrar el fichero
        fichero.close()
    except IOError:
        print("Error: Archivo",nombre_fichero,"no existe")

    
