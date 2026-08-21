#!/usr/bin/env bash

set -eo pipefail

# get some helper functions up in here
source ./utils/main.sh

##############################################

log "Exporting GPG keys for manual transfer to another machine"

##############################################

PERSONAL_UID="Jim Segal <jsegal205@gmail.com>"
AGENT_UID="Jim Segal (agents) <jsegal205+agents@gmail.com>"
BACKUP_DIR="./gpg/backup"

mkdir -p "$BACKUP_DIR"

export_key () {
  local uid="$1"
  local slug="$2"

  log "Exporting $uid"
  gpg --armor --export "$uid" > "$BACKUP_DIR/$slug-public.asc"
  gpg --armor --export-secret-keys "$uid" > "$BACKUP_DIR/$slug-private.asc"
  chmod 600 "$BACKUP_DIR/$slug-private.asc"
}

export_key "$PERSONAL_UID" "personal"
export_key "$AGENT_UID" "agents"

log "Done"

echo "$BACKUP_DIR/*-private.asc contain private key material - handle with care."
echo "They're gitignored. Move them to the other machine yourself (AirDrop/USB), then there run:"
echo "  gpg --import <file>-private.asc"
echo "and delete the local copies in $BACKUP_DIR once you're done."
