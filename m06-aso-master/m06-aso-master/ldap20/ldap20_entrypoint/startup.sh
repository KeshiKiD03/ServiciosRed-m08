#! /bin/bash
ulimit -n 1024

function initdbedt(){
  rm -rf /etc/openldap/slapd.d/*
  rm -rf /var/lib/ldap/*
  cp /opt/docker/DB_CONFIG /var/lib/ldap/.
  slaptest -f /opt/docker/slapd.conf -F /etc/openldap/slapd.d
  slapadd -F /etc/openldap/slapd.d -l edt.org.ldif
  chown -R ldap.ldap /etc/openldap/slapd.d
  chown -R ldap.ldap /var/lib/ldap
  cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
  /sbin/slapd -h "ldap:// ldaps:// ldapi://" -d0
}

function start(){
  /sbin/slapd -h "ldap:// ldaps:// ldapi://" -d0
}
function initdb(){
  rm -rf /etc/openldap/slapd.d/*
  rm -rf /var/lib/ldap/*
  cp /opt/docker/DB_CONFIG /var/lib/ldap/.
  slaptest -f /opt/docker/slapd.conf -F /etc/openldap/slapd.d
  chown -R ldap.ldap /etc/openldap/slapd.d
  chown -R ldap.ldap /var/lib/ldap
  cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
  /sbin/slapd -h "ldap:// ldaps:// ldapi://" -d0 
}


case $1 in
  initdbedt)
    echo "initdbedt"
    initdbedt;;
  start)
    echo "start"
    start;;
  initdb)
    echo "initdb"
    initdb;;
  *)
    echo "altre"
    start;;
esac



#bash /opt/docker/install.sh
#/sbin/slapd -d0 ldap:// ldaps:// ldapi://


