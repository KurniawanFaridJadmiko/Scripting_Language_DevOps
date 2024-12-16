#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <output_directory>"
  exit 1
fi

OUTPUT_DIRECTORY=$1

if [ ! -d "$OUTPUT_DIRECTORY" ]; then
  echo "Output directory '$OUTPUT_DIRECTORY' does not exist. Creating it..."
  mkdir -p "$OUTPUT_DIRECTORY"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to create output directory."
    exit 1
  fi
fi

PRIVATE_KEY="$OUTPUT_DIRECTORY/id_rsa"
PUBLIC_KEY="$OUTPUT_DIRECTORY/id_rsa.pub"

if [ -f "$PRIVATE_KEY" ] || [ -f "$PUBLIC_KEY" ]; then
  echo "SSH key pair already exists in $OUTPUT_DIRECTORY. Skipping generation."
else
  echo "Generating SSH key pair in $OUTPUT_DIRECTORY..."
  ssh-keygen -t rsa -b 2048 -f "$PRIVATE_KEY" -N "" -q
  if [ $? -eq 0 ]; then
    echo "SSH key pair created successfully."
    echo "Private key: $PRIVATE_KEY"
    echo "Public key: $PUBLIC_KEY"
  else
    echo "Error: Failed to generate SSH key pair."
    exit 1
  fi
fi

if [ -f "$PUBLIC_KEY" ]; then
  echo "Public key content:"
  cat "$PUBLIC_KEY"
else
  echo "Error: Public key not found after generation."
  exit 1
fi
