#!/usr/bin/env bash
#
# backup-restic.sh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

export RESTIC_REPOSITORY="/run/mount/citadel/backup/"
export RESTIC_PASSWORD_COMMAND="pass backup/honshu"

if mountpoint -q "$CITADEL"; then
  restic -v backup --host "Honshu" --tag "Backup" "$HOME" --exclude-file "$HOME"/.config/restic/exclude

  # keep the last 20 backups, duh
  restic forget --host "Honshu" --keep-last 10
else
  echo "$CITADEL is NOT mounted, aborting..."
fi
