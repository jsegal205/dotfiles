#!/usr/bin/env bash

set -e

# get some helper functions up in here
source ./utils/main.sh

##############################################

log "Setting up Languages via ASDF"

##############################################

ASDF_PLUGINS=(
  "elixir https://github.com/asdf-vm/asdf-elixir.git"
  "erlang https://github.com/asdf-vm/asdf-erlang.git"
  "nodejs https://github.com/asdf-vm/asdf-nodejs.git"
  "python"
)

log "Installing asdf plugins"
for asdf_plugin in "${ASDF_PLUGINS[@]}"; do
  asdf plugin-add "$asdf_plugin"
done

export KERL_CONFIGURE_OPTIONS="--without-javac --with-ssl=$(brew --prefix openssl)"

FILE_NAME=".tool-versions"
DEST_FILE=~/$FILE_NAME

log "Copying $FILE_NAME file"
cp "./asdf/$FILE_NAME" $DEST_FILE

log "Installing asdf language versions"
asdf install
