#!/usr/bin/env bash

set -e

# get some helper functions up in here
source ./utils/main.sh

##############################################

log "Setting up ZSH"

##############################################

FILE_NAME=".zshrc"
DEST_FILE=~/$(echo $FILE_NAME)

log "Copying $FILE_NAME file"
cp "./zsh/$(echo $FILE_NAME)" $DEST_FILE

log "Setting custom Zsh theme"
cp -rf "./zsh/jsegal_theme.zsh-theme" "$ZSH/custom/themes/jsegal_theme.zsh-theme"

log "Installing Powerline Fonts"
# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
