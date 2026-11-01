# Домашнее задание к занятию 3 «Использование Ansible»

## Подготовка к выполнению

1. Подготовьте в Yandex Cloud три хоста: для `clickhouse`, для `vector` и для `lighthouse`.
2. Репозиторий LightHouse находится [по ссылке](https://github.com/VKCOM/lighthouse).

## Основная часть

1. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает LightHouse.

**Выполнено**

2. При создании tasks рекомендую использовать модули: `get_url`, `template`, `yum`, `apt`.

**Выполнено**

![alt text](images/02-1.png)

![alt text](images/02-2.png)

![alt text](images/02-3.png)

3. Tasks должны: скачать статику LightHouse, установить Nginx или любой другой веб-сервер, настроить его конфиг для открытия LightHouse, запустить веб-сервер.

**Выполнено**

![alt text](images/03.png)

4. Подготовьте свой inventory-файл `prod.yml`.

**Выполнено**

![alt text](images/04-1.png)

![alt text](images/04-2.png)

5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.

**Выполнено**

![alt text](images/05.png)

6. Попробуйте запустить playbook на этом окружении с флагом `--check`.

**Выполнено**

![alt text](images/06-1.png)

![alt text](images/06-2.png)

7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.

**Выполнено**

![alt text](images/07-1.png)

![alt text](images/07-2.png)

![alt text](images/07-3.png)

![alt text](images/07-4.png)

![alt text](images/07-5.png)

![alt text](images/07-6.png)

![alt text](images/07-7.png)

![alt text](images/07-8.png)

![alt text](images/07-9.png)

![alt text](images/07-10.png)

![alt text](images/07-11.png)

![alt text](images/07-12.png)

8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.

**Выполнено**

![alt text](images/08-1.png)

![alt text](images/08-2.png)

9.  Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.

**Выполнено**

Описание playbook: [playbook/README.md](playbook/README.md)

10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-03-yandex` на фиксирующий коммит, в ответ предоставьте ссылку на него.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
