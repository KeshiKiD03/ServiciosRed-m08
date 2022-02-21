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
iptables -A INPUT -s 192.168.1.51 -j ACCEPT
iptables -A OUTPUT -d 192.168.1.51 -j ACCEPT

# NAT: 172.21.0.0/24 172.22.0.0/24 192.168.100.0/24
iptables -t nat -A POSTROUTING -s 172.21.0.0/24 -o enp5s0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 172.22.0.0/24 -o enp5s0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.100.0/24 -o enp5s0 -j MASQUERADE


#(1) NETA només pugui accedir el servei ssh i daytime
#iptables -A INPUT -s 172.21.0.0/24 -p tcp --dport 13 -j ACCEPT
#iptables -A INPUT -s 172.21.0.0/24 -p tcp --dport 22 -j ACCEPT
#iptables -A INPUT -s 172.21.0.0/24 -j REJECT

#(2) NETA només es pot accedir a l'exterior als serveis web,ssh i daytime(2013)
#iptables -A FORWARD -s 172.21.0.0/24 -p tcp --dport 80 -o enp5s0 -j ACCEPT
#iptables -A FORWARD -d 172.21.0.0/24 -p tcp --sport 80 -i enp5s0 -m state --state RELATED,ESTABLISHED -j ACCEPT

#iptables -A FORWARD -s 172.21.0.0/24 -p tcp --dport 22 -o enp5s0 -j ACCEPT
#iptables -A FORWARD -d 172.21.0.0/24 -p tcp --sport 22 -i enp5s0 -m state --state RELATED,ESTABLISHED -j ACCEPT

#iptables -A FORWARD -s 172.21.0.0/24 -p tcp --dport 13 -o enp5s0 -j ACCEPT
#iptables -A FORWARD -d 172.21.0.0/24 -p tcp --sport 13 -i enp5s0 -m state --state RELATED,ESTABLISHED -j ACCEPT

#iptables -A FORWARD -s 172.21.0.0/24 -o enp5s0 -j REJECT
#iptables -A FORWARD -d 172.21.0.0/24 -i enp5s0 -j REJECT

# (kaka) NETA només pot accedir els serveis que ofereix la DMZ 
#iptables -A FORWARD -s 172.21.0.0/24 -d 192.168.100.0/24 -j ACCEPT
#iptables -A FORWARD -d 172.21.0.0/24 -s 192.168.100.0/24 -j ACCEPT
#iptables -A FORWARD -s 172.21.0.0/24 -j REJECT
#iptables -A FORWARD -d 172.21.0.0/24 -j REJECT

# (3) NETA només pot accedir els serveis que ofereix la DMZ al servei web
#iptables -A FORWARD -s 172.21.0.0/24 -d 192.168.100.0/24 -p tcp --dport 80 -j ACCEPT
#iptables -A FORWARD -d 172.21.0.0/24 -s 192.168.100.0/24 -p tcp --sport 80  -m state --state RELATED,ESTABLISHED -j ACCEPT
#iptables -A FORWARD -s 172.21.0.0/24 -d 192.168.100.0/24 -j REJECT  
#iptables -A FORWARD -d 172.21.0.0/24 -s 192.168.100.0/24 -j REJECT

# (4) redirigir els ports perquè des de l'exterior es tingui accés a: 3001->hostA1:80, 3002->hostA2:13, 3003->hostB1:80,3004->hostB2:13

#iptables -A FORWARD -p tcp --dport 80 -d 172.21.0.2 -i enp5s0 -j ACCEPT
#iptables -A FORWARD -p tcp --sport 80 -s 172.21.0.2 -o enp5s0 -m state --state RELATED,ESTABLISHED -j ACCEPT
#iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 3001 -j DNAT --to 172.21.0.2:80
#iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 3002 -j DNAT --to 172.21.0.2:13
#iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 3003 -j DNAT --to 172.22.0.2:80
#iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 3004 -j DNAT --to 172.22.0.2:13

#(5) s'habiliten els ports 4001 en endavant per accedir per ssh als ports ssh de: hostA1(4001), hostA2(4002), hostB1(4003), hostB2(4004).
#iptables -A FORWARD -p tcp --dport 22 -d 172.21.0.2 -i enp5s0 -j ACCEPT
#iptables -A FORWARD -p tcp --sport 22 -s 172.21.0.2 -o enp5s0 -m state --state RELATED,ESTABLISHED -j ACCEPT

#iptables -A FORWARD -p tcp --dport 22 -d 172.22.0.2 -i enp5s0 -j ACCEPT
#iptables -A FORWARD -p tcp --sport 22 -s 172.22.0.2 -o enp5s0 -m state --state RELATED,ESTABLISHED -j ACCEPT

#iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 4001 -j DNAT --to 172.21.0.2:22
#iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 4002 -j DNAT --to 172.21.0.3:22
#iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 4003 -j DNAT --to 172.22.0.2:22
#iptables -t nat -A PREROUTING -i enp5s0 -p tcp --dport 4004 -j DNAT --to 172.22.0.3:22

#(6) s'habilita el port 4000 per accedir al port ssh del router/firewal si la ip origen és del host i26.
#iptables -A FORWARD -p tcp --dport 22 -d 172.21.0.2 -i enp5s0 -j ACCEPT
#iptables -A FORWARD -p tcp --sport 22 -s 172.21.0.2 -o enp5s0 -m state --state RELATED,ESTABLISHED -j ACCEPT
#iptables -t nat -A PREROUTING -s 10.200.243.205 -i enp5s0 -p tcp --dport 4000 -j DNAT --to 172.21.0.2:22

#(7) els hosts de la xarxaB tenen accés a tot arreu excepte a la xarxaA.
iptables -A FORWARD -s 172.22.0.0/24 -d 172.21.0.0/24 -j REJECT
iptables -A FORWARD -s 172.22.0.0/24 -j ACCEPT
