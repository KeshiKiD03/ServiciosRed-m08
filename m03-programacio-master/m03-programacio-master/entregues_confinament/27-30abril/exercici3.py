#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 30/4/2020

# Versió: 1
# Descripció: Ordena una llista segons l'algorisme de la bombolla


def bubble_sort(llista_int):
    '''
    Funció que ordena una llista de forma ascendent
    input: llista d'enters
    output: llista d'enters ordenat
    '''
    
    for i in range(len(llista_int)-1,0,-1):
        for j in range(i):
            if llista_int[j] > llista_int[j+1]:
                # Intercanvi de variables
                t = llista_int[j]
                llista_int[j] = llista_int[j+1]
                llista_int[j+1] = t
    return llista_int



if __name__ == "__main__":
    if True:
        llista=[2,53,2,1,63,6]
        print(bubble_sort(llista))
    if True:
        llista=[1,3,2,4,5,6]
        print(bubble_sort(llista))
    if True:
        llista=[10,9,8,7,6,5,4,3,2,1]
        print(bubble_sort(llista))