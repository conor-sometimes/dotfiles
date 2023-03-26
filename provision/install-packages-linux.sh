#!/usr/bin/env bash
#
# install-packages-linux.sh
#
# Copyright (C) 2023 Conor McShane <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

ESSENTIALS=(
	"age"
	"git"
	"git-delta"
	"jq"
	"neovim"
	"openssh"
	"ranger"
	"remind"
	"restic"
	"ripgrep"
	"task"
	"tmux"
	"zsh"
)

if [ "$HOSTNAME" = "hokkaido"]; then
  sudo pacman -S docker docker-compose rtorrent
fi

if [ "$HOSTNAME" = "honshu"]; then
  # install paru
  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si

  sudo pacman -S ${ESSENTIALS[*]} bspwm sxhkd mpv dunst alacritty firefox redshift xrandr sshfs polybar xorg-xinit nvidia-open github-cli python-pip
  pip3 install pynvim
fi


if [ "$HOSTNAME" = "K9J507N7L0"]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew install ${ESSENTIALS[*]} gh python
  brew install python
  pip3 install pynvim
fi
