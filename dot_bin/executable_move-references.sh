#!/usr/bin/env bash
#
# move-references.sh
#
# Copyright (C) 2022 dindybutts <dind#7958>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

export VAULT="$HOME/Hobbies/Art/"
export REFERENCE_WINDOWS="/mnt/Users/dind/Downloads/images/"
export REFERENCE_LINUX="/home/dind/Hobbies/Art/plain/study/references/images/"

if [ -d "/mnt/Users" ] && [ -w /mnt/ ]; then
  echo "Windows is mounted"
else
  echo "Windows is not mounted"
  exit 1
fi

if [[ ! -d "$VAULT/plain" ]]; then
  mkdir -p "$VAULT/plain"
fi

echo "Unlocking $VAULT"
pass gocryptfs/art | gocryptfs "$VAULT/encrypted" "$VAULT/plain"

if [[ -d "$REFERENCE_WINDOWS" ]]; then
  echo "Renaming files..."
  sh "$HOME/.bin/hash-rename.sh" "$REFERENCE_WINDOWS"
  if [[ -d "$REFERENCE_LINUX" ]]; then
    echo "Moving files..."
    mv "$REFERENCE_WINDOWS"* "$REFERENCE_LINUX"
  fi
fi

echo "Locking $VAULT"
fusermount -u "$VAULT/plain"

if ! mountpoint -q "$VAULT/plain"; then
  rmdir "$VAULT/plain"
fi
