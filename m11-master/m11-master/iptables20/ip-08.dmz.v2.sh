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
iptables -P FORWARD DROP
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT

# obrir el localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# obrir la nostra ip
iptables -A INPUT -s 192.168.1.51 -j ACCEPT
iptables -A OUTPUT -d 192.168.1.51 -j ACCEPT


# Obrir NAT
iptables -t nat -A POSTROUTING -s 172.21.0.0/24 -o enp3s0f1 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.22.0.0/24 -o enp3s0f1 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 10.10.10.0/24 -o enp3s0f1 -j MASQUERADE

# (1) Xarxa A accedir al servei web DMZ
iptables -A FORWARD -p tcp --dport 80 -s 172.21.0.0/24 -d 10.10.10.2 -j ACCEPT
iptables -A FORWARD -p tcp --sport 80 -d 172.21.0.0/24 -s 10.10.10.2 -m state --state RELATED,ESTABLISHED -j ACCEPT

# (3) Permetre accés exterior al DNS
iptables -A FORWARD -p udp --dport 53 -o enp3s0f1 -j ACCEPT
iptables -A FORWARD -p udp --sport 53 -i enp3s0f1 -j ACCEPT

# (2) Xarxa B pot navegar (80) per internet (exterior)
iptables -A FORWARD -s 172.22.0.0/24 -o enp3s0f1 -p tcp --dport 80 -j ACCEPT
iptables -A FORWARD -p tcp --sport 80 -d 172.22.0.0/24 -i enp3s0f1 -m state --state RELATED,ESTABLISHED -j ACCEPT
