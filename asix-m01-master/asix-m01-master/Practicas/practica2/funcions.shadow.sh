#!/bin/bash
# @edt ASIX M01 - ISO
# Christian Manalo Mañibo - isx9565961
# Març 2020
# funcions.shadow.sh
# ---------------------------------------



OK=0

# 28.showShadowIn < login
# Mostrar els camps del shadow de cada urusri rebut per l’entrada estàndard. Cada
# línia de l’entrada estàndard correspon a un login. Verificar que cada un dels lògins
# existeix.
function showShadowIn(){
  ERR_NOLOGIN=1
  
  while read -r login; do 

  line=$(egrep ^$login: /etc/shadow) 2> /dev/null 
    if [ -z "$line" ]; then
      echo "Error: $login No existeix" >> /dev/stderr
      echo "Usage: $0 login" >> /dev/stderr
      echo "--------------"

  
    else
      en_passwd=$(echo $line | cut -d: -f2)
      date_pass_change=$(echo $line | cut -d: -f3)
      min_pass_age=$(echo $line | cut -d: -f4)
      max_pass_age=$(echo $line | cut -d: -f5)
      pass_warning_period=$(echo $line | cut -d: -f6)
      pass_inac_period=$(echo $line | cut -d: -f7)
      account_exp_date=$(echo $line | cut -d: -f8)

      echo "Login: $login"
      echo "Encrypted password: $en_passwd"
      echo "Date of last password change: $date_pass_change"
      echo "Minimum password age: $min_pass_age"
      echo "Maximum password age: $max_pass_age"
      echo "Password warning period: $pass_warning_period"
      echo "Password inactivity period: $pass_inac_period"
      echo "Account expiration date: $account_exp_date"
      echo "--------------"
    fi
  done
  return $OK
}

# 27.showShadowList login[...]
# Mostrar per a cada lògin les dades del seu shadow. Validar que es rep almenys un
# argument i que existeix cada un dels lògins.

function showShadowList(){
  ERR_NARGS=1
  ERR_NOLOGIN=2
  if [ $# -eq 0 ]; then
    echo "Error: Nº arguments incorrectes" >> /dev/stderr
    echo "Usage: $0 login" >> /dev/stderr
    return $ERR_NARGS
  fi

  
  for login in $*; do 
  line=$(egrep ^$login: /etc/shadow) 2> /dev/null 
    if [ -z "$line" ]; then
      echo "Error: $login No existeix" >> /dev/stderr
      echo "Usage: $0 login" >> /dev/stderr
      echo "--------------"

  
    else
      en_passwd=$(echo $line | cut -d: -f2)
      date_pass_change=$(echo $line | cut -d: -f3)
      min_pass_age=$(echo $line | cut -d: -f4)
      max_pass_age=$(echo $line | cut -d: -f5)
      pass_warning_period=$(echo $line | cut -d: -f6)
      pass_inac_period=$(echo $line | cut -d: -f7)
      account_exp_date=$(echo $line | cut -d: -f8)

      echo "Login: $login"
      echo "Encrypted password: $en_passwd"
      echo "Date of last password change: $date_pass_change"
      echo "Minimum password age: $min_pass_age"
      echo "Maximum password age: $max_pass_age"
      echo "Password warning period: $pass_warning_period"
      echo "Password inactivity period: $pass_inac_period"
      echo "Account expiration date: $account_exp_date"
      echo "--------------"
    fi
  done
  return $OK
}

# 26.showShadow login
# Donat un login mostrar els camps del /etc/shadow d’aquest login, mostrant camp
# a camp amb una etiqueta i el valor del camp. Validar que es rep un argument i
# que el login existeix.

function showShadow(){
  ERR_NARGS=1
  ERR_NOLOGIN=2
  if [ $# -ne 1 ]; then
    echo "Error: Nº arguments incorrectes" >> /dev/stderr
    echo "Usage: $0 login" >> /dev/stderr
    return $ERR_NARGS
  fi

  login=$1
  line=$(egrep ^$login: /etc/shadow) 2> /dev/null 
  if [ -z "$line" ]; then
    echo "Error: $login No existeix" >> /dev/stderr
    echo "Usage: $0 login" >> /dev/stderr
    return $ERR_NOLOGIN
  fi

  en_passwd=$(echo $line | cut -d: -f2)
  date_pass_change=$(echo $line | cut -d: -f3)
  min_pass_age=$(echo $line | cut -d: -f4)
  max_pass_age=$(echo $line | cut -d: -f5)
  pass_warning_period=$(echo $line | cut -d: -f6)
  pass_inac_period=$(echo $line | cut -d: -f7)
  account_exp_date=$(echo $line | cut -d: -f8)

  echo "Login: $login"
  echo "Encrypted password: $en_passwd"
  echo "Date of last password change: $date_pass_change"
  echo "Minimum password age: $min_pass_age"
  echo "Maximum password age: $max_pass_age"
  echo "Password warning period: $pass_warning_period"
  echo "Password inactivity period: $pass_inac_period"
  echo "Account expiration date: $account_exp_date"

  return $OK
}