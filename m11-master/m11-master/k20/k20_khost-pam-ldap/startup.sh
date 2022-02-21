#! /bin/bash

/opt/docker/install.sh && echo "Ok install"

# Engegar dimonis necesaris
/sbin/nscd && echo "Ok nscd"
/sbin/nslcd && echo "Ok nslcd"



/bin/bash
