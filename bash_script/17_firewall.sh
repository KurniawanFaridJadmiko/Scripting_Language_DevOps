#!/bin/bash

echo "Setting default policies to drop incoming connections and allow outgoing ones..."

iptables -P INPUT DROP

iptables -P OUTPUT ACCEPT

iptables -P FORWARD DROP

iptables -F

echo "Allowing incoming connections on ports 22 (SSH), 80 (HTTP), and 443 (HTTPS)..."
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

echo "Firewall rules applied:"
iptables -L
