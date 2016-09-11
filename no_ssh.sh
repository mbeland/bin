#!/bin/bash
iptables --flush
iptables -X AS0_ACCEPT
iptables -X AS0_IN
iptables -X AS0_IN_POST
iptables -X AS0_IN_PRE
iptables -X AS0_OUT
iptables -X AS0_OUT_S2C
iptables -X AS0_OUT_LOCAL
iptables -X AS0_WEBACCEPT
iptables -X VZ_FORWARD
iptables -X VZ_INPUT
iptables -X VZ_OUTPUT
iptables -X fail2ban-SSH
iptables --policy INPUT DROP 
iptables --policy OUTPUT DROP
iptables --policy FORWARD DROP
iptables -A INPUT -m tcp -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -m tcp -p tcp --sport 22 -j ACCEPT
iptables -A INPUT -i venet0 -m state --state NEW -p udp --dport 1194 -j ACCEPT
iptables -A INPUT -i tun+ -j ACCEPT
iptables -A FORWARD -i tun+ -o venet0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i venet0 -o tun+ -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -A POSTROUTING -s 10.121.26.0/24 -o venet0 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.27.0/24 -o venet0 -j MASQUERADE

