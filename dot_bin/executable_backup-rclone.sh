#!/usr/bin/env bash
#
# backup-rclone.sh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

rclone sync --progress --delete-excluded ~/important/ onedrive:backup --filter-from "$HOME/.config/rclone/filter"
