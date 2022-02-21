#!/bin/bash
# Kserver
# @edt ASIX M11-SAD Curs 2020-2021


cp /opt/docker/krb5.conf /etc/krb5.conf
cp /opt/docker/kdc.conf /var/kerberos/krb5kdc/kdc.conf
cp /opt/docker/kadm5.acl /var/kerberos/krb5kdc/kadm5.acl

kdb5_util create -s -P masterkey

# Usuaris que s'utilitzaran amb LDAP de IP
for user in anna pere marta jordi pau user{01..10}
do
	kadmin.local -q "addprinc -pw k$user $user"
done

kadmin.local -q "addprinc -pw kmarta marta/admin"
kadmin.local -q "addprinc -pw kpere pere/admin"
kadmin.local -q "addprinc -pw kpau pau/admin"
kadmin.local -q "addprinc -pw ksuper super"
kadmin.local -q "addprinc -pw kadmin admin"


# usuaris que s'utilitzaran amb /etc/passwd de IP
for user in kuser{01..06}
do
  kadmin.local -q "addprinc -pw $user $user"
done

kadmin.local -q "addprinc -randkey host/sshd.edt.org"
