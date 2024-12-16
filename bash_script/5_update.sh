#!/bin/bash

LOG_FILE="/var/log/system_update.log"

if [ ! -w "$(dirname "$LOG_FILE")" ]; then
  echo "Error: Cannot write to log file directory. Please run as root or check permissions."
  exit 1
fi

if command -v apt &> /dev/null; then
  PKG_MANAGER="apt"
elif command -v yum &> /dev/null; then
  PKG_MANAGER="yum"
elif command -v dnf &> /dev/null; then
  PKG_MANAGER="dnf"
elif command -v pacman &> /dev/null; then
  PKG_MANAGER="pacman"
else
  echo "Error: No supported package manager found."
  exit 1
fi

{
  echo "========================================="
  echo "System Update Log - $(date)"
  echo "Using package manager: $PKG_MANAGER"
  echo "========================================="
} >> "$LOG_FILE"

case $PKG_MANAGER in
  apt)
    apt update >> "$LOG_FILE" 2>&1 && apt upgrade -y >> "$LOG_FILE" 2>&1 ;;
  yum)
    yum update -y >> "$LOG_FILE" 2>&1 ;;
  dnf)
    dnf upgrade -y >> "$LOG_FILE" 2>&1 ;;
  pacman)
    pacman -Syu --noconfirm >> "$LOG_FILE" 2>&1 ;;
esac

if [ $? -eq 0 ]; then
  echo "System update completed successfully." >> "$LOG_FILE"\else
  echo "System update encountered errors." >> "$LOG_FILE"
fi

echo "System update process completed. Check log at $LOG_FILE."
