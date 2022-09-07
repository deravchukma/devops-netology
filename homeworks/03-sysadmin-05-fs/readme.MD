# Домашнее задание к занятию "3.5. Файловые системы"  
  
1. Изучил. Может применятся для экономии дискового пространства при резервном копировании, хранении образов дисков виртуальных машин. Но может привести к большой фрагментации файловой системы.  
   ![SNAG-0842.png](SNAG-0842.png)  
   
1. Не могут, не смотря на то что жесткая ссылка это отдельный файл, он имеет тот же inode и набор разрешений что и у исходного файла.  
   ![SNAG-0843.png](SNAG-0843.png)     
   
1. Выполнил `vagrant destroy`  
   ![SNAG-0844.png](SNAG-0844.png)  
   
   Заменил содержимое в Vagrantfile.  
   ![SNAG-0845.png](SNAG-0845.png)  
   
   Запустил виртуалку.  
   ![SNAG-0846.png](SNAG-0846.png)  
   
   Вывод lsblk:  
   ![SNAG-0847.png](SNAG-0847.png)  
   
1. Выполнил.  
   ![SNAG-0848.png](SNAG-0848.png)  
   
1. Выполнил.  
   ![SNAG-0849.png](SNAG-0849.png)  
   
   Вывод fdisk -l:  
   ![SNAG-0850.png](SNAG-0850.png)  
   
   Вывод lsblk:  
   ![SNAG-0851.png](SNAG-0851.png)  
   
1. Выполнено.  
   ![SNAG-0852.png](SNAG-0852.png)  
   
   Вывод lsblk:  
   ![SNAG-0853.png](SNAG-0853.png)  
   
1. Выполнено.  
   ![SNAG-0854.png](SNAG-0854.png)  
   
   Вывод lsblk:  
   ![SNAG-0855.png](SNAG-0855.png)  
   
1. Выполнено.  
   ![SNAG-0856.png](SNAG-0856.png)  
   
   Вывод pvs:  
   ![SNAG-0857.png](SNAG-0857.png)  
   
1. Выполнено.  
   ![SNAG-0858.png](SNAG-0858.png)  
   
   Вывод vgdisplay:  
   ![SNAG-0860.png](SNAG-0860.png)  
   
1. Выполнено.  
   ![SNAG-0862.png](SNAG-0862.png)  
   
   Вывод lvs:  
   ![SNAG-0863.png](SNAG-0863.png)  
   
1. Выполнено.  
   ![SNAG-0864.png](SNAG-0864.png)  
   
1. Выполнено.  
   ![SNAG-0865.png](SNAG-0865.png)  
   
1. Выполнено.  
   ![SNAG-0866.png](SNAG-0866.png)  
   
1. Вывод lsblk:  
   ![SNAG-0867.png](SNAG-0867.png)  
   
1. Выполнено.  
   ![SNAG-0868.png](SNAG-0868.png)  
   
1. Выполнено.  
   ![SNAG-0869.png](SNAG-0869.png)  
   
   Вывод lsblk:  
   ![SNAG-0870.png](SNAG-0870.png)  
   
1. Выполнено.  
   ![SNAG-0871.png](SNAG-0871.png)  
   
   Вывод mdadm -D:  
   ![SNAG-0872.png](SNAG-0872.png)  
   
1. Выполнено.  
   ![SNAG-0873.png](SNAG-0873.png)  
   
1. Выполнено.  
   ![SNAG-0874.png](SNAG-0874.png)  
   
1. Выполнено.  
   ![SNAG-0875.png](SNAG-0875.png)  