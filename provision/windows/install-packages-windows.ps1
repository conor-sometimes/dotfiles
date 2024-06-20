# install-packages-windows.ps1
#
# Copyright (C) 2024 Conor McShane
#
# Distributed under terms of the GPLv3 license.

#Requires -RunAsAdministrator

# Install Microsoft Store App Installer
Add-AppxPackage -RegisterByFamilyName -MainPackage 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe'

# Install packages
$PACKAGES = @(
    '7zip.7zip'
    'Anki.Anki'
    'AntibodySoftware.WizTree'
    'Audacity.Audacity'
    'AutoHotkey.AutoHotkey'
    'Bitwarden.Bitwarden'
    'BlenderFoundation.Blender'
    'Canonical.Ubuntu.22.04'
    'Cryptomator.Cryptomator'
    'Discord.Discord'
    'Doist.Todoist'
    'DuongDieuPhap.ImageGlass'
    'FlipperDevicesInc.qFlipper'
    'GIMP.GIMP'
    'Git.Git'
    'KDE.KDEConnect'
    'KeePassXCTeam.KeePassXC'
    'Klocman.BulkCrapUninstaller'
    'Meta.Oculus'
    'Microsoft.OneDrive'
    'Microsoft.PowerShell'
    'Microsoft.PowerToys'
    'Microsoft.VisualStudioCode'
    'Microsoft.WindowsTerminal'
    'Mozilla.Firefox'
    'Mozilla.Thunderbird'
    'Notepad++.Notepad++'
    'OBSProject.OBSStudio'
    'PrestonN.FreeTube'
    'qBittorrent.qBittorrent'
    'RARLab.WinRAR'
    'schollz.croc'
    'Shure.ShurePlusMOTIV'
    'Spotify.Spotify'
    'Valve.Steam'
    'VideoLAN.VLC'
    'Xournal++.Xournal++'
    'Yubico.Authenticator'
    'Yubico.YubikeyManager'
    'Zoom.Zoom.EXE'
)

Foreach ($PACKAGE in $PACKAGES) {
    Write-Host "Installing $PACKAGE ..."
    winget install -e --id $PACKAGE
}
