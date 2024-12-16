#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <python_script_path>"
  exit 1
fi

PYTHON_SCRIPT=$1
SERVICE_NAME="python_simple_service"

UNIT_FILE="/etc/systemd/system/$SERVICE_NAME.service"

echo "Membuat unit file systemd untuk $PYTHON_SCRIPT..."

cat > $UNIT_FILE <<EOL
[Unit]
Description=Python Simple Service
After=network.target

[Service]
ExecStart=$PYTHON_SCRIPT
Restart=always
User=root
WorkingDirectory=/tmp
StandardOutput=append:/tmp/python_service.log
StandardError=append:/tmp/python_service.log

[Install]
WantedBy=multi-user.target
EOL

echo "Memuat ulang systemd dan mengaktifkan service..."
sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME.service

echo "Unit file systemd berhasil dibuat dan service diaktifkan."
echo "Untuk memulai, gunakan: sudo systemctl start $SERVICE_NAME"
echo "Untuk memeriksa status, gunakan: sudo systemctl status $SERVICE_NAME"
