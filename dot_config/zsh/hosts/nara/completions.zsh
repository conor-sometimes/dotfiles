#!/usr/bin/env zsh
#
# completions.zsh
#
# Copyright (C) 2023 Conor McShane
#
# Distributed under terms of the GPLv3 license.

autoload -Uz compinit vcs_info

fpath=(
  "/run/current-system/sw/share/zsh/5.9/functions"
  "/run/current-system/sw/share/zsh/site-functions"

  "$HOME/repos/zsh-completions"
)
