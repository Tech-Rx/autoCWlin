#!/bin/bash

# Directory containing Python scripts
SCRIPT_DIR="/root/scripts"

# Iterate through all .py files in the directory and execute them
for script in "$SCRIPT_DIR"/*.py; do
    if [[ -f "$script" ]]; then
        echo "Running $script"
        /usr/bin/python3 "$script"
    fi
done
