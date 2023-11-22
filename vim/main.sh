# !/usr/bin/env bash

set -e

# get some helper functions up in here
source ./utils/main.sh

##############################################

log "Setting up Vim"

##############################################

FILE_NAME=".vimrc"
log "Copying $FILE_NAME file"
cp "./vim/$(echo $FILE_NAME)" ~/$(echo $FILE_NAME)
