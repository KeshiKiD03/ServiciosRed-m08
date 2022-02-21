#!/bin/bash
# Christian Manalo Mañibo - isx9565961
# Març 2020
# Escola Del Treball
# Biblioteca de funcions 02
# --------------------------------------
OK=0


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
      reserved_field=$(echo $line | cut -d: -f9)

      echo "Login: $login"
      echo "Encrypted password: $en_passwd"
      echo "Date of last password change: $date_pass_change"
      echo "Minimum password age: $min_pass_age"
      echo "Maximum password age: $max_pass_age"
      echo "Password warning period: $pass_warning_period"
      echo "Password inactivity period: $pass_inac_period"
      echo "Account expiration date: $account_exp_date"
      echo "Reserved field: $reserved_field"
      echo "--------------"
    fi
  done
  return $OK
}

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
      reserved_field=$(echo $line | cut -d: -f9)

      echo "Login: $login"
      echo "Encrypted password: $en_passwd"
      echo "Date of last password change: $date_pass_change"
      echo "Minimum password age: $min_pass_age"
      echo "Maximum password age: $max_pass_age"
      echo "Password warning period: $pass_warning_period"
      echo "Password inactivity period: $pass_inac_period"
      echo "Account expiration date: $account_exp_date"
      echo "Reserved field: $reserved_field"
      echo "--------------"
    fi
  done
  return $OK
}

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
  reserved_field=$(echo $line | cut -d: -f9)

  echo "Login: $login"
  echo "Encrypted password: $en_passwd"
  echo "Date of last password change: $date_pass_change"
  echo "Minimum password age: $min_pass_age"
  echo "Maximum password age: $max_pass_age"
  echo "Password warning period: $pass_warning_period"
  echo "Password inactivity period: $pass_inac_period"
  echo "Account expiration date: $account_exp_date"
  echo "Reserved field: $reserved_field"

  return $OK
}

function filterGidDefault(){
  ERR_NARGS=1
  ERR_ARGS=2
  if [ $# -gt 1 ]; then
     echo "Error: Nº d'arguments incorrectes"
     echo "Usage: $0 file"
     return $ERR_NARGS
  fi

  fileIn=/dev/stdin
  if [ $# -eq 1 ]; then
    if ! [ -f "$1" ]; then
      echo "Error: $1 no es un regular file"
      echo "Usage: $0 file"
    fi
    fileIn=$1
  fi
  while read -r line; do
    gid=$(echo $line | cut -d: -f4)
    if [ $gid -ge 500 ]; then
       echo $line | cut -d: -f1,3,4,6
    fi
  done < $fileIn
}



function filterGid(){
  ERR_NARGS=1
  ERR_ARGS=2
  if [ $# -eq 0 ] ; then
    echo "Error: Nº arguments incorrectes" >> /dev/stderr
    echo "Usage: $0 file" >>  /dev/stderr
    return $ERR_NARGS
  fi

  if ! [ -f $1 ]; then
    echo "Error: $1 no es un regular file"
    echo "Usage: $0 file"
    return $ERR_ARGS
  fi

  fileIn=$1
  while read -r line; do
    gid=$(echo $line | cut -d: -f4)
    if [ $gid -ge 500 ]; then
      echo $line | cut -d: -f1,3,4,6
    fi
  done < $fileIn
}




function numfileDefault(){
  ERR_NARGS=1
  ERR_ARGS=2
  if [ $# -gt 1 ]; then
    echo "Error: Nº arguments incorrectes" >> /dev/stderr
    echo "Usage: $0 file" >> /dev/stderr
    return $ERR_NARGS
  fi
  
  fileIn=/dev/stdin
  if [ $# -eq 1 ]; then
    if ! [ -f "$1" ]; then
      echo "Error: $1 no és un fitxer"
      echo "Usage: $0 file"
      return $ERR_ARGS
    fi
    fileIn=$1
  fi

  num=0
  while read -r line; do
    ((num++))
    echo "$num: $line"
  done < $fileIn
  return $OK

}
								    
function numfile(){
  ERR_NARGS=1
  ERR_ARGS=2
  if [ $# -ne 1 ]; then
    echo "Error: Nº arguments incorrectes" >> /dev/stderr
    echo "Usage: $0 file" >> /dev/stderr
    return $ERR_NARGS
  fi

  if ! [ -f $1 ]; then
    echo "Error: $1 no es valid" >> /dev/stderr
    echo "Usage: $0 file" >> /dev/stderr
    return $ERR_ARGS
  fi
  
  fileIn=$1
  num=0
  while read -r line; do
    ((num++))
    echo "$num: $line"
  done < $fileIn
  return $OK
}



function numStdin(){
  num=0
  while read -r line; do
    ((num++))
    echo "$num: $line"
  done
  return $OK
}
