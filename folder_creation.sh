#!/bin/bash

### Creates folders for Usenet and/or Torrent downloads
# Usage: folder_creation.sh [install_type] [service1, service2, ...]
# Designed for dockerized setup so the containers can 
# be passed the same host directory as a volume bind mount
# This way docker sees it as one file system and can make direct changes instead of C+P
# See more: https://trash-guides.info/File-and-Folder-Structure/How-to-set-up/Docker/
function create_usenet_folders {
    echo "Creating Usenet folders in $BASE_DIR"
    if [ -d "$BASE_DIR/usenet" ]; then
        echo "Usenet folder already exists, skipping"
        return
    fi
    mkdir -p "$BASE_DIR"/usenet/{incomplete,complete/{books,movies,music,tv}} || exit 1
}

function create_torrent_folders {
    echo "Creating Torrent folders in $BASE_DIR"
    if [ -d "$BASE_DIR/torrents" ]; then
        echo "Torrent folder already exists, skipping"
        return
    fi
    mkdir -p "$BASE_DIR"/torrents/{books,movies,music,tv} || exit 1
}

function create_appdata_folders {
    echo "Creating AppData folders in $BASE_DIR for services: $SERVICES"
    
    for service in $(echo $SERVICES | tr "," "\n"); do
        if [ -d "$BASE_DIR/appdata/$service" ]; then
            echo "$service folder already exists, skipping"
            continue
        fi
        mkdir -p "$BASE_DIR/appdata/$service"/{data,log,cache} || exit 1
    done
}

function set_permissions {
    echo "Setting permissions for $BASE_DIR"
    sudo chown -R $USER:$(id -gn $USER) $BASE_DIR || exit 1
    sudo chmod -R a=,a+rX,u+w,g+w $BASE_DIR || exit 1
}


if [ -z "$BASE_DIR" ]; then
    echo "Set BASE_DIR environment variable before running this script."
    exit 1
fi

if [ -z "$1" ]; then
    INSTALL_TYPE="full"
else
    INSTALL_TYPE="$1"
fi

if [ -z "$2" ]; then
    SERVICES="radarr,sonarr,sabnzbd,jellyfin,jellyseerr"
else
    SERVICES="$2"
fi

echo "Creating folders for $INSTALL_TYPE installation in $BASE_DIR"

if [ ! -d "$BASE_DIR" ]; then
    echo "$BASE_DIR does not exist, creating it now"
    mkdir -p "$BASE_DIR" || exit 1
fi

case $INSTALL_TYPE in
    full)
        create_usenet_folders
        create_torrent_folders
        ;;
    usenet)
        create_usenet_folders
        ;;
    torrent)
        create_torrent_folders
        ;;
    *)
        echo "Invalid installation type: $INSTALL_TYPE"
        exit 1
        ;;
esac

create_appdata_folders
set_permissions

echo "Folders created successfully"
