#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 30/4/2020

# Versió: 1


# Explicacion: 
# A primera vista parece que el programa funciona pero si nos fijamos NO ordena númericamente sino lexicografacamente.
# La funcion bombolla_sort solo ordena correctamente si el input es una lista de numeros enteros, si el input son cadenas ordenara lexicograficamente.
# 
# Ejemplo orden lexicografico: a = 29 b= 223 -->  a1=2 == b1=2        --> El número mas grande es 29 (lexicograficamente)
#                                                 a2=9 >  b2=2
#
# Ejemplo orden numerico: a=29 > b=223                                --> El número mas grande es 223 porque es obvio que es un número mayor



import dates, sys
def bombolla_dates(list):    
    '''
    Funció que ordena una llista de dates forma ascendent
    input: llista de cadenes
    output: llista de cadenes ordenat
    '''
    
    for i in range(len(list)-1,0,-1):
        for j in range(i):
            if dates.compara_data(list[j],list[j+1]) == 1:
                # Intercanvi de variables
                t = list[j]
                list[j] = list[j+1]
                list[j+1] = t
    return list

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

# llista = sys.argv[1:]
llista = ["12/03/2012" , "23/04/2012"  ,"31/01/2012" , "01/12/2012",  "14/11/2012"  ,"22/03/2012"]
print(bombolla_dates(llista))

print(bubble_sort(llista))
