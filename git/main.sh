#!/usr/bin/env bash

set -eo pipefail

# get some helper functions up in here
source ./utils/main.sh

##############################################

log "Setting up Git"

##############################################

FILE_NAME=".gitconfig"
DEST_FILE=~/$FILE_NAME

log "Copying $FILE_NAME file"
cp "./git/$FILE_NAME" $DEST_FILE

##############################################

log "Installing GPG commit-signing helpers"

mkdir -p ~/.local/bin
cp ./git/gpg-helpers/check-pinentry-stuck ~/.local/bin/check-pinentry-stuck
chmod +x ~/.local/bin/check-pinentry-stuck

cp ./git/gpg-helpers/find-stuck-gpg-modal-process ~/find-stuck-gpg-modal-process
chmod +x ~/find-stuck-gpg-modal-process

cp ./git/gpg-helpers/will-git-commit-prompt-gpg ~/will-git-commit-prompt-gpg
chmod +x ~/will-git-commit-prompt-gpg

mkdir -p ~/.git-hooks-global
cp ./git/gpg-helpers/pre-commit ~/.git-hooks-global/pre-commit
chmod +x ~/.git-hooks-global/pre-commit

git config --global core.hooksPath ~/.git-hooks-global
