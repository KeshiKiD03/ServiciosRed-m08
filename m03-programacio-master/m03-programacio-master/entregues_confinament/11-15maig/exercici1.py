#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 11/5/2020

# Versió: 1
# Description: Fes una funció que donat un diccionari i un valor, digui si aquest valor està o no en el diccionari.


def find_key(dictionary,key):
    '''
    Comprova si el key introduit esta en el diccionari o no
    input: 1 dict , 1 key (Valor a trobar en el diccionari)
    output: bool
    '''
    return key in dictionary



spanish_japanese_words = {"Hola":"Konnichiwa","Gracias":"Arigatou","Adios":"Sayounara","Denada":"Douitashimashite"}



###################################################################
#TEST DRIVER
if __name__ == "__main__":
    if True:
        print("Dictionary Spanish to Japanese")
        print(spanish_japanese_words)
        print()
        print()
        
        print("Hola",find_key(spanish_japanese_words,"Hola"))
        print("hola",find_key(spanish_japanese_words,"hola"))

        print()

        print("Gracias",find_key(spanish_japanese_words,"Gracias"))
        print("Denada", find_key(spanish_japanese_words,"Denada"))

        print()

        print("HolaGraciasDenada",find_key(spanish_japanese_words,"HolaGraciasDenada"))

