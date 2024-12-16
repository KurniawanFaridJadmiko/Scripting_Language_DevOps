#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <directory> <file_extension>"
  exit 1
fi

DIRECTORY=$1
EXTENSION=$2

echo "Checking directory: $DIRECTORY"
if [ ! -d "$DIRECTORY" ]; then
  echo "Error: Directory '$DIRECTORY' does not exist."
  exit 1
fi

echo "Searching for files with extension .$EXTENSION in directory $DIRECTORY..."
find "$DIRECTORY" -type f -name "*.$EXTENSION" -print
