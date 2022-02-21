#!/bin/bash
# ASX-M01
# Christian Manalo - isx9565961
# Gener 2020
# exemple if
#   $prog edat
#-------------------------------
# validar argument
if [ $# -ne 1 ]; then
	echo "Error: #args incorrectes"
	echo "Usage: $0 edat"
	exit 1
fi
# xixa
edat=$1
if [ $edat -ge 18 ]; then
	echo "edat $edat es major d'edat"
fi
exit 0
