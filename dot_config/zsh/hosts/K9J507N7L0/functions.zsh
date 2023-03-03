#!/usr/bin/env zsh
#
# functions.zsh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

push_all_remotes() {
  if [ -d ".git" ]; then
    git remote | xargs -i zsh -c 'echo Pushing to ${COLOR_CYAN}{}${COLOR_NC} && git push {} master'
  else
    echo "${COLOR_YELLOW}Current directory is not a git repo!${COLOR_NC}"
  fi
}

# Updates remote dotfiles
update_remote() {
  ssh hokkaido 'git -C $HOME/dotfiles pull'
}

# remote_attach hokkaido
remote_attach() {
  ssh -t $1 'tmux attach'
}

# usage:
# ta tech "delete browser history"
ta() {
  if [ $# -eq 0 ]; then
    echo "Usage:"
    echo "ta work \"Do stuff\""
    return 1
  fi
  if [[ -v $3 ]]; then
    task add +$1 $2 depends:$3
  else
    task add +$1 $2
  fi
}
