# Домашнее задание к занятию "6.2. SQL"

1.  
```docker pull postgres:12
docker volume create data
docker volume create backup
docker run --rm --name postgres -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v data:/var/lib/postgresql/data -v backup:/var/lib/postgresql/backup postgres:12```  
![SNAG-0996.png](SNAG-0996.png)  
  
![SNAG-0997.png](SNAG-0997.png)  
  
![SNAG-0998.png](SNAG-0998.png)  
  
2.  
  
В БД из задачи 1:  
- создайте пользователя test-admin-user и БД test_db  
```sudo docker ps
docker exec -it b51998272842 bash
psql -U postgres -p 5432
CREATE ROLE "test-admin-user" PASSWORD 'admin' SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN;
CREATE DATABASE test_db;
exit```  
![SNAG-0999.png](SNAG-0999.png)  
  
- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)  
```psql -U postgres -d test_db
CREATE TABLE orders (
    id serial primary key,
    наименование varchar(80),
    цена int
);
CREATE TABLE clients (
    id serial primary key,
    фамилия varchar(20),
    страна_проживания varchar(20),
    заказ int REFERENCES orders (id)
);
CREATE INDEX ON clients (страна_проживания);```  
  
![SNAG-1000.png](SNAG-1000.png)  
  
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db  
`GRANT ALL ON TABLE public.clients, public.orders TO "test-admin-user";`  
- создайте пользователя test-simple-user  
`CREATE ROLE "test-simple-user" PASSWORD 'simple' NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;`  
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db  
`GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE public.clients, public.orders TO "test-simple-user";`  
![SNAG-1001.png](SNAG-1001.png)  
  
Приведите:
- итоговый список БД после выполнения пунктов выше,  
`\l`  
![SNAG-1002.png](SNAG-1002.png)  
  
- описание таблиц (describe)  
`\d clients`  
![SNAG-1003.png](SNAG-1003.png)  
`\d orders`  
![SNAG-1004.png](SNAG-1004.png)  
  
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db  
- список пользователей с правами над таблицами test_db  
`SELECT * FROM information_schema.table_privileges WHERE table_catalog='test_db' and grantee IN ('test-admin-user', 'test-simple-user');`  
![SNAG-1005.png](SNAG-1005.png)  

3.  
*Дальше работал в dbeaver.*  
Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:  
  
```INSERT INTO orders (наименование, цена) VALUES ('Шоколад', 10);
INSERT INTO orders (наименование, цена) VALUES ('Принтер', 3000);
INSERT INTO orders (наименование, цена) VALUES ('Книга', 500);
INSERT INTO orders (наименование, цена) VALUES ('Монитор', 7000);
INSERT INTO orders (наименование, цена) VALUES ('Гитара', 4000);```  
![SNAG-1007.png](SNAG-1007.png)  
![SNAG-1008.png](SNAG-1008.png)  
   
```INSERT INTO clients (фамилия, страна_проживания) VALUES('Иванов Иван Иванович', 'USA');
INSERT INTO clients (фамилия, страна_проживания) VALUES('Петров Петр Петрович', 'Canada');
INSERT INTO clients (фамилия, страна_проживания) VALUES('Иоганн Себастьян Бах', 'Japan');
INSERT INTO clients (фамилия, страна_проживания) VALUES('Ронни Джеймс Дио', 'Russia');
INSERT INTO clients (фамилия, страна_проживания) VALUES('Ritchie Blackmore', 'Russia');```  
![SNAG-1009.png](SNAG-1009.png)  
![SNAG-1010.png](SNAG-1010.png)  
  
Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
`select count (*) from orders o;`  
![SNAG-1013.png](SNAG-1013.png)  
  
`select count (*) from clients c;`  
![SNAG-1014.png](SNAG-1014.png)  
  
4.  
  
Приведите SQL-запросы для выполнения данных операций.  
```update  clients set заказ = 3 where id = 1;
update  clients set заказ = 4 where id = 2;
update  clients set заказ = 5 where id = 3;```  
![SNAG-1015.png](SNAG-1015.png)  
  
Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.  
`select * from clients where заказ is not null`  
![SNAG-1016.png](SNAG-1016.png)  
  
5.  
  
`explain select * from clients where заказ is not null`
- Seq Scan - последовательное, чтение данных таблицы.  
- Cost - стоимость запроса *(0.00 - стоимость получения первого значения; 15.30 - стоимость выполнения всего запроса)*.  
- Rows — приблизительное количество возвращаемых строк при выполнении операции Seq Scan.  
- Width — средний размер одной строки в байтах.  
- Filter - фильтрация по полю *заказ*.  
![SNAG-1017.png](SNAG-1017.png)  
  
6.  
  
Не выходя из контейнера создаем бэкап.  
`pg_dumpall -U postgres test_db > /var/lib/postgresql/backup/test_db.dump`  
  
![SNAG-1018.png](SNAG-1018.png)  
  
Останавливаем контейнер.  
Поднимаем новый пустой контейнер.  
`docker run --rm --name postgres -e POSTGRES_PASSWORD=postgres -ti -p 5432:5432 -v backup:/var/lib/postgresql/backup postgres:12`  
![SNAG-1019.png](SNAG-1019.png)  
  
Восстанавливаем из бэкапа БД test_db в новом контейнере.  
`psql -U postgres < /var/lib/postgresql/backup/test_db.dump`  
![SNAG-1020.png](SNAG-1020.png)  
  
Проверяем наличие таблиц.  
```\d clients
\d orders```  
![SNAG-1021.png](SNAG-1021.png)  