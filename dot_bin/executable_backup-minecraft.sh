#!/usr/bin/env bash
#
# backup-minecraft.sh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

source "$HOME/.bin/functions.sh"

# $HOME/.bin/functions.sh@44
if ! check_host "$HOKKAIDO"; then
  echo "Host is not online, aborting..."
  exit 1
fi

export RESTIC_REPOSITORY="/run/mount/citadel/backup/"
export RESTIC_PASSWORD_COMMAND="pass backup/honshu"
export TEMPDIR="/tmp/minecraft"

echo "Creating tempdir"
if [[ ! -d "$TEMPDIR" ]]; then
  mkdir -p "$TEMPDIR"
fi

# pull files from the server
echo "Pulling files from server"
rsync -Pa \
  --exclude-from="$HOME/.config/rsync/exclude-minecraft" \
  hokkaido:"$HOME/docker/minecraft/" "$TEMPDIR" #--dry-run

# if citadel is mounted
if mountpoint -q "$CITADEL"; then
  restic -v backup --host "Docker" --tag "Minecraft" "$TEMPDIR" --cleanup-cache --no-cache
  restic forget --host "Docker" --keep-last 5
else
  echo "$CITADEL is NOT mounted, aborting..."
  exit 1
fi

echo "Removing $TEMPDIR"
rm -rf "$TEMPDIR"
