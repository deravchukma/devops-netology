#!/usr/bin/env python3

import os
import sys

if len(sys.argv) < 2:
    path = "~/netology/sysadm-homeworks"
    abs_path = os.path.expanduser(path)
else:
    abs_path = sys.argv[1]
bash_command = [f"cd {abs_path}", "git status 2>&1"]
result_os = os.popen(' && '.join(bash_command)).read()
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        mod_file = os.path.abspath(prepare_result)
        print(mod_file)
    elif result.find('fatal: not a git repository') != -1:
        print('Error: ' + abs_path + ' - not a git repository')