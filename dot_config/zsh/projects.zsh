#!/usr/bin/env zsh
#
# projects.zsh
#
# Copyright (C) 2024 Conor McShane <conor dot d dot mcshane at outlook dot com>
#
# Distributed under terms of the GPLv3 license.
#

declare -A PROJECTS=(
    ["$HOME/projects/personal/cv"]="ppc"
    ["$HOME/projects/personal/health"]="pph"
    ["$HOME/projects/personal/payload"]="ppp"
    ["$HOME/projects/personal/payload-example-package"]="pppe"

    ["$HOME/projects/work/ems-rust"]="pwer"
    ["$HOME/projects/work/scripts"]="pwes"

    ["$HOME/projects/libs/conor-lib"]="plc"
    ["$HOME/projects/libs/equinix-lib"]="ple"

    ["$HOME/.local/share/chezmoi"]="cz"
    ["$HOME/wiki"]="wiki"
)

# Iterate over projects and check for unpushed and unpulled changes
for REPO in "${(k)PROJECTS[@]}"; do
  if [[ -d "$REPO/.git" ]]; then
    # Check for unpushed changes
    if [[ $(git -C "$REPO" status --porcelain) ]]; then
      alias "${PROJECTS[$REPO]}"="cd ${REPO}"
      echo "Unpushed changes in: $REPO (${PROJECTS[$REPO]})"
    fi
    # Check for unpulled changes
    if [[ $(git -C "$REPO" rev-list HEAD..origin/main --count) -gt 0 ]]; then
      echo "Unpulled changes in: $REPO (${PROJECTS[$REPO]})"
      # git -C "$REPO" pull
    fi
  else
    echo "$REPO is not a Git repository"
  fi
done
