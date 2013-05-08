"""
YAMLtoProperties.py

This script is going to take a YAML file and generate a .properties file
equivalent for it. The YAML file needs to be restricted to top-level single
associations and top-level lists. Anthing else beyond that or more nested
than that is not going to map to a .properties file.
"""

import sys
import os.path
import yaml

PROPERTIES_NAME = "propertiesname"
PROPERTIES = "properties"

def main(args):
    """
    main

    this function is the main function which will take a single argument
    that represents the path of a YAML file with properties information that
    needs to be converted to a .properties file.
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

    # first, grab the contents of the YAML file
    stream = file(filename, 'r')
    document = yaml.load(stream)

    # grab the name for this properties file
    properties_name = document[PROPERTIES_NAME]

    # if the properties name doesn't end in .properties, then add it
    if not properties_name.endswith('.properties'):
        properties_name += '.properties'

    # now grab the list of properties
    properties = document[PROPERTIES]

    # open the file and write the properties to it
    f = file(properties_name, 'w')
    for prop in properties:
        if isinstance(prop, dict):
            add_item(f,prop)

def add_item(f, item):
    """
    add_item

    given an open file and a list item from the YAML properties file, this
    function will write the item to the file by using the key and the value
    in the form: key=value
    """
    item_key = item.keys()[0]
    item_value = item.values()[0]
    if isinstance(item_value, list):
        item_value = ",\\\n".join(item_value)
    f.write("%s=%s\n" % (item_key,item_value))

def check_file(filename):
    """
    check_file

    essentially, check that the file exists and is a file and return the
    appropriate boolean.
    """
    return os.path.exists(filename) and os.path.isfile(filename)

if __name__ == "__main__":
    main(sys.argv[1:])
