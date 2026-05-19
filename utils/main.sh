#!/usr/bin/env bash

set -eo pipefail

log () {
  echo
  echo "[$(date +%F\ %H:%M:%S)]"
  echo "=== $1 ==="
}
