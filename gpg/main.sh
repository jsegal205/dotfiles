#!/usr/bin/env bash

set -eo pipefail

# get some helper functions up in here
source ./utils/main.sh

##############################################

log "Setting up GPG keys"

##############################################

# Rename these here if you ever want different identities.
PERSONAL_UID="Jim Segal <jsegal205@gmail.com>"
AGENT_UID="Jim Segal (agents) <jsegal205+agents@gmail.com>"
KEY_EXPIRY="2y"

generate_key_if_missing () {
  local uid="$1"

  if gpg --list-secret-keys "$uid" >/dev/null 2>&1; then
    log "Key already exists for $uid, skipping"
  else
    log "Generating ed25519 key for $uid (you'll be prompted for a passphrase)"
    gpg --quick-generate-key "$uid" ed25519 cert,sign "$KEY_EXPIRY"
  fi
}

generate_key_if_missing "$PERSONAL_UID"
generate_key_if_missing "$AGENT_UID"

##############################################

log "Pointing git at the personal key"

##############################################

GITCONFIG=~/.gitconfig
PERSONAL_KEY_ID=$(gpg --list-secret-keys --keyid-format=long "$PERSONAL_UID" | awk '/^sec/{print $2}' | cut -d'/' -f2)

if [ -f "$GITCONFIG" ] && grep -q "signingkey" "$GITCONFIG"; then
  sed "s/signingkey = .*/signingkey = $PERSONAL_KEY_ID/" "$GITCONFIG" > "$GITCONFIG.tmp"
  mv "$GITCONFIG.tmp" "$GITCONFIG"
  log "Set signingkey = $PERSONAL_KEY_ID in $GITCONFIG"
else
  log "No signingkey line found in $GITCONFIG - run git/main.sh first, then re-run this"
fi

##############################################

log "Configuring gpg-agent"

##############################################

mkdir -p ~/.gnupg
chmod 700 ~/.gnupg
cp ./gpg/gpg-agent.conf ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent || true

##############################################

log "Public keys - add these to GitHub > Settings > SSH and GPG keys"

##############################################

echo
echo "--- Personal ($PERSONAL_UID) ---"
gpg --armor --export "$PERSONAL_UID"

echo
echo "--- Agents ($AGENT_UID) ---"
gpg --armor --export "$AGENT_UID"
