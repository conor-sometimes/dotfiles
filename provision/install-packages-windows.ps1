#Requires -RunAsAdministrator

# Prompt for confirmation before installing the Desktop App Installer package
if((Get-Package -Name Microsoft.DesktopAppInstaller -ErrorAction SilentlyContinue) -eq $null) {
    if (Read-Host "The Desktop App Installer package is not installed. Do you want to install it? [Y/N]" -eq 'Y') {
        Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe -Confirm
    }
}

# Install winget and configure verbose and error handling
if(!(Get-Command winget -ErrorAction SilentlyContinue)) {
    Install-PackageProvider -Name winget -Force
    Install-Module -Name Microsoft.PowerShell.PackageManagement -Force
    Install-Package -ProviderName winget -Name winget -Force
}
$wingetInstallParams = @{ ErrorAction = 'Stop'; Verbose = $true }

$PACKAGES = @(
    'Anki.Anki'
    'AntibodySoftware.WizTree'
    'Audacity.Audacity'
    #'AutoHotkey.AutoHotkey'
    'Bitwarden.Bitwarden'
    'Cryptomator.Cryptomator'
    'Doist.Todoist'
    'GIMP.GIMP'
    'Git.Git',
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
    Write-Verbose "Installing package $PACKAGE..."
    winget install -e --id $PACKAGE @wingetInstallParams
}

$EXTENSIONS = @(
    'eamodio.gitlens'
)

Foreach ($EXTENSION in $EXTENSIONS) {
    if(!(code --list-extensions | Select-String -SimpleMatch $EXTENSION -Quiet)) {
        Write-Verbose "Installing extension $EXTENSION..."
        code --install-extension $EXTENSION
    }
}

if ($env:Username -eq "dind" -Or $env:Username -eq "Conor") {
    Write-Verbose "Installing WSL..."
    wsl --install
}
