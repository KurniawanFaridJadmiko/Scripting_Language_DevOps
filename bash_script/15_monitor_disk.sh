#!/bin/bash

PARTITION="/"

LIMIT=80

USAGE=$(df -h $PARTITION | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$USAGE" -gt "$LIMIT" ]; then
  TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
  MESSAGE="WARNING: Disk usage on $PARTITION is above $LIMIT%. Current usage: $USAGE% at $TIMESTAMP."

  echo "$MESSAGE" | mail -s "Disk Usage Alert" kurniawanfaridjadmiko@gmail.com
  
  if command -v notify-send &> /dev/null; then
    notify-send "Disk Usage Alert" "$MESSAGE"
  fi

  echo "$MESSAGE"
else
  echo "Disk usage is normal: $USAGE%"
fi
