#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 11/5/2020

# Versió: 1
# Description: Fes una funció que ens retorni una llista amb tots els valors d'un diccionari. Si un valor està repetit, només ha de sortir una vegada. 

def list_dict_value(dictionary):
    '''
    Retorna una llista dels valors del diccionari
    input: 1 dict
    output: 1 list
    '''
    new_list = []
    for i in dictionary.values():
        if not i in new_list:
            new_list.append(i)
    return new_list

num ={
    "one":1,
    "uno":1,
    "dos":2,
    "two":2,
}

    
if __name__ == "__main__":
    if True:
        print(num)
        print(list_dict_value(num))

