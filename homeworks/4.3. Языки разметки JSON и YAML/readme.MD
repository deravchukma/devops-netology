### Как сдавать задания

Вы уже изучили блок «Системы управления версиями», и начиная с этого занятия все ваши работы будут приниматься ссылками на .md-файлы, размещённые в вашем публичном репозитории.

Скопируйте в свой .md-файл содержимое этого файла; исходники можно посмотреть [здесь](https://raw.githubusercontent.com/netology-code/sysadm-homeworks/devsys10/04-script-03-yaml/README.md). Заполните недостающие части документа решением задач (заменяйте `???`, ОСТАЛЬНОЕ В ШАБЛОНЕ НЕ ТРОГАЙТЕ чтобы не сломать форматирование текста, подсветку синтаксиса и прочее, иначе можно отправиться на доработку) и отправляйте на проверку. Вместо логов можно вставить скриншоты по желани.

# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"


## Обязательная задача 1
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```
    { "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```
  Нужно найти и исправить все ошибки, которые допускает наш сервис

  ### Ваш скрипт:
```json
{ "info" : "Sample JSON output from our servicet",
    "elements" :[
        { "name" : "first",
        "type" : "server",
        "ip" : "71.75.22.42"
        },
        { "name" : "second",
        "type" : "proxy",
        "ip" : "71.78.22.43"
        }
    ]
}
```

## Обязательная задача 2
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: `{ "имя сервиса" : "его IP"}`. Формат записи YAML по одному сервису: `- имя сервиса: его IP`. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.

### Ваш скрипт:
```python
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
```

### Вывод скрипта при запуске при тестировании:
```
vagrant@vagrant:~$ python3 task2.py
[ERROR] drive.google.com IP mismatch: 0.0.0.0 New IP: 64.233.165.194
[ERROR] mail.google.com IP mismatch: 0.0.0.0 New IP: 209.85.233.83
[ERROR] google.com IP mismatch: 0.0.0.0 New IP: 64.233.165.101
drive.google.com - 64.233.165.194
mail.google.com - 209.85.233.83
[ERROR] google.com IP mismatch: 64.233.165.101 New IP: 64.233.165.139
drive.google.com - 64.233.165.194
mail.google.com - 209.85.233.83
google.com - 64.233.165.139
drive.google.com - 64.233.165.194
mail.google.com - 209.85.233.83
[ERROR] google.com IP mismatch: 64.233.165.139 New IP: 64.233.162.138
drive.google.com - 64.233.165.194
mail.google.com - 209.85.233.83
[ERROR] google.com IP mismatch: 64.233.162.138 New IP: 64.233.162.139
drive.google.com - 64.233.165.194
mail.google.com - 209.85.233.83
google.com - 64.233.162.139
```

### json-файл(ы), который(е) записал ваш скрипт:
```json
{
  "drive.google.com": "64.233.165.194",
  "mail.google.com": "209.85.233.83",
  "google.com": "64.233.162.139"
}
```

### yml-файл(ы), который(е) записал ваш скрипт:
```yaml
---
drive.google.com: 64.233.165.194
google.com: 64.233.162.139
mail.google.com: 209.85.233.83
...
```

## Дополнительное задание (со звездочкой*) - необязательно к выполнению

Так как команды в нашей компании никак не могут прийти к единому мнению о том, какой формат разметки данных использовать: JSON или YAML, нам нужно реализовать парсер из одного формата в другой. Он должен уметь:
   * Принимать на вход имя файла
   * Проверять формат исходного файла. Если файл не json или yml - скрипт должен остановить свою работу
   * Распознавать какой формат данных в файле. Считается, что файлы *.json и *.yml могут быть перепутаны
   * Перекодировать данные из исходного формата во второй доступный (из JSON в YAML, из YAML в JSON)
   * При обнаружении ошибки в исходном файле - указать в стандартном выводе строку с ошибкой синтаксиса и её номер
   * Полученный файл должен иметь имя исходного файла, разница в наименовании обеспечивается разницей расширения файлов

### Ваш скрипт:
```python
???
```

### Пример работы скрипта:
???