#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

DIRECTORY=$1

echo "Checking directory: $DIRECTORY"
if [ ! -d "$DIRECTORY" ]; then
  echo "Error: Directory '$DIRECTORY' does not exist."
  exit 1
fi

echo -e "\nFile Name\tLines\tWords\tCharacters"
echo "-----------------------------------------"

find "$DIRECTORY" -type f -name "*.txt" | while read FILE; do
  if [ -f "$FILE" ]; then
    LINES=$(wc -l < "$FILE")
    WORDS=$(wc -w < "$FILE")
    CHARACTERS=$(wc -m < "$FILE")
    echo -e "$(basename "$FILE")\t$LINES\t$WORDS\t$CHARACTERS"
  fi
done
