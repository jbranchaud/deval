"""
dirify.py

This script will create a specified directory structure. The directory
structure can be specified (primarily) in a YAML file or passed in
programmatically.
"""

import sys
import os
import os.path
import yaml

# globals
DIRSTRUCTURE = "DirectoryStructure"
DIRBASE = "base"
DIRNAME = "name"
SUBDIRS = "subs"

def main(args):
    """
    main

    this function will grab the path of the file specified as a command-line
    argument and invoke the necessary functions to create the directory
    structure specified in that YAML file.
    """
    if len(args) < 1:
        print("You have not provided a YAML file.")
        sys.exit(1)

    # grab the filename which should be the first argument
    filename = args[0]

    # check that the given file exists
    if not check_file(filename):
        print("You have not provided a valid file, try again.")
        sys.exit(1)

    directory_structures = grab_directory_structure(filename)

    # assume there is only 1 directory structure to create
    directory_structure = directory_structures[0]

    # grab the base and the structure dictionary
    base = directory_structure[DIRBASE]
    structure = directory_structure['structure']

    # make sure we have the absolute base path
    base = expand_path(base)

    directory_list = build_directory_list(base, structure)

    for directory in directory_list:
        create_directory(directory)

def create_directory_structure(config_file):
    """
    create_directory_structure

    given the path to a YAML configuration file that contains information
    for a directory structure, this function will go through and the
    information to generate the specified directory structure.
    """
    # check that the given file exists
    if not check_file(config_file):
        print("You have not provided a valid file, try again.")
        sys.exit(1)

    # extract the directory structure info from the file
    directory_structures = grab_directory_structure(config_file)

    # assume there is only 1 directory structure to create
    directory_structure = directory_structures[0]

    # grab the base and the structure dictionary
    base = directory_structure[DIRBASE]
    structure = directory_structure['structure']

    # make sure we have the absolute base path
    base = expand_path(base)

    directory_list = build_directory_list(base, structure)

    for directory in directory_list:
        create_directory(directory)
    
def build_directory_list(base, structure):
    """
    build_directory_list

    given the path (base) that this directory structure should be rooted in,
    this function will go through and enumerate a list of all the absolute
    paths specified in the structure map.
    """
    directory_list = []

    for directory in structure:
        dir_name = directory[DIRNAME]
        # add this directory and then add the subdirectories
        dir_name = base + os.path.sep + dir_name
        directory_list.append(dir_name)
        if SUBDIRS in directory:
            dir_subs = directory[SUBDIRS]
            directory_list.extend(build_directory_list(dir_name, dir_subs))

    return directory_list

def create_directory(dir_path):
    """
    create_directory

    given the path for a directory, this function will use the os
    module to create a directory at that path. First though, there will be a
    check to see if the directory already exists. If it does exist, then
    this function will simply return without doing anything.
    """
    if os.path.exists(dir_path) and os.path.isdir(dir_path):
        return

    # otherwise, let's just create the directory
    os.mkdir(dir_path)

def grab_directory_structure(filename):
    """
    grab_directory_structure

    this function will access the YAML content for the given filename and
    grab the portion of the document that contains the DirectoryStructure
    information.
    """
    stream = file(filename, 'r')
    document = yaml.load(stream)

    # Check if DirectoryStructure is contained in the document
    if not DIRSTRUCTURE in document.keys():
        return {}
    
    # DirectoryStructure is contained in YAML file, so grab and return
    return document[DIRSTRUCTURE]

def expand_path(path):
    """
    expand_path

    given a path that may be relative or made of environment variables, this
    function will expand all of it so that it is a nice, absolute path.
    """
    abspath = os.path.expandvars(path)
    abspath = os.path.expanduser(abspath)
    abspath = os.path.abspath(abspath)
    return abspath

def check_file(filename):
    """
    check_file

    this function checks that the given filename exists and refers to an
    actual file.
    """
    return os.path.exists(filename) and os.path.isfile(filename)

if __name__ == "__main__":
    main(sys.argv[1:])
