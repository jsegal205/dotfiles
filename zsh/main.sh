#!/usr/bin/env bash

set -e

# get some helper functions up in here
source ./utils/main.sh

##############################################

log "Setting up ZSH"

##############################################

FILE_NAME=".zshrc"
DEST_FILE=~/$FILE_NAME

log "Copying $FILE_NAME file"
cp "./zsh/$FILE_NAME" $DEST_FILE

log "Installing plugins"
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/elixir" ]; then
  git clone --depth=1 https://github.com/gusaiani/elixir-oh-my-zsh.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/elixir
fi

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/pnpm" ]; then
  git clone --depth=1 https://github.com/ntnyq/omz-plugin-pnpm.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/pnpm
fi

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
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
