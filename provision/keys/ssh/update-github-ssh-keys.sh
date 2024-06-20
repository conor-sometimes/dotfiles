#!/usr/bin/env bash
#
# update-github-ssh-keys.sh
#
# Copyright (C) 2024 Conor McShane <conor dot d dot mcshane at outlook dot com>
#
# Distributed under terms of the GPLv3 license.

set -o nounset
set -o pipefail

KEEPASS_DB="$HOME/Onedrive/secrets.kdbx"
KEEPASS_PATHS=(
  "keys/ssh/laptop/github"
  "keys/ssh/desktop/github"
  "keys/ssh/handheld/github"
  "keys/ssh/server/github"
)

# Get the IDs of all SSH keys
echo "Getting all SSH key IDs..."
IDS=$(gh ssh-key list | grep -oE '\b[0-9]{5,10}\b')

# Loop through each ID and delete the corresponding SSH key
for ID in $IDS; do
  gh ssh-key delete "$ID" -y
  echo "Deleted SSH key with ID: $ID"
done

read -r -s -p "Enter KeePassXC password: " KEEPASS_PASSWORD

# Loop through each KeePassXC path and add the SSH key to GitHub
echo "Adding SSH keys to GitHub..."
for KEEPASS_PATH in "${KEEPASS_PATHS[@]}"; do
  echo "$KEEPASS_PASSWORD" | keepassxc-cli show -q --attributes "public" "$KEEPASS_DB" "$KEEPASS_PATH" | gh ssh-key add
  echo "Added SSH key from KeePassXC path: $KEEPASS_PATH"
done
