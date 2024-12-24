#!/bin/bash
COMPOSE_FILE_PATH="docker-compose.yaml"

function check_docker_compose_installation {
    if ! command -v docker-compose &> /dev/null; then
        echo "Docker Compose is not installed. Please install it first."
        exit 1
    fi
}

function start_services {
    if [ ! -f "$COMPOSE_FILE_PATH" ]; then
        echo "Compose file not found at $COMPOSE_FILE_PATH. Exiting."
        exit 1
    fi
    
    echo "Starting Docker Compose services..."
    docker-compose -f "$COMPOSE_FILE_PATH" up -d
    if [ $? -eq 0 ]; then
        echo "Services started successfully."
    else
        echo "Failed to start services. Check Docker Compose logs for details."
        exit 1
    fi
}

function check_services {
    echo "Checking Docker Compose service statuses..."
    docker-compose -f "$COMPOSE_FILE_PATH" ps
}

check_docker_compose_installation
start_services
check_services
