#!/bin/bash

# this shell script sets up your local environment to work with DEVAL

# check that DEVALSUB has been set
echo $DEVALSUB
if [ -z "$DEVALSUB" ]
then
    echo "Please set the environment variable DEVALSUB to the directory that
    you would like DEVAL to use when setting up evaluation subjects."
    exit 1
else
    echo "The DEVALSUB directory is set to $DEVALSUB"
fi

# create the directory for DEVALSUB if it doesn't already exist
if [ ! -d $DEVALSUB ]
then
    mkdir -p $DEVALSUB
    echo "Created $DEVALSUB"
fi


