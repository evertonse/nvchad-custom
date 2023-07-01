#!/bin/python3
import sys
import os
from pathlib import Path
from shutil import copytree as copydir, rmtree as rmdir


if os.name == 'nt':
    nvim_path = Path(os.environ['localappdata'], 'nvim')
    nvim_data_path = Path(os.environ['localappdata'], 'nvim-data')
else:
    nvim_path = Path(f'{Path.home()}', '.config/nvim')
    nvim_data_path = Path(f'{Path.home()}', '/.local/share/nvim')


def install():
    if nvim_path.exists():
        if input(f' [setup] {nvim_path.absolute()} already exists do you wanna delete it ? [y/n] ') == 'y':
            rmdir(nvim_path)
        else:
            exit(0)
    cmd = f'git clone https://github.com/NvChad/NvChad {nvim_path} --depth 1'
    os.system(cmd)

    try :
        copydir(Path('./'), Path(nvim_path, 'lua/custom' ) )
    except Exception as e:
        print(f'An exception occurred {e}')


def unistall():
    try:
        print(f'removing {nvim_path}')
        rmdir(nvim_path)
    except Exception as e:
        print(f'An exception occurred when trying to remove {nvim_path} {e}')
    try:
        print(f'removing {nvim_data_path}')
        rmdir(nvim_data_path)
    except:
        print(f'An exception occurred when trying to remove {nvim_path} {e}')

def usage():
    print('usage: ./setup.py [install|uninstall]')

def main():

    if len(sys.argv) < 2:
        usage()
        exit(1)
    if sys.argv[1] == 'uninstall':
        if input('Is you show you wanna uninstall ?[y/n]') == 'y':
            unistall()
    elif sys.argv[1] == 'install':
        install()
    else:
        usage()
main()

