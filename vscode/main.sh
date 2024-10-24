#!/usr/bin/env bash

set -e

# get some helper functions up in here
source ./utils/main.sh

##############################################

log "Setting up VSCode"

##############################################

log "Copying VSCode settings"
FILE_NAME="settings.json"
cp ./vscode/$FILE_NAME $HOME/Library/Application\ Support/Code/User/$FILE_NAME
