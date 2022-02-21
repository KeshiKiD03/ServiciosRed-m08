#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 30/4/2020
# Versió: 1
# Descripció: Tenim una classe amb nens nascuts a l’any 2012, i els volem ordenar de més petit a més gran.

import sys,dates

def bubble_sort(list):
    '''
    Funció que ordena una llista de forma ascendent
    input: llista d'enters
    output: llista d'enters ordenat
    '''
    
    for i in range(len(list)-1,0,-1):
        for j in range(i):
            if list[j] > list[j+1]:
                # Intercanvi de variables
                t = list[j]
                list[j] = list[j+1]
                list[j+1] = t
    return list

llista_dates=sys.argv[1:]
llista_dies = []


# Treiem el any i ho convertim en dies de l'any
for i in range (0,len(llista_dates)):
    dia = dates.get_dia(llista_dates[i])
    mes = dates.get_mes(llista_dates[i])
    year = dates.get_year(llista_dates[i])
    dia_any = dates.calcular_dies(dia,mes,year)

    # Guardem el dia de l'any a la llista
    llista_dies.append(dia_any)
    
# Ordenem de menor a major
print(bubble_sort(llista_dies))
