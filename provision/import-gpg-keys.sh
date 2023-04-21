#!/usr/bin/env bash
#
# import-gpg-keys.sh
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

readonly REPO_DIR="$HOME/.local/share/chezmoi"

KEY=""
GPG_OWNER_TRUST=""

add_ssh_key() {
  public_key="$1"
  if ! grep -qxF "$public_key" ~/.ssh/authorized_keys; then
    echo "Adding public key to authorized_keys file"
    echo "$public_key" >> ~/.ssh/authorized_keys
  fi
}

add_ssh_keys() {
  for key_file in "$@"; do
    echo "adding $key_file"
    public_key=$(< "$key_file")
    if ! grep -qxF "$public_key" ~/.ssh/authorized_keys; then
      echo "Adding public key from $key_file to authorized_keys file"
      echo "$public_key" >> ~/.ssh/authorized_keys
    fi
  done
}

case "$HOSTNAME" in
  $HOST_MACBOOK)
    echo "Macbook"
    KEY="macbook"
    GPG_OWNER_TRUST="C59E2EA148098193BEEEE42087BFE2E84FE74F61:6:"
    gpg --import "$REPO_DIR/provision/gpg/public/yubikey-public-key.asc" "$REPO_DIR/provision/gpg/public/server-public-key.asc"
    ;;

  $HOST_SERVER)
    echo "Server"
    KEY="server"
    GPG_OWNER_TRUST="7032F7F9BC73C52B99956EB1F79E4AE90F072A31:6:"
    gpg --import "$REPO_DIR/provision/gpg/public/yubikey-public-key.asc" "$REPO_DIR/provision/gpg/public/macbook-public-key.asc"

    echo "adding ssh key"
    add_ssh_keys "$REPO_DIR/dot_ssh/macbook.pub"
    ;;

  $HOST_DESKTOP)
    echo "Desktop"
    KEY="desktop"
    gpg --import "$REPO_DIR/provision/gpg/public/yubikey-public-key.asc" "$REPO_DIR/provision/gpg/public/server-public-key.asc"
    ;;
esac

gpg --decrypt "$REPO_DIR/provision/gpg/private/${KEY}-private-key.gpg.asc" | gpg --import
echo "$GPG_OWNER_TRUST" | gpg --import-ownertrust
