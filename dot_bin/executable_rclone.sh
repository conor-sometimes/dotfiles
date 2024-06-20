#!/usr/bin/env bash
#
# rclone.sh
#
# Copyright (C) 2024 Conor McShane <conor dot d dot mcshane at outlook dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset
set -o pipefail

case $1 in
  "pull")
    rclone sync OneDrive: ~/OneDrive
    ;;
  "push")
    rclone sync ~/OneDrive OneDrive:
    ;;
esac