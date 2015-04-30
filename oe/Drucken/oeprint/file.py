"""file.py: Provides functionality to manage printable files."""

__author__ = 'Jim Martens'


def get_file_path(year, directory, identifier):
    """
    Returns the file path for the given identifier.
    :type year: str
    :type directory: str
    :type identifier: str
    :rtype: str
    """
    path = directory + '/' + identifier + '/'
    version_file = open(path + 'version.txt')
    current_version = version_file.readline().strip()
    return path + year + '_' + identifier + '_V' + current_version + '.pdf'


def insert_file_paths(year, directory, files):
    """
    Manipulates the files list and adds a key named path to each object in the list.
    :type year: str
    :type directory: str
    :type files: list
    :rtype: list
    """
    file_configs = []
    for file_config in files:
        file_config['path'] = get_file_path(year, directory, file_config['identifier'])
        file_configs.append(file_config)

    return file_configs
