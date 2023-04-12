#!/usr/bin/env zsh
#
# completions.zsh
#
# Copyright (C) 2023 Conor McShane <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

autoload -Uz compinit vcs_info

fpath=(
  "/usr/share/zsh/5.9/functions"
  "/usr/share/zsh/5.9/site-functions"

  "$HOME/repos/zsh-completions"
)
