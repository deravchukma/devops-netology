# Playbook: ClickHouse + Vector + LightHouse на ролях

Playbook разворачивает стенд сбора логов на хостах Ubuntu 24.04. Каждый продукт ставится своей ролью:

| Продукт | Роль | Источник | Версия |
|---|---|---|---|
| [ClickHouse](https://clickhouse.com) — хранилище логов | `clickhouse` | [AlexeySetevoi/ansible-clickhouse](https://github.com/AlexeySetevoi/ansible-clickhouse) | `1.13` |
| [Vector](https://vector.dev) — сбор и обработка логов | `vector` | [deravchukma/vector-role](https://github.com/deravchukma/vector-role) | `1.0.0` |
| [LightHouse](https://github.com/VKCOM/lighthouse) — веб-интерфейс для ClickHouse | `lighthouse` | [deravchukma/lighthouse-role](https://github.com/deravchukma/lighthouse-role) | `1.0.0` |

Описание ролей, их переменных и тегов — в README репозиториев ролей.

## Структура

```
playbook/
├── site.yml              # 3 play: clickhouse, vector, lighthouse
├── requirements.yml      # роли и их версии (git-теги)
├── .ansible-lint         # скачанные роли не проверяются (у них свой lint)
├── group_vars/           # только переопределения переменных ролей
├── inventory/prod.yml    # генерируется Terraform (../terraform)
└── roles/                # скачивается ansible-galaxy, в git не хранится
```

## Что делает

| Play | Хосты | Содержимое |
|---|---|---|
| `Install Clickhouse` | `clickhouse` | роль `clickhouse`: репозиторий `packages.clickhouse.com`, пакеты зафиксированной версии, конфигурация, сервис, база `logs` |
| `Install Vector` | `vector` | роль `vector`: дистрибутив в `/opt`, пользователь `vector`, конфиг из `vector_config`, systemd-сервис |
| `Install LightHouse` | `lighthouse` | `pre_tasks`: установка nginx, отключение сайта `default`, запуск nginx; затем роль `lighthouse`: статика LightHouse и сайт nginx |

**Зависимость LightHouse от nginx.** Роль `lighthouse` настраивает только LightHouse (одна роль — один продукт) и требует
установленный nginx. Поэтому nginx ставится в `pre_tasks` того же play: внутри play порядок всегда
`pre_tasks` → handlers → `roles` → `tasks` → `post_tasks`, и к запуску роли nginx уже работает.
Задача `Disable nginx default site` уведомляет handler `Reload nginx` из роли — handlers общие для всего play.
Без nginx роль останавливается на проверке с понятным сообщением.

После выполнения LightHouse доступен по адресу `http://<IP lighthouse-01>/`.

## Требования

- ansible-core >= 2.16 на управляющей машине, доступ к GitHub по SSH (роли скачиваются по `git@github.com:...`).
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

Inventory генерируется Terraform (`../terraform`) при создании ВМ в Yandex Cloud. Порт 80 открыт отдельной security group
только на ВМ с признаком `web = true` (`lighthouse-01`).

## Параметры

В `group_vars` задаются только значения, отличные от значений ролей по умолчанию или зафиксированные явно.

| Файл | Переменная | Значение | Зачем |
|---|---|---|---|
| `group_vars/clickhouse/vars.yml` | `clickhouse_version` | `22.3.3.44` | в роли по умолчанию `latest` |
| | `clickhouse_dbs_custom` | `[{ name: logs }]` | база для логов |
| `group_vars/vector/vars.yml` | `vector_version` | `0.60.0` | версия зафиксирована явно |
| `group_vars/lighthouse/vars.yml` | `lighthouse_commit` | `d701335c25cd1bb9b5155711190bad8ab852c2ce` | коммит зафиксирован явно |

## Теги

| Тег | Что выполняется |
|---|---|
| `clickhouse` | роль `clickhouse` целиком |
| `vector` | роль `vector` целиком |
| `nginx` | `pre_tasks` установки nginx |
| `lighthouse` | роль `lighthouse` целиком |
| `download` | скачивание дистрибутивов (Vector, LightHouse) |
| `install` | установка: пакеты, распаковка, пользователь, каталоги, юнит |
| `config` | конфигурация: ClickHouse, Vector, сайт nginx для LightHouse, отключение сайта nginx по умолчанию |

Роль `clickhouse` дополнительно поддерживает свои теги (`config_sys`, `config_db`, `config_dict`, `remove`), см. её README.

## Использование

```bash
# Скачать роли (повторно с новой версией в requirements.yml — с --force)
ansible-galaxy install -r requirements.yml -p roles

# Проверка
ansible-lint

# Установка с выводом изменений
ansible-playbook -i inventory/prod.yml site.yml --diff

# Только конфигурация / только один компонент
ansible-playbook -i inventory/prod.yml site.yml --tags config --diff
ansible-playbook -i inventory/prod.yml site.yml --tags lighthouse --diff
```

**Примечание про `--check`:** на чистых хостах задачи, зависящие от предыдущих (распаковка ещё не скачанного архива,
установка пакетов из ещё не добавленного репозитория), завершаются ошибкой: в check-режиме предыдущие задачи ничего
не меняют. На уже развёрнутом стенде `--check` работает полностью.
