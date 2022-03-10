# Установка

## Docker
1. Устанавливаем Docker CE

https://docs.docker.com/install/linux/docker-ce/ubuntu/

2. Запускаем терминал и пробуем запустить тестовый образ:

```bash
docker run hello-world
```

## Docker compose
1. Устанавливаем Docker compose:

https://docs.docker.com/compose/install/

2. Проверяем успешность установки командой:

```bash
docker-compose --version
```

## Добавляем su-пользователя docker

Выполнять команды каждый раз из под sudo - утомительно. Это можно исправить.
Следующей командой добавим пользователя *rtplv* в группу *docker*. Перезагружаем процесс докера:

```bash
sudo usermod -aG docker rtplv
sudo systemctl restart docker
```

# Основные команды

## Запуск образа

```bash
# daemon режим
docker run ubuntu -d
# интерактивный режим (запускаем bash)
docker run -it ubuntu bash
```

## Список контейнеров
### Запущенные

```bash
docker ps
```
### Все

```bash
docker ps -a
# Получить список id контейнеров
docker ps -aq
```

## Запуск, остановка контейнера

```bash
docker start containername
docker stop containername
```
## Получение информация о контейнере

### Общая информация

```bash
docker inspect containername
```

### Дифы от начального состояния

```bash
docker diff containername
```

### Лог контейнера

```bash
docker logs containername
```

## Удаление контейнеров

```bash
docker rm -v $(docker ps -aq) # Все
docker rm -v $(docker ps -q) # Все активные
docker rm -v $(docker ps -aq -f status=exited) # Все неактивные
```

## Удаляем "висячие образы"
```
docker rmi $(docker images -f "dangling=true" -q)
```

# Кастомные образы

## Создание образа

1. Запускаем контейнер на основе образа Ubuntu:

```
docker run -it --name cow-container --hostname cow-server ubuntu bash
```

2. Устанавливаем нужное нам добро, и выходим из контейнера.

3. Собираем образ из нашего контейнера:

```
docker commit cow-container rtupolev/cow-game  # название образа: имя пользователя / название образа
```

4. Теперь наш образ можно найти в docker images и запустить на основе него контейнер!

```
docker run rtupolev/cow-game cowsay "Hello"
```

## Заливаем образ на docker hub

1. Логинимся:
```
docker login
```

2. Пушим:
```
docker push rtupolev/cow-game
```

> Можно при push'е указать теги. Например - rtupolev/cow-game:beta


# Используем docker-compose

## Конфиг для билда контейнера

1. Создаем Dockerfile:

Dockerfile:
```
FROM python:3

WORKDIR /home/python3/app

RUN pip install django
```

bash:
```
docker build -t django-container .
```

## Основные команды

### Создаем контейнер
```
docker-compose up -d
```

### Остановка и удаление контейнеров
```
docker-compose down
```

### Выполняем команду в контейнере
```
docker exec -it container_name bash
```

# docker-compose.yml

Для соединения нескольких образом можно использовать `docker-compose.yml`.

Я не буду расписывать подробности касательно этого, а оставлю файлик-пример. А дальше сами, держитесь там.
