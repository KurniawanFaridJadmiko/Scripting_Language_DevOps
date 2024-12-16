#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
  echo "Script ini harus dijalankan dengan hak akses root!" 
  exit 1
fi

echo "Mengonfigurasi jaringan dengan netplan untuk interface eth0..."

cat <<EOL > /etc/netplan/01-netcfg.yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: false
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
EOL

echo "Menerapkan konfigurasi jaringan..."
netplan apply

echo "Status konfigurasi jaringan:"
ip addr show eth0
