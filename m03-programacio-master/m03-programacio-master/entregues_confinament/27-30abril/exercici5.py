#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 30/4/2020

# Versió: 1

import dates, sys
def bombolla_dates(llista):    
    '''
    Funció que ordena una llista de dates forma ascendent
    input: llista d'enters
    output: llista de dates ordenat
    '''
    
    for i in range(len(llista)-1,0,-1):
        for j in range(i):
            if dates.compara_data(llista[j],llista[j+1]) == 1:
                # Intercanvi de variables
                t = llista[j]
                llista[j] = llista[j+1]
                llista[j+1] = t
    return llista

# llista = sys.argv[1:]
llista = ["12/03/2012" , "23/04/2012"  ,"31/01/2012" , "01/12/2012",  "14/11/2012"  ,"22/03/2012"]
print(bombolla_dates(llista))