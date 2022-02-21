#! /bin/bash
/opt/docker/install.sh && echo "Ok install"
/usr/sbin/httpd -DFOREGROUND && echo "httpd Ok"
