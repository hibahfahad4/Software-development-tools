#!/bin/bash

# Check if a filename was provided
if [ "$#" -ne 1 ]; then
    echo "Error: Please provide exactly one filename."
    exit 1
fi

# Filename to check
filename="$1"

# Check if the file exists
if [ -e "$filename" ]; then
    echo "The file exists."

    # Check if the file is readable
    if [ -r "$filename" ]; then
        echo "The file is readable."
    else
        echo "The file is not readable."
    fi
else
    echo "The file does not exist."
fi
