# Домашнее задание к занятию "5.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker контейнера"

1.  

Сценарий выполения задачи:

- создайте свой репозиторий на https://hub.docker.com;
- выберете любой образ, который содержит веб-сервер Nginx;
- создайте свой fork образа;
- реализуйте функциональность:
запуск веб-сервера в фоне с индекс-страницей, содержащей HTML-код ниже:
```
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
```
Опубликуйте созданный форк в своем репозитории и предоставьте ответ в виде ссылки на https://hub.docker.com/username_repo.

```
dma@ubuntu:~$ docker pull nginx
Using default tag: latest
latest: Pulling from library/nginx
f7a1c6dad281: Pull complete 
4d3e1d15534c: Pull complete 
9ebb164bd1d8: Pull complete 
59baa8b00c3c: Pull complete 
a41ae70ab6b4: Pull complete 
e3908122b958: Pull complete 
Digest: sha256:1c13bc6de5dfca749c377974146ac05256791ca2fe1979fc8e8278bf0121d285
Status: Downloaded newer image for nginx:latest
docker.io/library/nginx:latest
dma@ubuntu:~$ docker login -u deravchukma
Password: 
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
dma@ubuntu:~$ mkdir nginx
dma@ubuntu:~$ cd ./nginx
dma@ubuntu:~/nginx$ nano index.html
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
dma@ubuntu:~/nginx$ nano Dockerfile
FROM nginx
COPY index.html /usr/share/nginx/html/index.html
dma@ubuntu:~/nginx$ docker build . -t deravchukma/nginx
Sending build context to Docker daemon  3.072kB
Step 1/2 : FROM nginx
 ---> c919045c4c2b
Step 2/2 : COPY index.html /usr/share/nginx/html/index.html
 ---> 773b0f879d3c
Successfully built 773b0f879d3c
Successfully tagged deravchukma/nginx:latest
dma@ubuntu:~/nginx$ docker images
REPOSITORY          TAG       IMAGE ID       CREATED          SIZE
deravchukma/nginx   latest    773b0f879d3c   36 seconds ago   142MB
nginx               latest    c919045c4c2b   12 days ago      142MB
dma@ubuntu:~/nginx$ docker run --name my-nginx -p 8080:80 -d deravchukma/nginx
3fc0c31d9e6d9b79b5cb3afe643eca75472ecae0bc7a4a0a16f2a7f80af975db
dma@ubuntu:~/nginx$ curl http://localhost:8080
<html>
<head>
Hey, Netology
</head>
<body>
<h1>I’m DevOps Engineer!</h1>
</body>
</html>
dma@ubuntu:~/nginx$ docker push deravchukma/nginx
Using default tag: latest
The push refers to repository [docker.io/deravchukma/nginx]
cb507e7ee478: Pushed 
e4b39f949587: Mounted from library/nginx 
53db376e88c7: Mounted from library/nginx 
d3ae25fc9f7a: Mounted from library/nginx 
3baebd9b50ad: Mounted from library/nginx 
57a9a0cdd450: Mounted from library/nginx 
1401df2b50d5: Mounted from library/nginx 
latest: digest: sha256:eaa68c06fb9825f234ea8df26290ec9d812fe51b0cd233f9dabb18e030291f82 size: 1777
```

Ссылка на образ: [https://hub.docker.com/r/deravchukma/nginx](https://hub.docker.com/r/deravchukma/nginx)

2.  
| Сценарий  | Ответ |
| ------------- | ------------- |
| Высоконагруженное монолитное java веб-приложение | Лучше подойдет физический сервер, т.к. высокая нагрузка и приложение монолитное |
| Nodejs веб-приложение | Подойдет docker, т.к. широко используестя в web-разработке |
| Мобильное приложение c версиями для Android и iOS | Подойдет вирутальная машина либо физический сервер. Не слышал о применении контейнеризации в мобильной разработке, но возможно допустим и docker|
| Шина данных на базе Apache Kafka | Не сталкивался с таким, но судя по тому что удалось нагуглить - docker подойдёт. |
| Elasticsearch кластер для реализации логирования продуктивного веб-приложения - три ноды elasticsearch, два logstash и две ноды kibana | Подойдет docker либо виртуальная машина, т.к. подразумевается кластеризация |
| Мониторинг-стек на базе Prometheus и Grafana | Подойдет docker, скорость развертывания, возможность масштабирования, не подразумевается хранения большого объема данных |
| MongoDB, как основное хранилище данных для java-приложения | Если не сильно нагружена база, то подойдет виртуальная машина. Для высоконагруженной БД физический сервер. Для тестов возможно использовать и docker|
| Gitlab сервер для реализации CI/CD процессов и приватный (закрытый) Docker Registry | Подойдет физический сервер либо виртуальная машина, т.к. большой объем данных, потеря которых критична |

3.  

- Запустите первый контейнер из образа ***centos*** c любым тэгом в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Запустите второй контейнер из образа ***debian*** в фоновом режиме, подключив папку ```/data``` из текущей рабочей директории на хостовой машине в ```/data``` контейнера;
- Подключитесь к первому контейнеру с помощью ```docker exec``` и создайте текстовый файл любого содержания в ```/data```;
- Добавьте еще один файл в папку ```/data``` на хостовой машине;
- Подключитесь во второй контейнер и отобразите листинг и содержание файлов в ```/data``` контейнера.
```
dma@ubuntu:~$ mkdir ./data
dma@ubuntu:~$ docker run  -it -v /home/dma/data:/data  --name centos -d  centos:8
a3f58777b8631f9ad1d1d1563248695b0683e7283b134a8281a35b2d9beec8fa
dma@ubuntu:~$ docker run  -it -v /home/dma/data:/data  --name debian -d  debian
3d50f837336de5d3d367c120198eba9be54587d9b54575092d986d9083471f67
dma@ubuntu:~$ docker exec -it centos /bin/bash
[root@a3f58777b863 /]# echo "Hello, CentOS!" > /data/file_centos.txt
[root@a3f58777b863 /]# exit
exit
dma@ubuntu:~$ echo "Hello, host!" > ./data/file_host.txt
dma@ubuntu:~$ docker exec -it debian /bin/bash
root@3d50f837336d:/# ls -l /data
total 8
-rw-r--r-- 1 root root 15 Mar 14 22:30 file_centos.txt
-rw-rw-r-- 1 1000 1000 13 Mar 14 22:22 file_host.txt
root@3d50f837336d:/# cat /data/file_centos.txt 
Hello, CentOS!
root@3d50f837336d:/# cat /data/file_host.txt 
Hello, host!
root@3d50f837336d:/# exit
exit
```

4. (*)  

Ссылка на образ: [https://hub.docker.com/r/deravchukma/ansible](https://hub.docker.com/r/deravchukma/ansible)