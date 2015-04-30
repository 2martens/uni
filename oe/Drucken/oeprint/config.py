"""config.py: Provides functions to read the config"""

__author__ = 'Jim Martens'

import json


class Config:
    def __init__(self, config_file):
        self.config_file = config_file
        self.config_data = self.load_json_file()

    def load_build(self, build):
        """
        Loads the data of a particular build
        :type build: str
        :rtype: object
        """
        build_data = self.config_data[build]
        return build_data

    def load_json_file(self):
        """
        Loads the JSON configuration file
        :type self: config.Config
        :rtype : object
        """
        file = open(self.config_file, 'r', encoding='utf-8')
        json_data = json.load(file)
        return json_data
