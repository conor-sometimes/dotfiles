#!/usr/bin/env bash
#
# backup-rclone.sh
#
# Copyright (C) 2022 dindybutts <dind#7958>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

rclone sync --progress --delete-excluded ~/important/ onedrive:backup --filter-from "$HOME/.config/rclone/filter"
