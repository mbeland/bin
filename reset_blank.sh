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
iptables --policy INPUT ACCEPT
iptables --policy OUTPUT ACCEPT
iptables --policy FORWARD ACCEPT
iptables -I INPUT 1 -m tcp -p tcp --dport 22 -j fail2ban-SSH
iptables -I fail2ban-SSH -m tcp -p tcp --dport 22 -j ACCEPT
iptables -I OUTPUT -m tcp -p tcp --sport 22 -j ACCEPT

