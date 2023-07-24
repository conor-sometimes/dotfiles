#!/usr/bin/env zsh
#
# completions.zsh
#
# Copyright (C) 2023 Conor McShane
#
# Distributed under terms of the GPLv3 license.

autoload -Uz compinit vcs_info

fpath=(
  "/usr/share/zsh/site-functions"
  "/usr/share/zsh/functions"
  "/usr/share/zsh/functions/Calendar"
  "/usr/share/zsh/functions/Chpwd"
  "/usr/share/zsh/functions/Completion"
  "/usr/share/zsh/functions/Completion/Base"
  "/usr/share/zsh/functions/Completion/Linux"
  "/usr/share/zsh/functions/Completion/Unix"
  "/usr/share/zsh/functions/Completion/X"
  "/usr/share/zsh/functions/Completion/Zsh"
  "/usr/share/zsh/functions/Exceptions"
  "/usr/share/zsh/functions/Math"
  "/usr/share/zsh/functions/MIME"
  "/usr/share/zsh/functions/Misc"
  "/usr/share/zsh/functions/Newuser"
  "/usr/share/zsh/functions/Prompts"
  "/usr/share/zsh/functions/TCP"
  "/usr/share/zsh/functions/VCS_Info"
  "/usr/share/zsh/functions/VCS_Info/Backends"
  "/usr/share/zsh/functions/Zftp"
  "/usr/share/zsh/functions/Zle"

  "$HOME/repos/zsh-completions"
)
