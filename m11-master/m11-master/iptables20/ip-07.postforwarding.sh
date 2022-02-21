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
#iptables -A INPUT -s 10.200.243.204 -j ACCEPT
#iptables -A OUTPUT -d 10.200.243.204 -j ACCEPT


iptables -A INPUT -s 172.200.20.1 -j ACCEPT
iptables -A OUTPUT -d 172.200.20.1 -j ACCEPT

# Fa nat de la xarxa interna: 172.19.0.0/16
iptables -t nat -A POSTROUTING -s 172.200.20.0/24 -o enp5s0 -j MASQUERADE

iptables -A FORWARD -j ACCEPT




# Permetre des de l'exterior accedir al servei 13 de A1 
# port forwarding
#iptables -t nat -A PREROUTING -p tcp --dport 5013 -j DNAT --to 172.19.0.2:13

# el forward ja està accept per defecte
#iptables -A FORWARD -p tcp --dport 13 -j DROP
#iptables -A FORWARD -p tcp --sport 13 -j DROP

# Permetre A1 de servidor daytime
#iptables -A FORWARD -p tcp --dport 13 -d 172.19.0.2 -j ACCEPT
#iptables -A FORWARD -p tcp --sport 13 -s 172.19.0.2 -d 0.0.0.0/0 -m state --state RELATED,ESTABLISHED -j ACCEPT


