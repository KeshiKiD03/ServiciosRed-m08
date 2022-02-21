#! /bin/bash
# Install ldap server

mkdir /etc/openldap/certs
cp /opt/docker/cacert.pem /etc/openldap/certs/.
cp /opt/docker/servercert.pem /etc/openldap/certs/.
cp /opt/docker/serverkey.pem /etc/openldap/certs/.

rm -rf /etc/openldap/slapd.d/*
rm -rf /var/lib/ldap/*
cp /opt/docker/DB_CONFIG /var/lib/ldap/.
slaptest -f /opt/docker/slapd.conf -F /etc/openldap/slapd.d
slapadd -F /etc/openldap/slapd.d -l edt.org.ldif
chown -R ldap.ldap /etc/openldap/slapd.d
chown -R ldap.ldap /var/lib/ldap
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf

