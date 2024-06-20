#!/usr/bin/env bash
#
# rotate-ssh-keys.sh
#
# Copyright (C) 2024 Conor McShane <conor dot d dot mcshane at outlook dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset
set -o pipefail

TEMP_DIR=$(mktemp -d)
echo "Created temporary directory: ${TEMP_DIR}"

# Firstly we need to generate 4 new SSH keys and 2 yubikey keys
# We'll focus non-yubikey keys first for simplicity
declare -a key_names=(
"desktop"
"laptop"
"server"
"handeld"
)

for key_name in "${key_names[@]}"; do
  # Generate the key pair
  ssh-keygen -q -C "keys/ssh/${key_name}/github" -f "${TEMP_DIR}/${key_name}" -N ""

  # Output the public key to stdout
  echo "${TEMP_DIR}/${key_name}"
  echo "/keys/ssh/${key_name}/github"
  cat "${TEMP_DIR}/${key_name}.pub"

  # Until you can edit attributes of an entry in keepassxc-cli, this is basically just guesswork
  # But it's a good mental model for what needs to be done
  # keepassxc-cli edit --attributes "/keys/ssh/desktop/github" --set-attribute "public" --value "$(cat "${TEMP_DIR}/${key_name}.pub")"
  # keepassxc-cli edit --attributes "/keys/ssh/desktop/github" --set-attribute "private" --value "$(cat "${TEMP_DIR}/${key_name}")"
done
