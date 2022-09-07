#!/usr/bin/env python3
		
import os

path = "~/netology/sysadm-homeworks"
abs_path = os.path.expanduser(path)
bash_command = [f"cd {abs_path}", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        mod_file = os.path.abspath(prepare_result)
        print(mod_file)