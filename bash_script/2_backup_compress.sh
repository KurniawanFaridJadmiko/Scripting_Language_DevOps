#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <source_directory> <backup_location>"
  exit 1
fi

SOURCE_DIRECTORY=$1
BACKUP_LOCATION=$2

echo "Checking source directory: $SOURCE_DIRECTORY"
if [ ! -d "$SOURCE_DIRECTORY" ]; then
  echo "Error: Source directory '$SOURCE_DIRECTORY' does not exist."
  exit 1
fi

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_LOCATION/backup_$TIMESTAMP.tar.gz"

echo "Backing up directory $SOURCE_DIRECTORY to $BACKUP_FILE..."
tar -czf "$BACKUP_FILE" -C "$SOURCE_DIRECTORY" .

if [ $? -eq 0 ]; then
  echo "Backup successful: $BACKUP_FILE"
else
  echo "Backup failed."
  exit 1
fi
