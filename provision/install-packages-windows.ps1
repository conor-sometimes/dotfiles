#Requires -RunAsAdministrator

# Install Microsoft Store App Installer
$packageName = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe"
if (!(Get-AppxPackage $packageName -ErrorAction SilentlyContinue)) {
    Add-AppxPackage -RegisterByFamilyName -MainPackage $packageName
}

# Install packages
$PACKAGES = @(
    'Anki.Anki'
    'AntibodySoftware.WizTree'
    'AutoHotkey.AutoHotkey --location "C:\Program Files\AutoHotkey"'
    'Bitwarden.Bitwarden'
    'Cryptomator.Cryptomator'
    'Doist.Todoist'
    'GIMP.GIMP'
    'Git.Git'
    'KeePassXCTeam.KeePassXC'
    'Klocman.BulkCrapUninstaller'
    'Microsoft.PowerShell'
    'Microsoft.PowerToys'
    'Microsoft.VisualStudioCode'
    'Microsoft.WindowsTerminal'
    'Mozilla.Firefox'
    'Valve.Steam'
    'VideoLAN.VLC'
    'Xournal++.Xournal++'
    'twpayne.chezmoi'
    'Google.Drive'
    'BlenderFoundation.Blender'
    'Mozilla.Thunderbird'
    'DuongDieuPhap.ImageGlass'
    '7zip.7zip'
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
    code --install-extension $EXTENSION
}

# Install WSL
if ($env:Username -eq "dind" -Or $env:Username -eq "Conor") {
    wsl --install --no-launch
}
