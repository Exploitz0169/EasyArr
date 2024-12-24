#!/bin/bash

### Initial setup process
# Usage: setup.sh
# Can change the BASE_DIR in base_dir.sh to set the base directory for all services

source ./base_dir.sh

FOLDER_CREATION_SCRIPT="./folder_creation.sh"
START_SERVICES_SCRIPT="./start_services.sh"


function set_permissions {
    echo "Setting executable permissions on the scripts..."
    chmod +x "$FOLDER_CREATION_SCRIPT"
    chmod +x "$START_SERVICES_SCRIPT"
}


function run {
    echo "Running folder creation script..."
    "$FOLDER_CREATION_SCRIPT"
    
    if [ $? -ne 0 ]; then
        echo "Folder creation script failed. Exiting."
        exit 1
    fi
    
    echo "Running start services script..."
    "$START_SERVICES_SCRIPT"
    
    if [ $? -ne 0 ]; then
        echo "Start services script failed. Exiting."
        exit 1
    fi
}

# Main logic
set_permissions
run
echo "All scripts executed successfully."
