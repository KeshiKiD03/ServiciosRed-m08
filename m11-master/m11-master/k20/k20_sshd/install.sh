#! /bin/bash
# Kserver
# @edt ASIX M11-SAD Curs 2020-2021


cp /opt/docker/krb5.conf /etc/krb5.conf
cp /opt/docker/sshd_config /etc/ssh/sshd_config
cp /opt/docker/ssh_config /etc/ssh/ssh_config

bash /opt/docker/auth.sh
/usr/bin/ssh-keygen -A

kadmin -p admin -w kadmin -q "ktadd -k /etc/krb5.keytab host/sshd.edt.org"


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
 

