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

iptables -A INPUT -s 172.200.20.1 -j ACCEPT
iptables -A OUTPUT -d 172.200.20.1 -j ACCEPT

# Fa nat de la xarxa interna: 172.19.0.0/16
iptables -t nat -A POSTROUTING -s 172.200.20.0/24 -o enp5s0 -j MASQUERADE

# FORWARD 5-6
iptables -A FORWARD -p tcp --dport 80 -s 172.200.20.2 -j REJECT 
iptables -A FORWARD -p tcp --dport 80 -s 172.200.20.3 -j ACCEPT
iptables -A FORWARD -j ACCEPT

# Input  no es permet  que els hosts exteriors  accedeixin al daytime del firewall
# Tancar l'access del host B al servei daytime del router
iptables -A INPUT -p tcp --dport 13 -s 172.200.20.3 -j REJECT
iptables -A INPUT -p tcp --dport 13 -s 172.200.20.0/24 -j ACCEPT
#iptables -A INPUT -p tcp --dport 13 -s 0.0.0.0/0 -j DROP
iptables -A INPUT -s 0.0.0.0/0 -p tcp --dport 13 -j REJECT

# OUTPUT des del router/firewall no es permet access a cap  servei daytime al exterior
iptables -A OUTPUT -p tcp --dport 13 -d 172.200.20.0/24 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 13 -d 0.0.0.0/0 -j REJECT

# Port Forwarding
iptables -t nat -A PREROUTING -p tcp --dport 2022 -j DNAT --to 172.200.20.2:22
iptables -t nat -A PREROUTING -p tcp --dport 2013 -j DNAT --to 172.200.20.3:13
iptables -t nat -A PREROUTING -p tcp --dport 2080 -j DNAT --to 172.200.20.2:80

