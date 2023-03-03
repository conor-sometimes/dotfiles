#!/usr/bin/env bash
#
# update-system.sh
#
# Copyright (C) 2021 dindybutts
#
# Distributed under terms of the GPLv3 license.

source "$HOME"/.bin/functions.sh
# functions.sh provides:
# check_dependency

sudo pacman -Qtdq | sudo pacman -Rns -

if check_dependency paru; then
  paru -Syu
  paru -Sccd
else
  sudo pacman -Syyu
fi

# diff any .pacnew's
sudo DIFFPROG="nvim -d" pacdiff

if check_dependency nvim; then
  nvim -c 'PlugUpdate'
fi

if check_dependency git; then
  if [ -d "${HOME}"/dotfiles ]; then
    echo "Updating $HOME/dotfiles/home submodules"
    git -C "$HOME"/dotfiles/home/ submodule update --recursive --remote
  fi
fi

# sort out repos
if [ -d "${HOME}"/repos ]; then
  if [ ! -d "${HOME}"/repos/zsh-completions ]; then
    git clone https://github.com/zsh-users/zsh-completions "$HOME"/repos/zsh-completions
  fi
fi

# update repos
for FOLDER in "$HOME"/repos/* ; do
  cd "$FOLDER" && git pull
done

#clean.sh

# unmounts mountpoints and closes all vaults
backup-preparation.sh

# backup docker files from remote server
backup-docker.sh

# backup gpg related files
backup-gpg.sh

# backs up minecraft container
backup-minecraft.sh

# backs up all vaults to onedrive
backup-rclone.sh

# backs up system
backup-restic.sh
