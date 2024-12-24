#!/bin/bash

### Updates the scripts and Docker Compose file

source ./base_dir.sh

COMPOSE_FILE_PATH="docker-compose.yaml"

if [ ! -d "$BASE_DIR" ]; then
    echo "BASE_DIR not created. Run setup.sh first."
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install it first."
    exit 1
fi

echo "Pulling latest changes..."
git pull origin main || exit 1


echo "Pulling latest images..."
docker-compose -f "$COMPOSE_FILE_PATH" pull || exit 1

echo "Recreating containers..."
docker-compose -f "$COMPOSE_FILE_PATH" up -d || exit 1

echo "Update complete."
