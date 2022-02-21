#! /bin/bash
ulimit -n 1024
bash /opt/docker/install.sh
/sbin/slapd -d0


