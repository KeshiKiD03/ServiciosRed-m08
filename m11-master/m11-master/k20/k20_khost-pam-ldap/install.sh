#! /bin/bash
# Kserver
# @edt ASIX M11-SAD Curs 2020-2021


cp /opt/docker/krb5.conf /etc/krb5.conf
bash /opt/docker/auth.sh
cp /opt/docker/ssh_config /etc/sshd/ssh_config

#cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
#cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
#cp /opt/docker/nslcd.conf /etc/nslcd.conf
#cp /opt/docker/system-auth /etc/pam.d/system-auth



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
 

