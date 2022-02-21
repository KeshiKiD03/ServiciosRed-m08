#!/usr/bin/python3
#-*- coding: utf-8-*-

# Escola del treball de Barcelona
# ASIX 2019-2020

# Christian Manalo
# isx9565961
# 11/5/2020

# Versió: 1
# Description: Fes una funció que tradueixi una data en format numèric de la següent manera: 01/01/2010  --> 1 de gener de 2010

import dates
def translatedate_strdate(datastr):
    '''
    Tradueix la data de la seguent manera  01/01/2010  --> 1 de gener de 2010
    input: 1 str -->  format data DD/MM/YYYY
    output: 1 str --> format DD de MM de YYYY
    '''
    day = str(dates.get_dia(datastr))
    month_num = dates.get_mes(datastr)

    month = {
        1:'enero',
        2:'febrero',
        3:'marzo',
        4:'abril',
        5:'mayo',
        6:'junio',
        7:'julio',
        8:'agosto',
        9:'septiembre',
        10:'octubre',
        11:'noviembre',
        12:'diciembre'
    }
    year = str(dates.get_year(datastr))

    dataformatstr = day, "de", month[month_num], "de",year

    return ' '.join(dataformatstr)

# date = input()
# print(translatedate_strdate(date))

###################################################################
#TEST DRIVER

if __name__ == "__main__":
    if True:
        print("10/10/2010 --> ", translatedate_strdate("10/10/2010"))
        print("22/12/2012 --> ", translatedate_strdate("22/12/2012"))

    