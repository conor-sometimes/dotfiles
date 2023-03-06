#!/usr/bin/env bash
#
# bootstrap.sh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

sudo pacman -S pass restic

set -o errexit
set -o nounset

echo "Did you log into bitwarden"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) firefox "https://vault.bitwarden.com";;
    esac
done

echo "Did you log into Onedrive?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) firefox "https://onedrive.live.com/about/en-us/signin/";;
    esac
done

echo "Did you download the folder called 'backup'?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) break;;
        No ) echo "Well then do it, idiot, make sure you download it to $HOME";;
    esac
done

if [[ -f "$HOME/backup.zip" ]]; then
  aunpack "$HOME/backup.zip"
else
  echo "YOU LIED, DOWNLOAD IT TO $HOME"
fi

make -C $HOME/backup/gpg decrypt-bootstrap
gpg --import $HOME/backup/gpg/plain/private.key

export PASSWORD_STORE_DIR="$HOME/backup/gpg/plain/password-store"
manage-drives.sh "m" "bastion" "fd9d1ac2-8531-4f73-9e3a-548b7d800394" "$(pass drives/bastion)"
manage-drives.sh "m" "citadel" "a3d66160-665d-4c0f-829b-7c4234f8d345" "$(pass drives/citadel)"

make -C $HOME/backup/gpg decrypt-bootstrap

export RESTIC_PASSWORD_COMMAND="pass backup/honshu"
restic -r /var/run/mount/citadel/backup/ restore --target "/" --host "Honshu"
sudo restic -r /var/run/mount/citadel/backup/ restore latest --target "/home/dind/mount/" --host "Honshu"
