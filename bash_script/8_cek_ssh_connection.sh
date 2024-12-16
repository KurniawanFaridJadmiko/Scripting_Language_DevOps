#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <username> <server_ip_address>"
  exit 1
fi

USERNAME=$1
SERVER_IP=$2

echo "Checking SSH connection to $USERNAME@$SERVER_IP..."
ssh -o BatchMode=yes -o ConnectTimeout=5 "$USERNAME@$SERVER_IP" exit

if [ $? -eq 0 ]; then
  echo "SSH connection to $USERNAME@$SERVER_IP is successful."
else
  echo "Error: SSH connection to $USERNAME@$SERVER_IP failed."
  exit 1
fi
