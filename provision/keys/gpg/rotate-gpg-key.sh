#!/usr/bin/env bash
#
# rotate-gpg-key.sh
#
# Copyright (C) 2024 Conor McShane <conor dot d dot mcshane at outlook dot com>
#
# Distributed under terms of the GPLv3 license.

set -o errexit
set -o nounset
set -o pipefail

# WARNING:
# This script is a work in progress and is not yet complete
# It is not recommended to use this script until it is complete
# ASSUME THE WORST
# ASSUME THIS SCRIPT WILL DELETE YOUR GPG KEY
# YOU HAVE BEEN WARNED

# We should never have to rotate the GPG key, but if we do we'll need to follow a
# few steps to ensure that the new key is properly rotated and the old key is deleted

# NOTE:
# Until we get keepassxc-cli edit attributes all we can do right now is generate
# a new key, print the details, and then manually update the KeePassXC database
# then prompt the user if they updated the database
#
# So all in all we'll need to do the following:
# 1 - Generate a new GPG key using the gpg-key-gen.conf file
#    `gpg --batch --generate-key gpg-key-gen.conf`
#    `keepassxc-cli edit --generate --length 72 --lower --upper --numeric --special /Users/cmcshane/Onedrive/secrets.kdbx "keys/gpg/master"`
#    `keepassxc-cli edit --username $GPG_KEY_ID /Users/cmcshane/Onedrive/secrets.kdbx "keys/gpg/master"`
#
# 2 - Print the details of the new key (key ID, fingerprint, public key, private key, trust)
#   2.1 - Print key ID (attribute: username) Will need to be manually updated in KeePassXC database
#     2.1.1 TODO Do we need secret ID or public ID?, I'll consult chatgpt on this one...
#   2.2 - Print public key (attribute: public) `gpg --armor --export "$GPG_KEY_ID"`
#   2.3 - Print private key (attribute: private) `gpg --armor --export-secret-keys "$GPG_KEY_ID"`
#   2.4 - Print trust (attribute: trust) `gpg --export-ownertrust`
#
# 3 - Prompt the user to update the KeePassXC database with the new information
#
# 4 - When the user has updated the KeePassXC database, prompt the user to delete the old key
#    `keepassxc-cli rm "$KEEPASS_DB" "keys/gpg/master"`
#    `gpg --delete-secret-and-public-keys "$OLD_KEY_ID"`
#
# NOTE: This is a manual step for now as keepassxc-cli can't rename entries yet?
# 6 - Rename the new key in the KeePassXC database to the old key (master)
#
# 7 - Prompt the user to update the key in their .chezmoidata file which should propagate to all other files via
#    templates

# First lets ask the user if they want to rotate the key
echo "Do you want to rotate your GPG key? (y/n)"
echo "Keep in mind this will make your old key unusable and ruin all your signed git commits"
read -r -n 1 ROTATE
case $ROTATE in
  y|Y)
    echo "Rotating GPG key..."
    ;;
  *)
    echo "Exiting..."
    exit 0
    ;;
esac
