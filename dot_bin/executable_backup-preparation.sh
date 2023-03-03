#!/usr/bin/env bash
#
# backup-preparation.sh
#
# Copyright (C) 2022 dindybutts <dind#7958>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

declare -a VAULTS=(
"$HOME/Hobbies/Art"
"$HOME/important/2FA"
"$HOME/important/docker"
"$HOME/important/documents"
"$HOME/important/gpg"
"$HOME/important/practice"
)

for VAULT in "${VAULTS[@]}"; do

  if [[ -d $VAULT/plain ]]; then
    if mountpoint -q "$VAULT/plain" ; then

      echo "Unmounting: $VAULT/plain"
      fusermount -u "$VAULT/plain"

      echo "Removing: $VAULT/plain"
      rmdir "$VAULT/plain"
    else
      rmdir "$VAULT/plain"
    fi
  fi

done

if mountpoint -q "$HOME/mount"; then
  echo "Unmounting: $HOME/mount"
  sudo umount "$HOME/mount"
fi

if mountpoint -q "$HOME/sshfs"; then
  echo "Unmounting: $HOME/sshfs"
  fusermount -u "$HOME/sshfs"
fi
