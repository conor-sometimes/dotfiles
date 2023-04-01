#!/usr/bin/env bash
#
# install-packages-linux.sh
#
# Copyright (C) 2023 Conor McShane <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset

# Define essential packages to install on all hosts
declare -a essentials=(
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

# Define host-specific packages to install
declare -A host_packages=(
	["hokkaido"]="docker docker-compose rtorrent"
	["honshu"]="bspwm sxhkd mpv dunst alacritty firefox redshift xrandr sshfs polybar xorg-xinit nvidia-open github-cli"
	["K9J507N7L0"]="gh python"
)

# Install essential packages on all hosts
sudo pacman -S --needed "${essentials[@]}"

# Install host-specific packages based on hostname
case "${HOSTNAME}" in
	"hokkaido")
		sudo pacman -S "${host_packages[hokkaido]}"

    pip3 install pynvim
		;;
	"honshu")
		# Install paru package manager
		sudo pacman -S --needed base-devel
		git clone https://aur.archlinux.org/paru.git
		cd paru
		makepkg -si

		# Install host-specific packages
		sudo pacman -S "${host_packages[honshu]}"

    pip3 install pynvim
		;;
	"K9J507N7L0")
		# Install Homebrew package manager
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

		# Install host-specific packages
		brew install "${host_packages[K9J507N7L0]}"
		pip3 install pynvim
		;;
	*)
		echo "Unknown hostname: ${HOSTNAME}" >&2
		exit 1
		;;
esac
