# Домашнее задание к занятию "3.4. Операционные системы, лекция 2"  
  
1. Скачал node_exporter и разархивировал, скопировал исполняемый файл в директорию /usr/local/bin.  
   ![SNAG-0817.png](SNAG-0817.png)  
   
   Создал внешний файл конфигурации `/etc/default/node_exporter`.  
   ![SNAG-0818.png](SNAG-0818.png)  
   
   Создал файл службы systemd.  
   ![SNAG-0819.png](SNAG-0819.png)  
   
   Добавил службу в автозагрузку командой `sudo systemctl enable node_exporter.service`, перезагрузил виртуалку vagrant, проверил автозагрузку, остановку, запуск сервиса.  
   ![SNAG-0821.png](SNAG-0821.png)  
   
   Systemd будет подгружать переменные окружения при старте node_exporter из файла `/etc/default/node_exporter`, а параметры запуска искать в переменной OPTIONS.  
   ![SNAG-0822.png](SNAG-0822.png)  
   
1. Пробросил порт 9100 на хостовую машину.  
   Ознакомился с опциями node_exporter и выводом /metrics по-умолчанию.  
   ![SNAG-0823.png](SNAG-0823.png)  
   Для базового мониторинга выбрал бы опции:  
   - CPU:  
    node_cpu_seconds_total  
	node_pressure_cpu_waiting_seconds_total  
    process_cpu_seconds_total  
    
   - Memory:  
    node_memory_MemAvailable_bytes  
    node_memory_MemFree_bytes  
	node_memory_MemTotal_bytes  
	node_memory_Buffers_bytes  
	node_memory_Cached_bytes  
	node_memory_SwapCached_bytes  
	node_memory_SwapFree_bytes  
	node_memory_SwapTotal_bytes  
    
   - Disk:  
    node_disk_io_time_seconds_total  
	node_disk_read_bytes_total  
    node_disk_read_time_seconds_total  
	node_disk_writing_bytes_total  
    node_disk_write_time_seconds_total  
    
   - Network:  
    node_network_receive_bytes_total  
	node_network_receive_errs_total  
    node_network_transmit_bytes_total  
    node_network_transmit_errs_total  
	node_network_transmit_packets_total  
   
1. Установил Netdata, внес изменения в конфигурационный файл  `/etc/netdata/netdata.conf`  
   ![SNAG-0829.png](SNAG-0829.png)  
   
   Добавил в Vagrantfile проброс порта Netdata на свой локальный компьютер  
   ![SNAG-0830.png](SNAG-0830.png)  
   
   Ознакомился с метриками Netdata  
   ![SNAG-0831.png](SNAG-0831.png)  
   
1. Да, можно. На это указывают параметры `Booting paravirtualized kernel on KVM` и `systemd[1]: Detected virtualization oracle`.  
   ![SNAG-0832.png](SNAG-0832.png)  
   
1. По-умолчанию `1048576`.  
   ![SNAG-0833.png](SNAG-0833.png)  
   
   Это параметр максимального числа открытых дескрипторов.  
   Другой существующий лимит, который  не позволит достичь такого числа `ulimit -Hn`.  
   ![SNAG-0835.png](SNAG-0835.png)  
   
1. Выполнено.  
   ![SNAG-0836.png](SNAG-0836.png)  
   
1. Это fork-бомба, которая порождает большое количество собственных копий и тем самым пытается заполнить свободное место в списке активных процессов операционной системы.  
   Запустил.  
   ![SNAG-0837.png](SNAG-0837.png)  
   
   Судя по выводу `dmesg` стабилизации помог механизм `cgroups` – это механизм ядра, позволяющий ограничивать использование, вести учет и изолировать потребление системных ресурсов.  
   ![SNAG-0838.png](SNAG-0838.png).  
   
   Число процессов, которое можно создать в сессии задается в файле `pids.max` для каждой подсистемы группы.  
   ![SNAG-0840.png](SNAG-0840.png).  