#!/usr/bin/env bash

set -e

# get some helper functions up in here
source ./utils/main.sh

##############################################

log "Setting up Languages via ASDF"

##############################################

ASDF_PLUGINS=(
  "erlang https://github.com/asdf-vm/asdf-erlang.git"
  "elixir https://github.com/asdf-vm/asdf-elixir.git"
  "nodejs https://github.com/asdf-vm/asdf-nodejs.git"
  "python"
)

log "Installing asdf plugins"
for asdf_plugin in "${ASDF_PLUGINS[@]}"; do
  asdf plugin-add "$asdf_plugin"
done

KERL_CONFIGURE_OPTIONS="--without-javac --with-ssl=$(brew --prefix openssl@1.1)"
export KERL_CONFIGURE_OPTIONS

versions_file="./asdf/.tool-versions"
while read -r asdf_version; do
  log "Installing $asdf_version"

  asdf install "$asdf_version"
  asdf global "$asdf_version"
done < "$versions_file"
