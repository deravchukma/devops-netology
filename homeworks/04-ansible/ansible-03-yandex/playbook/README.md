# Playbook: ClickHouse + Vector + LightHouse

Playbook разворачивает стенд сбора логов на хостах Ubuntu 24.04:

- [ClickHouse](https://clickhouse.com) — хранилище логов;
- [Vector](https://vector.dev) — сбор и обработка логов;
- [LightHouse](https://github.com/VKCOM/lighthouse) — веб-интерфейс для просмотра данных ClickHouse, отдаётся через nginx.

## Что делает

### Play `Install Clickhouse` (группа `clickhouse`)

1. Скачивает deb-пакеты `clickhouse-common-static`, `clickhouse-client`, `clickhouse-server` указанной версии с `packages.clickhouse.com`.
2. Устанавливает пакеты через `apt`.
3. При установке/обновлении пакетов перезапускает `clickhouse-server` (handler `Start clickhouse service`).
4. Ждёт, пока сервер начнёт принимать подключения на порту 9000.
5. Создаёт базу данных `logs` (если уже существует — изменений нет).

### Play `Install Vector` (группа `vector`)

1. Скачивает архив Vector указанной версии с `packages.timber.io`.
2. Распаковывает его в `/opt/vector-<версия>`.
3. Создаёт символическую ссылку `/usr/bin/vector` на бинарник.
4. Создаёт системного пользователя и группу `vector`.
5. Создаёт каталог конфигурации и каталог данных.
6. Разворачивает конфигурацию из шаблона `templates/vector.yaml.j2` с проверкой `vector validate` перед заменой файла.
7. Устанавливает стандартный systemd-юнит из дистрибутива, включает и запускает сервис.
8. При изменении конфигурации, юнита или бинарника перезапускает Vector (handler `Restart vector service`).

### Play `Install nginx` (группа `lighthouse`)

1. Устанавливает nginx из репозитория Ubuntu (кэш `apt` обновляется, если старше часа).
2. Отключает стандартный сайт nginx (`sites-enabled/default`), чтобы порт 80 обслуживал LightHouse.
3. Включает и запускает сервис nginx.
4. При изменении конфигурации перечитывает её без перезапуска (handler `Reload nginx`).

### Play `Install LightHouse` (группа `lighthouse`)

1. Скачивает архив LightHouse зафиксированного коммита с GitHub.
2. Распаковывает статику в `/var/www/lighthouse-<короткий хэш коммита>`.
3. Разворачивает конфигурацию сайта nginx из шаблона `templates/lighthouse.conf.j2` и перечитывает конфигурацию nginx (handler `Reload nginx`).

После выполнения LightHouse доступен по адресу `http://<IP lighthouse-01>/`.

## Требования

- Ansible >= 2.16 на управляющей машине.
- Хосты: Ubuntu 24.04 x86_64, доступ по SSH, пользователь с `sudo`.
- Доступ хостов в интернет (скачивание дистрибутивов).
- Для LightHouse — открытый входящий порт 80 на `lighthouse-01`.

## Inventory

`inventory/prod.yml` — три группы:

| Группа | Хосты | Назначение |
|---|---|---|
| `clickhouse` | `clickhouse-01` | сервер ClickHouse |
| `vector` | `vector-01` | агент Vector |
| `lighthouse` | `lighthouse-01` | nginx + LightHouse |

Inventory генерируется Terraform-ом (`../terraform`) при создании ВМ в Yandex Cloud. Порт 80 открыт отдельной security group только на ВМ с признаком `web = true` (`lighthouse-01`).

## Параметры

### `group_vars/clickhouse/vars.yml`

| Переменная | По умолчанию | Описание |
|---|---|---|
| `clickhouse_version` | `22.3.3.44` | Версия ClickHouse |
| `clickhouse_packages` | см. файл | Список пакетов: `name` — имя пакета, `arch` — архитектура в имени deb-файла (`amd64` / `all`) |

### `group_vars/vector/vars.yml`

| Переменная | По умолчанию | Описание |
|---|---|---|
| `vector_version` | `0.60.0` | Версия Vector |
| `vector_install_dir` | `/opt/vector-{{ vector_version }}` | Каталог установки дистрибутива |
| `vector_config_dir` | `/etc/vector` | Каталог конфигурации |
| `vector_data_dir` | `/var/lib/vector` | Каталог данных Vector |

### `group_vars/lighthouse/vars.yml`

| Переменная | По умолчанию | Описание |
|---|---|---|
| `lighthouse_commit` | `d701335c25cd1bb9b5155711190bad8ab852c2ce` | Коммит LightHouse (релизов у проекта нет) |
| `lighthouse_dir` | `/var/www/lighthouse-{{ lighthouse_commit[:7] }}` | Каталог статики, корень сайта nginx |

## Шаблоны

| Шаблон | Куда | Описание |
|---|---|---|
| `templates/vector.yaml.j2` | `/etc/vector/vector.yaml` | Стандартная конфигурация Vector: источник `demo_logs` (синтетические syslog-события) → трансформация `remap` (`parse_syslog`) → вывод в `console` (JSON). Результат виден в `journalctl -u vector` |
| `templates/lighthouse.conf.j2` | `/etc/nginx/conf.d/lighthouse.conf` | Сайт nginx по умолчанию на порту 80, корень — `lighthouse_dir` |

## Теги

| Тег | Что выполняется |
|---|---|
| `clickhouse` | Все задачи установки ClickHouse |
| `vector` | Все задачи установки Vector |
| `nginx` | Все задачи установки nginx |
| `lighthouse` | Все задачи установки LightHouse |
| `download` | Только скачивание дистрибутивов (ClickHouse, Vector, LightHouse) |
| `install` | Установка: пакеты, распаковка, пользователь, каталоги, юнит |
| `config` | Только конфигурация: Vector, сайт nginx для LightHouse, отключение сайта nginx по умолчанию |

## Использование

```bash
# Проверка без изменений (на чистых хостах падает на зависимых задачах — см. ниже)
ansible-playbook -i inventory/prod.yml site.yml --check

# Установка с выводом изменений
ansible-playbook -i inventory/prod.yml site.yml --diff

# Только обновить конфигурацию
ansible-playbook -i inventory/prod.yml site.yml --tags config --diff

# Только один компонент
ansible-playbook -i inventory/prod.yml site.yml --tags lighthouse --diff
```

**Примечание про `--check`:** на чистых хостах задачи, которые зависят от предыдущих (установка скачанного пакета, распаковка архива, запуск ещё не установленного сервиса), завершаются ошибкой, потому что в check-режиме предыдущие задачи ничего не меняют. На уже развёрнутом стенде `--check` работает полностью.
