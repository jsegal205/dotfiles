#!/usr/bin/env bash

set -e

# get some helper functions up in here
source ./utils/main.sh

##############################################

log "Setting up Git"

##############################################

FILE_NAME=".gitconfig"
DEST_FILE=~/$FILE_NAME

log "Copying $FILE_NAME file"
cp "./git/$FILE_NAME" $DEST_FILE
