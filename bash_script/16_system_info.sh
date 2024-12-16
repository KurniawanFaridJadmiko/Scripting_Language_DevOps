#!/bin/bash

HOSTNAME=$(hostname)

CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")

USER_COUNT=$(who | wc -l)

echo "System Information:"
echo "--------------------"
echo "Hostname: $HOSTNAME"
echo "Current Time: $CURRENT_TIME"
echo "Logged-in Users: $USER_COUNT"
