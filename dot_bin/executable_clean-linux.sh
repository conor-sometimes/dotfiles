#!/usr/bin/env bash
#
# clean-linux.sh
#
# Copyright (C) 2023 conor-sometimes <conor dot d dot mcshane at gmail dot com>
#
# Distributed under terms of the GPLv3 license.

set -o nounset
shopt -s extglob

source "$HOME"/.bin/functions.sh
# functions.sh provides:
# check_dir
# check_dependency

# moves the files to the trash
if ! check_dependency trash-put; then
  echo "Error: trash-put is not installed, exiting..."
  exit 1
fi

# Three directories/files per line
declare -a home=(
".Natron" ".cmake" "Desktop"
".ViberPC" ".ts3client" ".vimperator"
".xournal" ".uml" ".w3m"
".texlive" ".adobe" ".macromedia"
".pki" ".nv" ".zenmap"
".podcasts" ".ssr" "openttd"
".xombrero" ".xonotic"
".bash_history" ".subversion" "emacs"
".bashrc" ".node-gyp" ".z"
".gitkraken" ".wine" ".gnome"
".assaultcube" ".kde4" ".icons"
".wallpapers" ".themes" ".stack"
".nano" ".godot" "kdenlive"
".thumbnails" ".lesshst" ".gimp*"
".python_history" ".emacs.d" ".ZeroBraneStudio"
".newsboat/history.search" ".newsboat/history.cmdline" ".aMule"
".plugins" ".atom" ".qfc"
".npm" ".nylas" "Downloads"
".vscode" ".couchpotato" ".elinks"
".gdrive" ".dripcap" "Lightworks"
".wxcam" ".mplayer" ".surf"
".gstreamer-0.10" ".minetest" ".tasque.log"
".cpan" ".git-radar" ".lnav"
".pylint.d" ".wget-hsts" ".proselint"
".vim" ".cathook" ".flowblade"
".mangatux" ".wapiti" "rsf_history"
".spacemacs" ".CLion2018.3" ".openarena"
".audacity-data" ".deflemask" ".designer"
"CLion2018.3" ".ddd" ".gnome2"
".IdeaIC2018.1" ".eaglemode" ".cmake"
".renpy" ".mono" ".swt"
"*.log" "*~" ".*~"
".*.tmp" "*.filelist" "goutputstream-*"
".mpdscribble" ".lldb" ".zkbd"
".vscode-oss" ".parsec" ".tig_history"
".prefs" ".lyrics" ".torrc"
".var" ".sc_history" ".viminfo"
".zcompdump" ".xournalpp" "sherlock"
".ghidra" ".anydesk" ".tor-browser"
".nuget"
)

declare -a cache=(
"thumbnails" "ImageMagick" "zim"
"openbox" "gegl-0.2" "Google"
"Atom" "gstreamer-1.0" "chromium"
"webkit" "mozilla" "ctrlp"
"tomboy" "vimb" "aria2"
"gitg" "pip" "wine" "winetricks"
"qt_compose_*" "libvirt" "ranger"
"fontforge" "gnome-boxes" "lollypop"
"lollypop_info" "qutebrowser" "bower"
"kdenlive" "babl" "g_ir_scanner"
"Python-Eggs" "spotify" "xml"
"babl" "sxiv" "pip"
"g-ir-scanner" "xm1" "minetest"
"rofi-pass" "qBittorrent" "fontconfig"
"stremio" "qtshadercache" "lutris"
"babl" "google-chrome-unstable" "vlc"
"warsow-2.1" "Zeal" "mc"
"peek" "go-build" "gegl-0.3"
"hackspeed.cache" "gegl-0.4" "glances"
"keybase" "rtorrent" "pacaur"
"qt_compose_*" "*.kcache" "ksycoca*"
"event-sound-*" "*.log" "wesnoth"
"Meltytech" "kdenlive*" "tlauncher"
"omf" "mesa_shader_cache" "inkscape"
"fwupd" "kitty" "vim"
"transmission" "radare2" "krita"
"borg" "mypaint" "XCPF"
"gimp" "ffsend" "mopidy"
"fractal" "qtshadercache-x86_64-little_endian-lp64" "cantata"
"czkawka" "cool-retro-term" "workspaceclient"
"thunderbird" "Yubico" "gitui"
"paru/clone/tor-browser" "yarn" "bazel"
"huiontablet" "JNA"
)

