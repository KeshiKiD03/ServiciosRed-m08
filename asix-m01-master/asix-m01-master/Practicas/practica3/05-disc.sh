#!/bin/bash
# Escola del Treball
# Christian Manalo - isx9565961
# 05_disc.sh
#-------------------------------------------

# Funcions Size 

# 1 : Donat un login calcular l'ocupació del home de l'usuari. Cal obtenir el home del /etc/passwd

function fsize(){
  user=$1
  home_user=$(grep "^$user:" /etc/passwd | cut -d: -f6)
  du -s $home_user 
  return 0
}

# 2 : loginargs​ Aquesta funció rep logins i per a cada login es mostra l'ocupació de
# disc del home de l'usuari usant fsize. Verificar que es rep almenys un argument.
# Per a cada argument verificar si és un login vàlid, si no generra una traça d'error.

function loginargs(){
  ERR_NARGS=1


  if [ $# -lt 1 ]; then
    echo "Error:Num args incorrecte" 2> /dev/stderr 
    echo "Usage:loginargs login[...]" 2> /dev/stderr
    return $ERR_NARGS
  fi

  logins=$*
  for user in $logins; do
    line=$(egrep "^$user:" /etc/passwd ) 2> /dev/null
    if [ -z "$line" ]; then
      echo "==$user:=="
      echo "Error: Login invalid" 2> /dev/stderr
      echo "Usage:loginargs login[...]" 2> /dev/stderr
    else
      echo "==$user:=="
      fsize $user
    fi
  done
  return 0
}

# 3 : loginfile​ Rep com a argument un nom de fitxer que conté un lògin per línia.
# Mostrar l'ocupació de disc de cada usuari usant fsize. Verificar que es rep un
# argument i que és un regular file.

function loginfile(){
  ERR_NARGS=1
  ERR_FILE=2


  if ! [ $# -eq 1 ]; then
    echo "Error:Num args incorrecte" 2> /dev/stderr 
    echo "Usage:loginfile file" 2> /dev/stderr
    return $ERR_NARGS
  fi 

  if ! [ -f $1 ]; then
    echo "Error: $1 regular file invalid" 2> /dev/stderr
    echo "Usage: loginfile file" 2> /dev/stderr
    return $ERR_FILE
  fi

  fileIn=$1
  while read -r user; do
    line=$(egrep "^$user:" /etc/passwd) 2> /dev/null
    if [ -z "$line" ]; then
      echo "==$user:=="
      echo "Error: Login invalid" 2> /dev/stderr
      echo "Usage: loginfile file" 2> /dev/stderr
    else
      echo "==$user:=="
      fsize $user
    fi
  done < $fileIn
}
# 4 : loginboth​ Rep com a argument un file o res (en aquest cas es processa stdin).
# El fitxer o stdin contenen un lògin per línia. Mostrar l'ocupació de disc del home de
# l'usuari. Verificar els arguments rebuts. verificar per cada login rebut que és vàlid.

function loginboth(){
  ERR_NARGS=1
  ERR_FILE=2

  
  if [ $# -gt 1 ]; then
    echo "Error:Num args incorrecte" 2> /dev/stderr 
    echo "Usage:loginboth [file]" 2> /dev/stderr
    return $ERR_NARGS
  fi

  fileIn=/dev/stdin

  if [ $# -eq 1 ]; then
    if ! [ -f $1 ]; then
      echo "Error: $1 regular file invalid" 2> /dev/stderr
      echo "Usage:loginboth [file]" 2> /dev/stderr
      return $ERR_FILE
     
    else 
      fileIn=$1
    fi
  else 
    fileIn=/dev/stdin
  fi

  while read -r user; do
    line=$(egrep "^$user:" /etc/passwd ) 2> /dev/null
    if [ -z "$line" ]; then
      echo "==$user:=="
      echo "Error: Login invalid" 2> /dev/stderr
      echo "Usage: loginfile file" 2> /dev/stderr
    else
      echo "==$user:=="
      fsize $user
    fi
  done < $fileIn
  return 0
}

# 5 : grepgid​ Donat un GID com a argument, llistar els logins dels usuaris que
# petanyen a aquest grup com a grup principal. Verificar que es rep un argument i
# que és un GID vàlid.

function grepgid(){

  ERR_NARGS=1
  ERR_GID=2

  if [ $# -ne 1 ]; then
    echo "Error:Num args incorrecte" 2> /dev/stderr 
    echo "Usage:grepgid gid" 2> /dev/stderr
    return $ERR_NARGS
  fi


  line=$(egrep "^[^:]*:[^:]*:[^:]*:$1:" /etc/passwd) 
  if [ -z "$line" ]; then
     echo "Error: gid invalid" 2> /dev/stderr
     echo "Usage: grepgid gid" 2> /dev/stderr
     return $ERR_GID
  fi

  gid=$1
  echo "$line" | cut -d: -f1
  return 0
}

# 6 : gidsize​ Donat un GID com a argument, mostrar per a cada usuari que pertany
# a aquest grup l'ocupació de disc del seu home. Verificar que es rep un argument i
# que és un gID vàlid.

function gidsize(){
  ERR_NARGS=1
  ERR_GID=2

  if [ $# -ne 1 ]; then
    echo "Error:Num args incorrecte" 2> /dev/stderr 
    echo "Usage:gidsize gid" 2> /dev/stderr
    return $ERR_NARGS
  fi

  line=$(egrep "^[^:]*:[^:]*:[^:]*:$1:" /etc/passwd) 
  if [ -z "$line" ]; then
     echo "Error: gid invalid" 2> /dev/stderr
     echo "Usage: gidsize gid" 2> /dev/stderr
     return $ERR_GID
  fi

  gid=$1
  userlist=$(grepgid $gid)
  for user in $userlist; do
    fsize $user 
  done
  return 0
}

# 7 : allgidsize​ Llistar de tots els GID del sistema (en ordre creixent) l'ocupació del
# home dels usuaris que hi pertanyen.

function allgidsize(){

  gidlist=$(cut -d: -f4 /etc/passwd | sort -n)
  for gid in $gidlist; do
    echo "---$gid---"
    gidsize $gid
  done
  return 0
}

# 8 : allgroupsize​ Llistar totes les línies de /etc/group i per cada llínia llistar
#l'ocupació del home dels usuaris que hi pertanyen. Ampliar filtrant només els grups
# del 0 al 100.

function allgroupsize(){
  
  gidlist=$(cut -d: -f3 /etc/group)
  for gid in $gidlist;do
    if [ $gid -ge 0 -a $gid -le 100 ]; then
      echo "---$gid---"
      gidsize $gid
    fi
  done

  return 0
}


# EXERCICIS FDISK/BLKID/FSTAB

# 9 : Donat un fstype llista el device i el mountpoint (per odre de device) de
# les entrades de fstab d'quest fstype.

function fstype(){

  fstype=$1
  normalitzat=$(egrep -v "^#|^$" /etc/fstab | tr -s [:blank:] ':')
  echo "$normalitzat" | grep "^[^:]*:[^:]*:$fstype:" | cut -d: -f1,2 | sort | tr ':' '\t'
  return 0
}

# 10 : allfstype​ LLista per a cada fstype que existeix al fstab (per ordre lexicogràfic)
# les entrades d'quest tipus. Llistar tabuladament el device i el mountpoint.

function allfstype(){

  normalitzat=$(egrep -v "^#|^$" /etc/fstab | tr -s [:blank:] ':')

  fstypelist=$(echo "$normalitzat" | cut -d: -f3 | sort -u)

  for tipus in $fstypelist; do
    fstype $tipus
  done
  return 0

}

# 11 : allfstypeif​ LLista per a cada fstype que existeix al fstab (per ordre lexicogràfic)
# les entrades d'quest tipus. Llistar tabuladament el device i el mountpoint. Es rep un
# valor numèric d'argument que indica el numéro mínim d'entrades d'aquest fstype
# que hi ha d'haver per sortir al llistat.

function allfstypeif(){

  min=$1
  normalitzat=$(egrep -v "^#|^$" /etc/fstab | tr -s [:blank:] ':')
  lines=$(echo "$normalitzat" | wc -l)

  if [ "$lines" -lt "$min" ]; then
    echo "Error: $min Supera el numero minim d'entrades." 2> /dev/stderr
    echo "Usage: allfstypeif min." 2> /dev/stderr
    return 1
  fi

  allfstype
  return 0
}
