#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 11/5/2020

# Versió: 1
# Description: Fes una funció que retorni una llista amb totes les claus d'un diccionari.

def list_dict_key(dictionary):
    '''
    Retorna una llista dels claus del diccionari
    input: 1 dict
    output: 1 list
    '''
    new_list = []
    for i in dictionary.keys():
        new_list.append(i)
    return new_list
spanish_japanese_words = {"Hola":"Konnichiwa","Gracias":"Arigatou","Adios":"Sayounara","Denada":"Douitashimashite"}
japanese_spanish_words = {"Konnichiwa":"Hola","Arigatou":"Gracias","Sayounara":"Adios","Douitashimashite":"Denada"}

spanish_english_words = {"Hola":"Hello","Gracias":"Thank You","Adios":"Good Bye","Denada":"Your Welcome"}
english_spanish_words = {"Hello": "Hola", "Thank You":"Denada","Good Bye":"Adios","Your Welcome":"Denada"}

###################################################################
#TEST DRIVER
if __name__ == "__main__":
    if True:
        print("--Dictionary Spanish to English--")
        print(spanish_english_words)
        print()
        print("List Keys")
        print(list_dict_key(spanish_english_words))

        print("============================")

        print("--Dictionary English to Spanish--")
        print(english_spanish_words)
        print()
        print("List Keys")
        print(list_dict_key(english_spanish_words))

        print("============================")

        print("--Dictionary Spanish to Japanese--")
        print(spanish_japanese_words)
        print()
        print("List Keys")
        print(list_dict_key(spanish_japanese_words))

        print("============================")

        print("--Dictionary Japanese to Spanish--")
        print(japanese_spanish_words)
        print()
        print("List Keys")
        print(list_dict_key(japanese_spanish_words))

