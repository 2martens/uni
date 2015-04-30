"""config.py: Provides functions to read the config"""

__author__ = 'Jim Martens'

import json


class Config:
    def __init__(self, config_file):
        self.config_file = config_file
        self.config_data = self.load_json_file()

    def load_build(self, build):
        """
        Loads the data of a particular build or an empty object if no such build exists
        :type build: str
        :rtype: dict
        """
        if build in self.config_data:
            build_data = self.config_data[build]
        else:
            build_data = {}
        return build_data

    def load_json_file(self):
        """
        Loads the JSON configuration file
        :type self: config.Config
        :rtype : dict
        """
        file = open(self.config_file, 'r', encoding='utf-8')
        json_data = json.load(file)
        return json_data
