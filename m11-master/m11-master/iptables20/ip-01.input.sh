#! /bin/bash
# @edt ASIX M11-SAD Curs 2018-2019
# iptables

#echo 1 > /proc/sys/net/ipv4/ip_forward

# Regles flush
iptables -F
iptables -X
iptables -Z
iptables -t nat -F

# Polítiques per defecte: 
# Tot es permet
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

# obrir el localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# obrir la nostra ip
iptables -A INPUT -s 10.200.243.204 -j ACCEPT
iptables -A OUTPUT -d 10.200.243.204 -j ACCEPT

# --------------------------------------
# Exemple de regles input
# --------------------------------------

# Port 80 obert a tothom
iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Port 2013 xapat a tothom: reject / drop
iptables -A INPUT -p tcp --dport 2013 -j REJECT

# Filtrar qui es pot connectar
# port 3013 xapat per a un host concret i obert a tothom
iptables -A INPUT -p tcp --dport 3013 -s 10.200.243.201 -j REJECT
iptables -A INPUT -p tcp --dport 3013 -j ACCEPT

# Filtrar qui es pot connectar
# port 4013 xapat per a tothom i obert a un host concret
iptables -A INPUT -p tcp --dport 4013 -s 10.200.243.201 -j ACCEPT
iptables -A INPUT -p tcp --dport 4013 -j REJECT

# 5013 tancat a tothom, obert a xarxa n2j i tancat a un host
iptables -A INPUT -p tcp --dport 5013 -s 10.200.243.201 -j REJECT
iptables -A INPUT -p tcp --dport 5013 -s 10.200.243.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 5013 -j REJECT

# 6013 obert a tothom, tancat a xarxa n2j i obert a un host
iptables -A INPUT -p tcp --dport 6013 -s 10.200.243.201 -j ACCEPT
iptables -A INPUT -p tcp --dport 6013 -s 10.200.243.0/24 -j REJECT
iptables -A INPUT -p tcp --dport 6013 -j ACCEPT

# xapar tots els ports del 3000:8000
#iptables -A INPUT -p tcp --dport 3000:8000 -j REJECT

# barrera final de ports (ull! quedar tancat)
#iptables -A INPUT -p tcp --dport 1:1024 -j RºEJECT
