#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 18/5/2020

# Versió: 1
# Descripcio: Fes un programa que compti les paraules d'un fitxer passat per argument. Si no hi ha argument, s'ha d'utilitzar l'entrada estandard.
# Usage: python 3 exercici1.py [file]
import sys

try:
    # Argumento
    if len(sys.argv) == 2:
        nombre = sys.argv[1] 
    else:
        # Entrada Estandard
        nombre = input("Nombre fichero: ")

    # Abrir el fichero
    fichero = open(nombre,'r')
    # Contar lineas
    contador = 0
    for linea in fichero:
        contador += len(linea.split())
    print(contador)

    # Cerrar el fichero
    fichero.close()
    
except IOError:
    print("Error: Archivo",nombre,"no existe")
