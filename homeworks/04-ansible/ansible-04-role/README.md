# Домашнее задание к занятию 4 «Работа с roles»

## Подготовка к выполнению

1. * Необязательно. Познакомьтесь с [LightHouse](https://youtu.be/ymlrNlaHzIY?t=929).
2. Создайте два пустых публичных репозитория в любом своём проекте: vector-role и lighthouse-role.
3. Добавьте публичную часть своего ключа к своему профилю на GitHub.

## Основная часть

Ваша цель — разбить ваш playbook на отдельные roles. 

Задача — сделать roles для ClickHouse, Vector и LightHouse и написать playbook для использования этих ролей. 

Ожидаемый результат — существуют три ваших репозитория: два с roles и один с playbook.

**Что нужно сделать**

1. Создайте в старой версии playbook файл `requirements.yml` и заполните его содержимым:

   ```yaml
   ---
     - src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
       scm: git
       version: "1.13"
       name: clickhouse 
   ```

**Выполнено**

![alt text](images/01.png)

2. При помощи `ansible-galaxy` скачайте себе эту роль.

**Выполнено**

![alt text](images/02.png)

3. Создайте новый каталог с ролью при помощи `ansible-galaxy role init vector-role`.

**Выполнено**

![alt text](images/03.png)

4. На основе tasks из старого playbook заполните новую role. Разнесите переменные между `vars` и `default`. 

**Выполнено**

![alt text](images/04-1.png)

![alt text](images/04-2.png)

5. Перенести нужные шаблоны конфигов в `templates`.

**Выполнено**

![alt text](images/05.png)

6. Опишите в `README.md` обе роли и их параметры. Пример качественной документации ansible role [по ссылке](https://github.com/cloudalchemy/ansible-prometheus).

**Выполнено**

![alt text](images/06-1.png)

![alt text](images/06-2.png)

![alt text](images/06-3.png)

7. Повторите шаги 3–6 для LightHouse. Помните, что одна роль должна настраивать один продукт.

**Выполнено**

![alt text](images/07-1.png)

![alt text](images/07-2.png)

![alt text](images/07-3.png)

![alt text](images/07-4.png)

![alt text](images/07-5.png)

![alt text](images/07-6.png)

![alt text](images/07-7.png)

8. Выложите все roles в репозитории. Проставьте теги, используя семантическую нумерацию. Добавьте roles в `requirements.yml` в playbook.

**Выполнено**

![alt text](images/08-1.png)

![alt text](images/08-2.png)

9.  Переработайте playbook на использование roles. Не забудьте про зависимости LightHouse и возможности совмещения `roles` с `tasks`.

**Выполнено**

![alt text](images/09-1.png)

![alt text](images/09-2.png)

![alt text](images/09-3.png)

![alt text](images/09-4.png)

![alt text](images/09-5.png)

10. Выложите playbook в репозиторий.

**Выполнено**

Описание playbook: [playbook/README.md](playbook/README.md)

11. В ответе дайте ссылки на оба репозитория с roles и одну ссылку на репозиторий с playbook.

**Выполнено**

- vector-role: https://github.com/deravchukma/vector-role/tree/1.0.0
- lighthouse-role: https://github.com/deravchukma/lighthouse-role/tree/1.0.0
- playbook: https://github.com/deravchukma/devops-netology/tree/08-ansible-04-role/homeworks/04-ansible/ansible-04-role/playbook

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
