#!/usr/bin/env bash
#
# brew.sh
#
# Copyright (C) {{ .copyright_year }} Conor McShane <conor dot d dot mcshane at outlook dot com>
#
# Distributed under terms of the GPLv3 license.

echo "This is a brew wrapper script"

# Call the original brew command
/opt/homebrew/bin/brew "$@"

# Check if the first argument is 'install'
if [[ "$1" == "install" ]]; then
    # Update the brew-packages.txt file
    echo "Updating brew-packages.txt"
    brew leaves -r > "$HOME/.local/share/chezmoi/provision/mac/brew-packages.txt"
fi
