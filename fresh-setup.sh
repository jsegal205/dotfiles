#!/usr/bin/env bash

set -e

# get some helper functions up in here
source ./utils/main.sh

# log "Updating permission to execute files in $(pwd)"
chmod -R 755 ..

# Order of these scripts is important

# apple setup
./apple/main.sh

# homebrew setup
./brew/main.sh

# asdf setup
./asdf/main.sh

# vim setup
./vim/main.sh

# zsh setup
./zsh/main.sh

# vscode setup
./vscode/main.sh

# # should fix compdef errors like:
# # ` compdef: unknown command or service: rails `
# rm -f ~/.zcompdump*; compinit

log "Completed setup"
cat ./manual-steps.md
