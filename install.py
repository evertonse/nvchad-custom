#!/bin/python3
import sys
import os
from pathlib import Path

if os.name == 'nt':
    nvim_path = Path(os.environ['appdata'], 'nvim')
    nvim_data_path = Path(os.environ['appdata'], 'nvim-data')
else:
    nvim_path = Path("~/.config/nvim")
    nvim_data_path = Path('~/.local/share/nvim')


def install():
    cmd = f'git clone https://github.com/NvChad/NvChad {nvim_path} --depth 1'
    os.system(cmd)


def unistall():
    if os.name == 'nt':
        cmd = 'rd -r'
    else:
        cmd = 'rm -rf'
    os.system(cmd + f' {nvim_path}')
    os.system(cmd + f' {nvim_data_path}')

def main():
    print(sys.argv)
    if sys.argv[0] == 'uninstall':
        if input('Is you show you wanna uninstall ?[y/n]') == 'y':
            print


main()
