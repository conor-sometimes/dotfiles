#!/usr/bin/env bash
#
# import-keys.sh
#
# Copyright (C) 2023 Conor McShane <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset
set -o pipefail

readonly HOST_DESKTOP="honshu"
readonly HOST_SERVER="hokkaido"
readonly HOST_MACBOOK="PY60HY3QW3"

readonly GPG_KEY_NAME="encrypted_unified"
readonly GPG_KEY_TRUST="F86191F6CF88CCE1D908775633A923AB357604B2:6:"

readonly REPO_DIR="$HOME/.local/share/chezmoi"

add_ssh_key_to_authorized_keys() {
  for KEYFILE in "$@"; do
    if [ -e "$KEYFILE" ]; then
      if ! grep -qxF "$( < "$KEYFILE")" ~/.ssh/authorized_keys; then
        echo "Adding public key from $KEYFILE to authorized_keys file"
        cat "$KEYFILE" >> ~/.ssh/authorized_keys
      else
        echo "Public key from $KEYFILE already in authorized_keys file"
      fi
    else
      echo "Error: file $KEYFILE not found"
    fi
  done
}

import_gpg_public_keys() {
  for PUBKEY in "$@"; do
    gpg --import "$PUBKEY"
  done
}

case "$HOSTNAME" in
  "$HOST_MACBOOK")
    echo "MACBOOK"
    GPG_PUBLIC_KEYS=(
      "$REPO_DIR/provision/gpg/public/unified.pub"
      "$REPO_DIR/provision/gpg/public/work.pub"
    )
    gpg --decrypt "$REPO_DIR/provision/gpg/private/encrypted_work.asc" | gpg --import
    ;;
  "$HOST_SERVER")
    SSH_KEYS=(
      "$REPO_DIR/dot_ssh/keys/public/macbook.pub"
      "$REPO_DIR/dot_ssh/keys/public/desktop-yubikey.pub"
    )

    add_ssh_key_to_authorized_keys "${SSH_KEYS[@]}"

    GPG_PUBLIC_KEYS=(
      "$REPO_DIR/provision/gpg/public/unified.pub"
    )
    ;;
  # "$HOST_DESKTOP")
    # ;;
  *)
    echo "Unknown host: $HOSTNAME"
    exit 1
    ;;
esac

import_gpg_public_keys "${GPG_PUBLIC_KEYS[@]}"

# import unified gpg key
gpg --decrypt "$REPO_DIR/provision/gpg/private/${GPG_KEY_NAME}.asc" | gpg --import

# update trust of key
echo "$GPG_KEY_TRUST" | gpg --import-ownertrust
