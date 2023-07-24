#!/usr/bin/env bash
#
# import-keys.sh
#
# Copyright (C) 2023 Conor McShane
#
# Distributed under terms of the GPLv3 license.
#

set -o errexit
set -o nounset
set -o pipefail

readonly HOST_DESKTOP="honshu"
readonly HOST_SERVER="hokkaido"
readonly HOST_MACBOOK="PY60HY3QW3"

readonly GPG_KEY_NAME="unified"
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
    gpg --import <<< $(age -d encrypted_dotfiles-encrypted.gpg.age)
  done
}

case "$HOSTNAME" in
  "$HOST_MACBOOK")
    GPG_PUBLIC_KEYS=(
      "$REPO_DIR/provision/gpg/public/unified.pub"
      "$REPO_DIR/provision/gpg/public/dotfiles.pub"
      "$REPO_DIR/provision/gpg/public/work.pub"
    )

    # work bitwarden
    gpg --import <<< $(age -d "$REPO_DIR"/provision/gpg/private/encrypted_dotfiles.gpg.age)
    echo "92ADF15FA1065EA23B45BE32F7DD77A0EB212928:6:" | gpg --import-ownertrust
    ;;
  "$HOST_SERVER")
    GPG_PUBLIC_KEYS=(
      "$REPO_DIR/provision/gpg/public/unified.pub"
      "$REPO_DIR/provision/gpg/public/dotfiles.pub"
    )

    SSH_KEYS=(
      "$REPO_DIR/dot_ssh/keys/public/macbook.pub"
      "$REPO_DIR/dot_ssh/keys/public/desktop-yubikey.pub"
    )

    add_ssh_key_to_authorized_keys "${SSH_KEYS[@]}"

    ;;
  # "$HOST_DESKTOP")
    # ;;
  *)
    echo "Unknown host: $HOSTNAME"
    exit 1
    ;;
esac


echo "Importing dotfiles gpg key"
gpg --decrypt "$REPO_DIR/provision/gpg/private/dotfiles.asc.gpg" | gpg --import
gpg --import "$REPO_DIR/provision/gpg/public/dotfiles.pub"
echo "87598FB224CE55A319D461BC092543F7A4AFB15F:6:" | gpg --import-ownertrust


import_gpg_public_keys "${GPG_PUBLIC_KEYS[@]}"

# import unified gpg key
gpg --decrypt "$REPO_DIR/provision/gpg/private/${GPG_KEY_NAME}.gpg" | gpg --import
# readonly GPG_KEY_NAME="encrypted_unified"

# update trust of key
echo "$GPG_KEY_TRUST" | gpg --import-ownertrust
