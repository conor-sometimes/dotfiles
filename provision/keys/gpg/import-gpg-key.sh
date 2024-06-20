#!/usr/bin/env bash
#
# import-gpg-key.sh
#
# Copyright (C) 2024 Conor McShane <conor dot d dot mcshane at outlook dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset
set -o pipefail

# Define the path to your KeePassXC database
KEEPASS_DB="$HOME/Onedrive/secrets.kdbx"
KEEPASS_GPG_KEY_PATH="keys/gpg/master"

read -r -s -p "Enter KeePassXC password: " KEEPASS_PASSWORD
echo

GPG_KEY_ID=$(echo "$KEEPASS_PASSWORD" | keepassxc-cli show -q --attributes "username" "$KEEPASS_DB" "$KEEPASS_GPG_KEY_PATH")
echo "GPG Key ID: $GPG_KEY_ID"

# Check if the GPG key is already imported
if gpg --list-secret-keys --keyid-format LONG "$GPG_KEY_ID" &> /dev/null; then
  echo "GPG key '$GPG_KEY_ID' is already imported. Skipping import."
else

  # Get the passphrase for the GPG key
  echo "Getting passphrase for $GPG_KEY_ID"
  PASSPHRASE=$(echo "$KEEPASS_PASSWORD" | keepassxc-cli show -q --show-protected --attributes "password" "$KEEPASS_DB" "$KEEPASS_GPG_KEY_PATH")

  # Import the key using the passphrase
  echo "Importing $GPG_KEY_ID"
  echo "$KEEPASS_PASSWORD" | keepassxc-cli show -q --show-protected --attributes "private" "$KEEPASS_DB" "$KEEPASS_GPG_KEY_PATH" | gpg --batch --yes --passphrase "$PASSPHRASE" --import

  # Import the ownertrust from the KeePassXC database
  echo "Importing ownertrust for $GPG_KEY_ID"
  echo "$KEEPASS_PASSWORD" | keepassxc-cli show -q --show-protected --attributes "trust" "$KEEPASS_DB" "$KEEPASS_GPG_KEY_PATH" | gpg --import-ownertrust
fi
