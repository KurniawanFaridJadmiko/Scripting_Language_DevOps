#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <unique_string_of_public_key> <username>"
  exit 1
fi

UNIQUE_STRING=$1
USERNAME=$2

AUTHORIZED_KEYS_FILE="/home/$USERNAME/.ssh/authorized_keys"

if [ ! -f "$AUTHORIZED_KEYS_FILE" ]; then
  echo "Error: File '$AUTHORIZED_KEYS_FILE' tidak ditemukan!"
  exit 2
fi

if grep -q "$UNIQUE_STRING" "$AUTHORIZED_KEYS_FILE"; then
  sed -i "/$UNIQUE_STRING/d" "$AUTHORIZED_KEYS_FILE"
  echo "Public key yang mengandung string '$UNIQUE_STRING' telah dihapus dari $AUTHORIZED_KEYS_FILE"
else
  echo "Public key dengan string unik '$UNIQUE_STRING' tidak ditemukan di $AUTHORIZED_KEYS_FILE"
fi
