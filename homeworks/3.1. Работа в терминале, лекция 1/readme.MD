# Домашнее задание к занятию "3.1. Работа в терминале, лекция 1"

1. Выполнено.
   ![SNAG-0296.png](SNAG-0296.png)
   
1. Выполнено.
   ![SNAG-0297.png](SNAG-0297.png)
   
1. Выполнено.
   ![SNAG-0298.png](SNAG-0298.png)
   
1. Выполнено.
   ![SNAG-0299.png](SNAG-0299.png)
   
   ![SNAG-0300.png](SNAG-0300.png)
   
   ![SNAG-0302.png](SNAG-0302.png)

   ![SNAG-0304.png](SNAG-0304.png)

   ![SNAG-0305.png](SNAG-0305.png)

   ![SNAG-0306.png](SNAG-0306.png)

   ![SNAG-0307.png](SNAG-0307.png)

1. Выполнено.
   ![SNAG-0308.png](SNAG-0308.png)
   По-умолчанию выделено:1024 Мб оперативной памяти, 2 процессора, жесткий диск, оптический диск, 4 Мб видеопамяти.

1. Ознакомился.
   Добавить оперативную память или ресурсы процессора можно либо через графический интерфейс **Oracle VM VirtualBox**
   ![SNAG-0310.png](SNAG-0310.png), 
   либо с помощью утилиты **VBoxManage**, например с помощью команд `VBoxManage modifyvm "Vagrant_default_1626119268140_31290" --memory 2048` и `VBoxManage modifyvm "Vagrant_default_1626119268140_31290" --cpus 4`.
   
1. Выполнено.
   ![SNAG-0311.png](SNAG-0311.png)

1. Выполнено.
   * Переменная **HISTFILESIZE**, описано на 621 строке man bash.
     ![SNAG-0316.png](SNAG-0316.png)
   * Значение ignoreboth является сокращением для ignorespace и ignoredups.
   ![SNAG-0317.png](SNAG-0317.png)  

1. Выполнено.
   
   В составных командах. Строка 206
   ![SNAG-0318.png](SNAG-0318.png) 
1. Выполнено.
   
   Командой `touch {1..100000}.txt`. 
   
   300000 создать не получилось, слишком большой список аргументов.
   ![SNAG-0319.png](SNAG-0319.png) 

1. Выполнено.
   
   Конструкция проверяет существует ли директория /tmp.
1. Выполнено.
   
   Последовательно выполнить команды:
   
   `mkdir /tmp/new_path_directory`
   
   `cp /bin/bash /tmp/new_path_directory`
   
   `sudo mkdir /usr/local/bin`
   
   `sudo cp /bin/bash /usr/local/bin`
   
   `PATH=/tmp/new_path_directory:/usr/local/bin:/bin:$PATH`
  
   ![SNAG-0319.png](SNAG-0319.png)

1. Команда `at` планирует выполнение команды в указанное время, а команда `batch` планирует выполнение команды, когда это позволяет уровень загрузки системы.

   ![SNAG-0322.png](SNAG-0322.png)
   
1. Выполнено.
   
   ![SNAG-0323.png](SNAG-0323.png)