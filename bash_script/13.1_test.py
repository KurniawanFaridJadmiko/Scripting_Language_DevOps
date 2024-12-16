#!/usr/bin/env python3
import time

while True:
    with open("/tmp/python_service.log", "a") as log_file:
        log_file.write(f"Service is running at {time.ctime()}\n")
    time.sleep(60)  # Menunggu selama 1 menit sebelum menulis lagi
