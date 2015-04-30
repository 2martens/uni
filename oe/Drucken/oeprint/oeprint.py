#!/usr/bin/python3
import argparse


def main():
    """Main function for oeprint"""
    parser = argparse.ArgumentParser(description='Printing tool for Orientation Unit')
    parser.add_argument('build', metavar='build', help='the identifier of the build')
    parser.add_argument('prints', metavar='numberOfPrints', type=int, help='how often the build is printed')
    parser.add_argument('--printer', dest='printer', help='a valid printer name like d116_sw', default='d116_sw')
    arguments = parser.parse_args()
    # TODO add actual functionality

if __name__ == '__main__':
    main()
