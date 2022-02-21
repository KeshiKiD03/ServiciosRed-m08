#! /bin/bash
ulimit -n 1024
/opt/docker/install.sh && echo "Install Ok"
/sbin/slapd -d0 -u ldap -h "ldap:/// ldaps:/// ldapi:///" && echo "slapd Ok"

