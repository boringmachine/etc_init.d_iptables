#!/bin/bash
iptables -F
iptables -X
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP
iptables -N LOOPBACK_IN
iptables -N LOOPBACK_OUT
iptables -N UDP_OUT
iptables -N WEB_BROWSING_OUT
iptables -N LOG_REJECT
iptables -A LOG_REJECT -j LOG --log-level warning --log-prefix "rejected" -m limit
iptables -A LOG_REJECT -j REJECT
iptables -A FORWARD -j REJECT
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -j LOOPBACK_IN
iptables -A OUTPUT -j LOOPBACK_OUT
iptables -A UDP_OUT -p udp -m udp --dport 123 -j ACCEPT
iptables -A UDP_OUT -p udp -m udp --dport 68 -j ACCEPT
iptables -A UDP_OUT -j WEB_BROWSING_OUT
iptables -A LOOPBACK_IN -i lo -j ACCEPT
iptables -A LOOPBACK_IN -j LOG_REJECT
iptables -A LOOPBACK_OUT -o lo -j ACCEPT
iptables -A LOOPBACK_OUT -j UDP_OUT
iptables -A WEB_BROWSING_OUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A WEB_BROWSING_OUT -p udp -m udp --dport 53 -j ACCEPT
iptables -A WEB_BROWSING_OUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A WEB_BROWSING_OUT -j LOG_REJECT
iptables-save > /etc/sysconfig/iptables
