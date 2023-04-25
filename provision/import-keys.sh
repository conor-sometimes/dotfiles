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
echo "$HOSTNAME"

readonly REPO_DIR="$HOME/.local/share/chezmoi"
echo "Bash version: $BASH_VERSION"


declare -A info=(
  ["GPG_KEY_NAME"]=""
  ["GPG_KEY_TRUST"]=""
  ["SSH_KEYS"]=""
  ["GPG_PUBLIC_KEYS"]=""
)


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
  $HOST_MACBOOK)
    echo "MACBOOK"
    info["GPG_KEY_NAME"]="macbook-private"
    info["GPG_KEY_TRUST"]="C59E2EA148098193BEEEE42087BFE2E84FE74F61:6:"
    ;;

  $HOST_SERVER)
    info["GPG_KEY_NAME"]="server-private"
    info["GPG_KEY_TRUST"]="7032F7F9BC73C52B99956EB1F79E4AE90F072A31:6:"

    info["SSH_KEYS"]=(
      "$REPO_DIR/dot_ssh/keys/macbook-public.pub"
      "$REPO_DIR/dot_ssh/keys/desktop-yubikey-public.pub"
    )

  info["GPG_PUBLIC_KEYS"]=(
    "$REPO_DIR/provision/gpg/public/macbook-public-key.asc"
    "$REPO_DIR/provision/gpg/public/server-public-key.asc"
    #"$REPO_DIR/provision/gpg/public/desktop-public-key.asc"
  )
;;

$HOST_DESKTOP)
  info["GPG_KEY_NAME"]="PLACEHOLDER_PLACEHOLDER"
  info["GPG_KEY_TRUST"]="PLACEHOLDER_PLACEHOLDER"
  ;;
esac

if [[ -v info["SSH_KEYS"] ]]; then
  add_ssh_key_to_authorized_keys "${info["SSH_KEYS"][@]}"

fi

import_gpg_public_keys "${info["GPG_PUBLIC_KEYS"][@]}"

# import private key for host

gpg --decrypt "$REPO_DIR/provision/gpg/private/${info["GPG_KEY_NAME"]}.gpg.asc" | gpg --import

# update trust of key
echo "${info["GPG_OWNER_TRUST"]}" | gpg --import-ownertrust
