#!/bin/bash

LOG_FILE="/var/log/cpu_usage.log"

LOAD_AVERAGE=$(uptime | awk -F'load average: ' '{ print $2 }' | awk -F', ' '{ print $1 }')

LOAD_PERCENT=$(echo "$LOAD_AVERAGE * 100" | bc)

LIMIT=75

if (( $(echo "$LOAD_PERCENT > $LIMIT" | bc -l) )); then
  TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
  echo "$TIMESTAMP - WARNING: CPU load average over 75%! Current load: $LOAD_AVERAGE" >> $LOG_FILE
  echo "High CPU usage detected! Log entry added."
else
  echo "CPU load is normal: $LOAD_AVERAGE"
fi
