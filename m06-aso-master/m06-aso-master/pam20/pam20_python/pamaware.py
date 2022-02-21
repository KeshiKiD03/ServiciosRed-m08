#!/usr/bin/python
#-*- coding: utf-8-*-
import pam
p=pam.pam()
userName=input("Nom usuari: ")
userPasswd=input("Passwd: ")
p.authenticate(userName, userPasswd)
print('{} {}'.format(p.code,p.reason))
if p.code == 0:
    for i in range(1,11):
        print(i)
else:
    print("Error autenticacio")