declare -a config=(
"INRIA" "deadbeef" "autostart"
"obs-studio/logs" "TagSpaces" "geany"
"menus" "chromium" "gpick"
"pcmanfm" "libfm" "cef_user_data"
"Atom" "sublime-text-3" "vifm"
"ON4QZ" "keepassx" "KeePass"
"Felony" "micro" "fontforge"
"configstore" "GitKraken" "PCSX2"
"qutebrowser" "tox" "ahoviewer"
"gnome-boxes" "brave" "torrench"
"libvirt" "StardewValley" "cef_user_data"
"gnome-builder" "doublecmd" "mc"
"lemonbuddy" "thefuck" "tomboy"
"QtProject.conf" "Trolltech.conf" "codef00.com"
"Atom" "inkscape" "Epic"
"pcmanfm" "aseprite" "broot"
"cef_user_data" "libvirt" "moeditor"
"etcher" "QtProject" "zim"
"Nylas N1" "enchant" "codeblocks"
"transmission" "wireshark" "Dripcap"
"Gitter" "kdeglobals" "kdenliverc"
"vlc" "Black Screen" "xml"
"asciinema" "tasque" "xm1"
"ghostwriter" "Haroopad" "ntfy"
"blockify" "google-chrome" "Helio"
"AimTux" "AimTuxGH" "clerk"
"epiphany" "evolution" "gnome-session"
"goa-1.0" "mcomix" "nautilus"
"Projucer" "hub" "SubDownloader"
"neofetch" "autostart" "spek"
"stremio" "riot" "subtitleeditor"
"lutris" "VeraCrypt" "keepassxc"
"qBittorrent" "Riot" "Zeal"
"Code" "Dharkael" "discordcanary"
"flexget" "LarusStone" "sourcetrail"
"Typora" "Trolltech" "galculator"
"ToothAndTail" ".mono" "google-chrome-unstable"
"etcher-electron" "key-mon" "MuseScore"
"ocrfeeder" "citra-emu" "screenkey.json"
"emaildefaults" "Cutter" "Meltytech"
"gitahead.com" "jesseduffield" "unity3d"
"desmume" "mypaint" "PulseEffects"
"karboncalligraphyrc" "tabletdblocalrc" "creeperworld3"
"kitty" "Code - OSS" "IJHack"
"tagaini.net" "boram" "projectM"
"cava" "keybase" "gconf"
"radare2" "projectM" "teamviewer"
"cantata" "cmus" "discord-rpc"
"Electron" "Element" "gitui"
"jgit" "procps" "Google"
)

declare -a share=(
"INRIA" "applications" "desktop-directories"
"xorg" "vifm" "icons"
"gnome-builder" "gvfs-metadata" "tomboy"
"coala" "bower" "babl"
"gegl-0.4" "webkitgtk" "webkit"
"qutebrowser" "gnome-boxes" "sonic-visualiser"
"feral-interactive" "lollypop" "multimc5"
"codeblocks" "RecentDocuments" "stalefiles"
"kdenlive" "knewstuff3" "vlc"
"magneticod" "mkxp" "SVP4"
"ntfy" "meld" "folks"
"evolution" "epiphany" "folks"
"nautilus" "mcomix" "iic"
"sounds" "telepathy" "tracker"
"keyrings" "gnome-shell" "gnome-settings-daemon"
"gegl-0.3" "tracker" "libgweather"
"epiphany" "evolution" "flatpak"
"Zeal" "lutris" "data/Tagaini Jisho"
"icc" "node-steamuser" "Starbreeze"
"JetBrains" "FasterThanLight"
"VVVVVV" "torrench" "krita"
"applications/*.desktop" "warsow-2.1" "gegle-0.4"
"nvim/site/autoload/*.old" "data/Mega Limited"
"Meltytech" "Ofi Labs" "mc"
"doc" "vulkan" "GitExtensions"
"hydrus" "mypaint" "google-web-designer"
"SHENZHEN IO" "Ripcord" "devildaggers"
"inxi" "keybase" "radare2"
"RadareOrg" "remmina" "gopass"
"eguidemoapps" "NuGet" "Google"
)

for i in "${home[@]}"; do
  if [ -e "$HOME"/"$i" ]; then
    echo "Removing $HOME/$i"
    trash-put "$HOME"/"$i" > /dev/null 2>&1
  fi
done

for i in "${cache[@]}"; do
  if [ -e "$HOME"/.cache/"$i" ]; then
    echo "Removing $HOME/.cache/$i"
    trash-put "$HOME"/.cache/"$i"
  fi
done

for i in "${config[@]}"; do
  if [ -e "$HOME"/.config/"$i" ]; then
    echo "Removing $HOME/.config/$i"
    trash-put "$HOME"/.config/"$i"
  fi
done

for i in "${share[@]}"; do
  if [ -e "$HOME"/.local/share/"$i" ]; then
    echo "Removing $HOME/.local/share/$i"
    trash-put "$HOME"/.local/share/"$i"
  fi
done

# Locations to search for files
declare -a dir_list=(
"$HOME"
"$CITADEL/temp"
"$HOME/phone"
"$HOME/temp"
)

# move all files to their respective directory
sh "$HOME/.bin/sort-files.sh" "${dir_list[@]}"

# convert and remove all webp files
sh "$HOME/.bin/webp-convert.sh" "$IMAGE_DIR"

# rename all images to their hash
sh "$HOME/.bin/hash-rename.sh" "$IMAGE_DIR"

# check for 4chan filenames
for FILE in "$VIDEO_DIR"/*; do
  if [[ $FILE =~ [0-9]{13}.webm ]]; then
    mv "$FILE" "$VIDEO_DIR"/4chan/
  fi
done

# move all directories in $ARCHIVE_DIR to $TEMP_DIR
for ENTRY in "$ARCHIVE_DIR"/*; do
  if [ -d "$ENTRY" ]; then
    echo "moved $ENTRY to $TEMP_DIR"
    mv "$ENTRY" "$TEMP_DIR"
  fi
done

echo "Cleaning project build artifacts"
for ENTRY in "$HOME"/projects/*; do
  if [ -d "$ENTRY"/target ]; then
    echo "$ENTRY/target exists, moving to trash"
    trash-put "$ENTRY"/target
  elif [ -d "$ENTRY"/build ]; then
    echo "$ENTRY/build exists, moving to trash"
    trash-put "$ENTRY"/build
  fi
done

# if [ -d "$HOME"/.cargo/registry ]; then
#   trash-put "$HOME"/.cargo/registry
# fi

# go folder needs special treatment
if [ -d "$HOME/go" ]; then
  echo "removing $HOME/go"
  sudo rm -rf "$HOME"/go
fi

trash-empty
