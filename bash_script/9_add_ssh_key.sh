#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <public_key_file> <username>"
  exit 1
fi

PUBLIC_KEY_FILE=$1
USERNAME=$2

if [ ! -f "$PUBLIC_KEY_FILE" ]; then
  echo "Error: File '$PUBLIC_KEY_FILE' tidak ditemukan!"
  exit 2
fi

USER_SSH_DIR="/home/$USERNAME/.ssh"

if [ ! -d "$USER_SSH_DIR" ]; then
  echo "Direktori ~/.ssh tidak ditemukan untuk user '$USERNAME'. Membuat direktori..."
  mkdir -p "$USER_SSH_DIR"
  chown "$USERNAME:$USERNAME" "$USER_SSH_DIR"
  chmod 700 "$USER_SSH_DIR"
fi

AUTHORIZED_KEYS_FILE="$USER_SSH_DIR/authorized_keys"

if ! grep -q "$(cat $PUBLIC_KEY_FILE)" "$AUTHORIZED_KEYS_FILE"; then
  cat "$PUBLIC_KEY_FILE" >> "$AUTHORIZED_KEYS_FILE"
  chown "$USERNAME:$USERNAME" "$AUTHORIZED_KEYS_FILE"
  chmod 600 "$AUTHORIZED_KEYS_FILE"
  echo "Public key telah ditambahkan ke $AUTHORIZED_KEYS_FILE"
else
  echo "Public key sudah ada di authorized_keys"
fi
