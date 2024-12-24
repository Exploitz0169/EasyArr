#!/bin/bash
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
