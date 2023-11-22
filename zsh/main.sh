# !/usr/bin/env bash

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

if [[ $(arch) == 'arm64' ]]; then
  log "Adding Apple Silicon brew path to rc file"

  echo \\n\# Apple silicon homebrew path >> $DEST_FILE
  echo export PATH=\"/opt/homebrew/bin:\$PATH\" >> $DEST_FILE
else
  log "Adding Apple intel brew path to rc file"

  echo \\n\# Apple intel homebrew path >> $DEST_FILE
  echo export PATH=\"/usr/local/bin:\$PATH\" >> $DEST_FILE
fi

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
