#!/usr/bin/env bash
# vim: set ft=sh:
#
# copy-secrets.sh
#
# Copyright (C) 2024 Conor McShane <conor dot d dot mcshane at outlook dot com>
#
# Distributed under terms of the GPLv3 license.

# Relies on:
# rsync

set -o errexit
set -o nounset
set -o pipefail

echo "Copying secrets.kdbx to $1"
rsync -avz "$HOME/Onedrive/secrets.kdbx" "$1:/home/conor/Onedrive/secrets.kbdx"
