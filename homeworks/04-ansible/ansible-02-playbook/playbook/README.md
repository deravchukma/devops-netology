# Playbook: ClickHouse + Vector

Playbook устанавливает [ClickHouse](https://clickhouse.com) и [Vector](https://vector.dev) на хосты Ubuntu 24.04.

## Что делает

### Play `Install Clickhouse` (группа `clickhouse`)

1. Скачивает deb-пакеты `clickhouse-common-static`, `clickhouse-client`, `clickhouse-server` указанной версии с `packages.clickhouse.com`.
2. Устанавливает пакеты через `apt`.
3. При установке/обновлении пакетов перезапускает `clickhouse-server` (handler `Start clickhouse service`).
4. Создаёт базу данных `logs` (если уже существует — изменений нет).

### Play `Install Vector` (группа `vector`)

1. Скачивает архив Vector указанной версии с `packages.timber.io`.
2. Распаковывает его в `/opt/vector-<версия>`.
3. Создаёт символическую ссылку `/usr/bin/vector` на бинарник.
4. Создаёт системного пользователя и группу `vector`.
5. Создаёт каталог конфигурации и каталог данных.
6. Разворачивает конфигурацию из шаблона `templates/vector.yaml.j2` с проверкой `vector validate` перед заменой файла.
7. Устанавливает стандартный systemd-юнит из дистрибутива, включает и запускает сервис.
8. При изменении конфигурации, юнита или бинарника перезапускает Vector (handler `Restart vector service`).

## Требования

- Ansible >= 2.16 на управляющей машине.
- Хосты: Ubuntu 24.04 x86_64, доступ по SSH, пользователь с `sudo`.
- Доступ хостов в интернет (скачивание дистрибутивов).

## Inventory

`inventory/prod.yml` — две группы:

| Группа | Хосты | Назначение |
|---|---|---|
| `clickhouse` | `clickhouse-01` | сервер ClickHouse |
| `vector` | `vector-01` | агент Vector |

Inventory генерируется Terraform-ом (`../terraform`) при создании ВМ в Yandex Cloud.

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

## Шаблоны

`templates/vector.yaml.j2` — стандартная конфигурация Vector: источник `demo_logs` (синтетические syslog-события) → трансформация `remap` (`parse_syslog`) → вывод в `console` (JSON). Результат виден в `journalctl -u vector`.

## Теги

| Тег | Что выполняется |
|---|---|
| `clickhouse` | Все задачи установки ClickHouse |
| `vector` | Все задачи установки Vector |
| `download` | Только скачивание дистрибутивов |
| `install` | Установка: пакеты, распаковка, пользователь, каталоги, юнит |
| `config` | Только конфигурация Vector (каталог и шаблон) |

## Использование

```bash
# Проверка без изменений
ansible-playbook -i inventory/prod.yml site.yml --check

# Установка с выводом изменений
ansible-playbook -i inventory/prod.yml site.yml --diff

# Только обновить конфигурацию Vector
ansible-playbook -i inventory/prod.yml site.yml --tags config --diff
```
