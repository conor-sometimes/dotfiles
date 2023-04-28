#!/usr/bin/env bash
#
# install-packages-linux.sh
#
# Copyright (C) 2023 Conor McShane <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.
#

set -e pipefail
set -o errexit
set -o nounset

readonly HOST_DESKTOP="honshu"
readonly HOST_SERVER="hokkaido"
readonly HOST_MACBOOK="PY60HY3QW3"

# Define host-specific packages to install
declare -a packages_essential=( "chezmoi" "git" "git-delta" "jq" "neovim" "openssh" "ranger" "remind" "restic" "ripgrep" "task" "tmux" "zsh")
declare -a packages_server=( "docker" "docker-compose" "rtorrent" )
declare -a packages_desktop=( "bspwm" "sxhkd" "mpv" "dunst" "alacritty" "firefox" "redshift" "xrandr" "sshfs" "polybar" "xorg-xinit" "nvidia-open" )
declare -a packages_macbook=( "espanso" "pinentry-mac" "bash" "gpg" "gh")

case "$(hostname)" in
  ${HOST_SERVER})
    sudo pacman -S "${packages_essential[@]} ${packages_server[@]}"
    ;;
  ${HOST_DESKTOP})
    sudo pacman -S "${packages_essential[@]} ${packages_desktop[@]}"
    ;;
  ${HOST_MACBOOK})
    brew install "${packages_essential[@]} ${packages_macbook[@]}"
    ;;
  *)
    echo "Unknown hostname: ${HOSTNAME}"
    return 1
    ;;
esac

pip install neovim

if [[ ! -d $HOME/.local/share/chezmoi ]]; then
  chezmoi -v init https://github.com/conor-sometimes/dotfiles.git
fi

if [[ -f $HOME/.local/share/chezmoi/provision/import-gpg-keys.sh ]]; then
  sh $HOME/.local/share/chezmoi/provision/import-gpg-keys.sh
fi
