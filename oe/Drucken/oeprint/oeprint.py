#!/usr/bin/python3

"""oeprint.py: The main file of the print tool"""

__author__ = 'Jim Martens'

import argparse
import sys

from config import Config
from file import *


def main():
    """Main function for oeprint"""
    year = '2015'

    parser = argparse.ArgumentParser(description='Printing tool for Orientation Unit')
    parser.add_argument('build', metavar='build', help='the identifier of the build')
    parser.add_argument('prints', metavar='numberOfPrints', type=int, help='how often the build is printed')
    parser.add_argument('--printer', dest='printer', help='a valid printer name like d116_sw', default='d116_sw')
    arguments = parser.parse_args()
    config = Config('configuration/config.json')
    build_data = config.load_build(arguments.build)
    if build_data:
        build_data['files'] = insert_file_paths(year, 'files', build_data['files'])
        print(build_data)
    else:
        print('Invalid build', file=sys.stderr)
    # TODO add actual functionality

if __name__ == '__main__':
    main()
