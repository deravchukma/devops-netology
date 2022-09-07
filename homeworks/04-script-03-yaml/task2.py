#!/usr/bin/env python3
           
import socket
import time
import json
import yaml

dict_service = {'drive.google.com': '0.0.0.0', 'mail.google.com': '0.0.0.0', 'google.com': '0.0.0.0'}

while True:
    for service, current_ip in dict_service.items():
        new_ip = socket.gethostbyname(service)
        time.sleep(2)
        if new_ip != current_ip:
            dict_service[service] = new_ip
            print(f'[ERROR] {service} IP mismatch: {current_ip} New IP: {new_ip}')
            with open('get_ip.json', 'w') as file_json:
                json.dump(dict_service, file_json, indent=2)
            with open('get_ip.yaml', 'w') as file_yaml:
                yaml.dump(dict_service, file_yaml, explicit_start=True, explicit_end=True)
        else:
            print(f'{service} - {current_ip}')