#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 6/5/2020

# Versió: 1
# Descripció:

# L’entrada consisteix en diversos casos. Cada cas comença amb n, seguit de 3n enters amb el
# preu de cada ós, tots entre 1 i 10^4 . Podeu suposar 0 ≤ n ≤ 10^5 .

# Jocs de proves: 
#   Entrada                              Sortida
# 1  7 7 9                                 16
# 0                                        0
# 3 42 23 17 23 42 100 100 100 1           324



def minim_pagar(elem):
    '''
    Retorna la suma dels 2 numeros mes grans
    input: 1 llista ordenada (3 numeros)
    output: 1 enter
    '''
    resultat = 0
    for i in elem[:-1]:
        resultat = resultat + int(i)

    return resultat

def agrupar(elem,grups):
    '''
    Agrupa una llista depenent dels grups
    intput: llista enters, int
    output: llista
    '''
    llista =  []
    for i in range(grups):
        llista.append([i]*3)

    pos_llista = 0
    for pos1 in range(grups): 
        for pos2 in range(3): 
            llista[pos1][pos2] = elem[pos_llista]
            pos_llista += 1

    return llista


import sys


matrix = sys.stdin.readline()
matrix_list=matrix.split()


while matrix != "":

    agrupacions = int(matrix_list[0])

    # Converteixo en enters 
    for i in range(0,len(matrix_list)):
        llista=[]
        for j in matrix_list[1:]:
            llista.append(int(j))

    # Ordeno la llista 
    llista.sort(reverse=True)

    # Agrupem si hi ha mes de 3 enters
    if agrupacions > 1:
        llista = agrupar(llista,agrupacions)
        
        # Sumem
        resultat = 0
        for i in range(len(llista)):
            resultat = minim_pagar(llista[i]) + resultat

        print(resultat)

    else: 
        print(minim_pagar(llista))

    # Reiniciem
    matrix = sys.stdin.readline()
    matrix_list=matrix.split()
