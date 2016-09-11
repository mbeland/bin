#!/bin/bash
iptables --flush
iptables --policy INPUT DROP
iptables --policy OUTPUT ACCEPT
iptables --policy FORWARD DROP
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -i tun+ -j ACCEPT
iptables -A OUTPUT -o tun+ -j ACCEPT
iptables -A INPUT -m tcp -p tcp --dport 22 -j fail2ban-SSH
iptables -A fail2ban-SSH -m tcp -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -m tcp -p tcp --dport 25 -j ACCEPT
iptables -A INPUT -m tcp -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -m tcp -p tcp --dport 110 -j ACCEPT
iptables -A INPUT -m tcp -p tcp --dport 143 -j ACCEPT
iptables -A INPUT -m tcp -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -m tcp -p tcp --dport 993 -j ACCEPT
iptables -A INPUT -m udp -p udp --dport 1194 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
