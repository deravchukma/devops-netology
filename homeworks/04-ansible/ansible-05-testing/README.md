# Домашнее задание к занятию 5 «Тестирование roles»

## Подготовка к выполнению

1. Установите molecule и его драйвера: `pip3 install "molecule molecule_docker molecule_podman`.

**Выполнено**

![alt text](images/00-1.png)

2. Выполните `docker pull aragast/netology:latest` —  это образ с podman, tox и несколькими пайтонами (3.7 и 3.9) внутри.

**Выполнено**

![alt text](images/00-2.png)

## Основная часть

Ваша цель — настроить тестирование ваших ролей. 

Задача — сделать сценарии тестирования для vector. 

Ожидаемый результат — все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s ubuntu_xenial` (или с любым другим сценарием, не имеет значения) внутри корневой директории clickhouse-role, посмотрите на вывод команды. Данная команда может отработать с ошибками или не отработать вовсе, это нормально. Наша цель - посмотреть как другие в реальном мире используют молекулу И из чего может состоять сценарий тестирования.

**Выполнено**

![alt text](images/01-1.png)

![alt text](images/01-2.png)

2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.

**Выполнено**

![alt text](images/02.png)

3. Добавьте несколько разных дистрибутивов (oraclelinux:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.

**Выполнено**

![alt text](images/03-1.png)

![alt text](images/03-2.png)

![alt text](images/03-3.png)

![alt text](images/03-4.png)

![alt text](images/03-5.png)

![alt text](images/03-6.png)

![alt text](images/03-7.png)

4. Добавьте несколько assert в verify.yml-файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска и др.). 

**Выполнено**

![alt text](images/04-1.png)

![alt text](images/04-2.png)

![alt text](images/04-3.png)

![alt text](images/04-4.png)

5. Запустите тестирование роли повторно и проверьте, что оно прошло успешно.

**Выполнено**

![alt text](images/05-1.png)

![alt text](images/05-2.png)

![alt text](images/05-3.png)

![alt text](images/05-4.png)

![alt text](images/05-5.png)

![alt text](images/05-6.png)

![alt text](images/05-7.png)

6. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

**Выполнено**

![alt text](images/06-1.png)

![alt text](images/06-2.png)

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example).

**Выполнено**

![alt text](images/07-1.png)

![alt text](images/07-2.png)

2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it aragast/netology:latest /bin/bash`, где path_to_repo — путь до корня репозитория с vector-role на вашей файловой системе.

**Выполнено**

3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.

**Выполнено**

![alt text](images/09.png)

4. Создайте облегчённый сценарий для `molecule` с драйвером `molecule_podman`. Проверьте его на исполнимость.

**Выполнено**  

Облегчённый сценарий (podman) нашёл ошибку в роли: архив Vector скачивался по относительному пути `./`, и задача распаковки с `become` его не находила. Исправлено переменной `vector_download_dir` (абсолютный путь, по умолчанию `/tmp`) — тег 1.1.1.  

![alt text](images/10-1.png)

![alt text](images/10-2.png)

![alt text](images/10-3.png)

![alt text](images/10-4.png)

![alt text](images/10-5.png)

![alt text](images/10-6.png)

![alt text](images/10-7.png)

![alt text](images/10-8.png)

![alt text](images/10-9.png)

![alt text](images/10-10.png)

![alt text](images/10-11.png)

![alt text](images/10-12.png)

![alt text](images/10-13.png)

5. Пропишите правильную команду в `tox.ini`, чтобы запускался облегчённый сценарий.

**Выполнено**

![alt text](images/11.png)

6. Запустите команду `tox`. Убедитесь, что всё отработало успешно.

**Выполнено**

![alt text](images/12-1.png)

![alt text](images/12-2.png)

![alt text](images/12-3.png)

![alt text](images/12-4.png)

![alt text](images/12-5.png)

![alt text](images/12-6.png)

![alt text](images/12-7.png)

![alt text](images/12-8.png)

![alt text](images/12-9.png)

![alt text](images/12-10.png)

![alt text](images/12-11.png)

![alt text](images/12-12.png)

![alt text](images/12-13.png)

![alt text](images/12-14.png)

![alt text](images/12-15.png)

7. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

**Выполнено**

![alt text](images/13.png)

После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Не забудьте указать в ответе теги решений Tox и Molecule заданий. В качестве решения пришлите ссылку на  ваш репозиторий и скриншоты этапов выполнения задания. 

- Репозиторий: https://github.com/deravchukma/vector-role
- Molecule — тег [1.1.0](https://github.com/deravchukma/vector-role/tree/1.1.0): сценарий `molecule/default` (docker, oraclelinux:8 + ubuntu:latest)
- Tox — тег [1.1.1](https://github.com/deravchukma/vector-role/tree/1.1.1): сценарий `molecule/tox` (podman) и `tox.ini`

## Необязательная часть

1. Проделайте схожие манипуляции для создания роли LightHouse.
2. Создайте сценарий внутри любой из своих ролей, который умеет поднимать весь стек при помощи всех ролей.
3. Убедитесь в работоспособности своего стека. Создайте отдельный verify.yml, который будет проверять работоспособность интеграции всех инструментов между ними.
4. Выложите свои roles в репозитории.

В качестве решения пришлите ссылки и скриншоты этапов выполнения задания.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.
