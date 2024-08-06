#!/usr/bin/env python3

import socket
import time

dict_service = {'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0'}

while True:
    for service, current_ip in dict_service.items():
        new_ip = socket.gethostbyname(service)
        time.sleep(2)
        if new_ip != current_ip:
            dict_service[service] = new_ip
            print(f'[ERROR] {service} IP mismatch: {current_ip} New IP: {new_ip}')
        else:
            print(f'{service} - {current_ip}')