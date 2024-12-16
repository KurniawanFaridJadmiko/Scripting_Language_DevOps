#!/bin/bash

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <public_key_file> <username> <server_ip_address>"
  exit 1
fi

PUBLIC_KEY_FILE=$1
USERNAME=$2
SERVER_IP=$3

if [ ! -f "$PUBLIC_KEY_FILE" ]; then
  echo "Error: Public key file '$PUBLIC_KEY_FILE' does not exist."
  exit 1
fi

echo "Copying public key to remote server..."
ssh-copy-id -i "$PUBLIC_KEY_FILE" "$USERNAME@$SERVER_IP"

if [ $? -eq 0 ]; then
  echo "Public key successfully copied to $USERNAME@$SERVER_IP."
else
  echo "Error: Failed to copy public key to $USERNAME@$SERVER_IP."
  exit 1
fi
