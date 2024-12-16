#!/bin/bash

if [ $# -ne 3 ]; then
  echo "Usage: $0 <source_file> <username> <ip_address>"
  exit 1
fi

SOURCE_FILE=$1
USERNAME=$2
IP_ADDRESS=$3

REMOTE_DIR="/home/$USERNAME/"

echo "Menyalin file $SOURCE_FILE ke $USERNAME@$IP_ADDRESS:$REMOTE_DIR"
scp "$SOURCE_FILE" "$USERNAME@$IP_ADDRESS:$REMOTE_DIR"

if [ $? -eq 0 ]; then
  echo "File berhasil disalin ke $USERNAME@$IP_ADDRESS:$REMOTE_DIR"
else
  echo "Gagal menyalin file ke $USERNAME@$IP_ADDRESS:$REMOTE_DIR"
fi
