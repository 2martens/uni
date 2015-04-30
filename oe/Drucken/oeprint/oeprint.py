#!/usr/bin/python3

"""oeprint.py: The main file of the print tool"""

__author__ = 'Jim Martens'

import argparse

from config import Config


def main():
    """Main function for oeprint"""
    parser = argparse.ArgumentParser(description='Printing tool for Orientation Unit')
    parser.add_argument('build', metavar='build', help='the identifier of the build')
    parser.add_argument('prints', metavar='numberOfPrints', type=int, help='how often the build is printed')
    parser.add_argument('--printer', dest='printer', help='a valid printer name like d116_sw', default='d116_sw')
    arguments = parser.parse_args()
    config = Config('configuration/config.json')
    build_data = config.load_build(arguments.build)
    print(build_data)
    # TODO add actual functionality

if __name__ == '__main__':
    main()
