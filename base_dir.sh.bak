#!/bin/bash

# Copy this file to base_dir.sh

### Set the base directory for all services
# Usage: source base_dir.sh
# Meant to be sourced in other scripts to set the base directory
# For macos / is read only so we use /Users/Shared/data
# For linux /data is used
# Change this to your desired directory based on your OS


OS_TYPE=$(uname)

if [[ "$OS_TYPE" == "Linux" ]]; then
    export BASE_DIR="/data"
elif [[ "$OS_TYPE" == "Darwin" ]]; then
    export BASE_DIR="/Users/Shared/data"
else
    echo "Unsupported OS: $OS_TYPE"
    exit 1
fi
echo "BASE_DIR is set to $BASE_DIR"
