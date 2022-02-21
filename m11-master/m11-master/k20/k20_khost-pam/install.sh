#! /bin/bash
# Kserver
# @edt ASIX M11-SAD Curs 2020-2021


cp /opt/docker/krb5.conf /etc/krb5.conf
#dnf install pam_krb5-2.4.8-6.el7.x86_64.rpm

# crear usuaris local01--03 (IP+AP)
for user in local01 local02 local03
do
  useradd $user
  echo -e "$user\n$user\n" | passwd --stdin $user  
done	

# crear usuaris kuser01.. (IP) el passwd està a kerberos
for user in kuser{01..06}
do
  useradd $user
done
 
#copiar system-auth

cp /opt/docker/system-auth /etc/pam.d/system-auth


