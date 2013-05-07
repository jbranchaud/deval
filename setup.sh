#!/bin/bash

# this shell script sets up your local environment to work with DEVAL

# boolean for missing environment variables
missing_vars=0

# check that DEVAL has been set
if [ -z "$DEVAL" ]
then
    echo "Please set the environment variable DEVAL to the top-level
    directory of DEVAL. This is likely the directory that this shell script
    is being run from."$'\n'
    missing_vars=1
else
    echo "The DEVAL directory is set to $DEVAL"$'\n'
fi

# check that DEVALSUB has been set
if [ -z "$DEVALSUB" ]
then
    echo "Please set the environment variable DEVALSUB to the directory that
    you would like DEVAL to use when setting up evaluation subjects."$'\n'
    missing_vars=1
else
    echo "The DEVALSUB directory is set to $DEVALSUB"$'\n'
fi

if [ "$missing_vars" == 1 ]
then
    echo "Exiting because of missing environment variable(s)."$'\n'
    exit 1
fi

# create the directory for DEVALSUB if it doesn't already exist
if [ ! -d $DEVALSUB ]
then
    mkdir -p $DEVALSUB
    echo "Created $DEVALSUB"
fi


