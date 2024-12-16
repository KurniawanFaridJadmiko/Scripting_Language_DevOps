#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <source_directory> <backup_directory>"
  exit 1
fi

SOURCE_DIRECTORY=$1
BACKUP_DIRECTORY=$2

echo "Checking source directory: $SOURCE_DIRECTORY"
if [ ! -d "$SOURCE_DIRECTORY" ]; then
  echo "Error: Source directory '$SOURCE_DIRECTORY' does not exist."
  exit 1
fi

if [ ! -d "$BACKUP_DIRECTORY" ]; then
  echo "Backup directory '$BACKUP_DIRECTORY' does not exist. Creating it..."
  mkdir -p "$BACKUP_DIRECTORY"
  if [ $? -ne 0 ]; then
    echo "Error: Failed to create backup directory."
    exit 1
  fi
fi

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIRECTORY/backup_$TIMESTAMP.tar.gz"

echo "Backing up directory $SOURCE_DIRECTORY to $BACKUP_FILE..."
tar -czf "$BACKUP_FILE" -C "$SOURCE_DIRECTORY" .

if [ $? -eq 0 ]; then
  echo "Backup successful: $BACKUP_FILE"
else
  echo "Backup failed."
  exit 1
fi

echo "Removing backups older than 7 days in $BACKUP_DIRECTORY..."
find "$BACKUP_DIRECTORY" -type f -name "backup_*.tar.gz" -mtime +7 -exec rm -f {} \;
if [ $? -eq 0 ]; then
  echo "Old backups removed successfully."
else
  echo "Failed to remove old backups."
  exit 1
fi
