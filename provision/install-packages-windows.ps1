# install-packages-windows.ps1
#
# Copyright (C) 2023 Conor McShane
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
    'Bitwarden.Bitwarden'
    'BlenderFoundation.Blender'
    'Cryptomator.Cryptomator'
    'Doist.Todoist'
    'DuongDieuPhap.ImageGlass'
    'GIMP.GIMP'
    'Git.Git'
    'Google.Drive'
    'KeePassXCTeam.KeePassXC'
    'Klocman.BulkCrapUninstaller'
    'Microsoft.PowerShell'
    'Microsoft.PowerToys'
    'Microsoft.VisualStudioCode'
    'Microsoft.WindowsTerminal'
    'Mozilla.Firefox'
    'Mozilla.Thunderbird'
    'Notepad++.Notepad++'
    'Valve.Steam'
    'VideoLAN.VLC'
    'Xournal++.Xournal++'
    'Yubico.YubikeyManager'
)

# Lewis specific packages go here when he thinks of any
if ($env:Username -eq "Lewis") {
    $PACKAGES += 'BlenderFoundation.Blender'
}

Foreach ($PACKAGE in $PACKAGES) {
    Write-Host "Installing $PACKAGE ..."
    winget install -e --id $PACKAGE
}

# Install Visual Studio Code extensions
$EXTENSIONS = @(
    'eamodio.gitlens'
    'ms-vscode-remote.remote-wsl'
    'vscode-icons-team.vscode-icons'
)

Foreach ($EXTENSION in $EXTENSIONS) {
    code --install-extension --force $EXTENSION
}

# Install WSL
if ($env:Username -eq "dind" -Or $env:Username -eq "Conor") {
    wsl --install --no-launch
}
