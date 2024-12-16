#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <start|stop|status> <service_name>"
  exit 1
fi

ACTION=$1
SERVICE=$2

start_service() {
  echo "Memulai service $SERVICE..."
  sudo systemctl start "$SERVICE"
  if [ $? -eq 0 ]; then
    echo "Service $SERVICE berhasil dimulai."
  else
    echo "Gagal memulai service $SERVICE."
  fi
}

stop_service() {
  echo "Menghentikan service $SERVICE..."
  sudo systemctl stop "$SERVICE"
  if [ $? -eq 0 ]; then
    echo "Service $SERVICE berhasil dihentikan."
  else
    echo "Gagal menghentikan service $SERVICE."
  fi
}

status_service() {
  echo "Memeriksa status service $SERVICE..."
  sudo systemctl status "$SERVICE" | grep "Active:"
}

case "$ACTION" in
  start)
    start_service
    ;;
  stop)
    stop_service
    ;;
  status)
    status_service
    ;;
  *)
    echo "Tindakan tidak valid! Gunakan 'start', 'stop', atau 'status'."
    exit 2
    ;;
esac
