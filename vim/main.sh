#!/usr/bin/env bash

set -e

# get some helper functions up in here
source ./utils/main.sh

##############################################

log "Setting up Vim"

##############################################

FILE_NAME=".vimrc"
log "Copying $FILE_NAME file"
cp "./vim/$FILE_NAME" ~/$FILE_NAME
