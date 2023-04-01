#Requires -RunAsAdministrator

# Install winget
$packageName = "Microsoft.DesktopAppInstaller_8wekyb3d8bbwe"

if (!(Get-AppxPackage $packageName -ErrorAction SilentlyContinue)) {
    # Install winget
    Write-Output "Installing $packageName"
    Add-AppxPackage -RegisterByFamilyName -MainPackage $packageName
}

$PACKAGES = @(
    'Anki.Anki'
    'AntibodySoftware.WizTree'
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

Write-Output "Installing packages..."
$progress = 0
$PACKAGES.Count | ForEach-Object {
    $PACKAGE = $PACKAGES[$_]
    $progress++
    Write-Progress -Activity "Installing package $PACKAGE" -Status "Progress: $progress of $($PACKAGES.Count)" -PercentComplete ($progress / $PACKAGES.Count * 100)
    winget install -e --id $PACKAGE
}

$EXTENSIONS = @(
    'eamodio.gitlens'
)

Write-Output "Installing extensions..."
$progress = 0
$EXTENSIONS.Count | ForEach-Object {
    $EXTENSION = $EXTENSIONS[$_]
    $progress++
    Write-Progress -Activity "Installing extension $EXTENSION" -Status "Progress: $progress of $($EXTENSIONS.Count)" -PercentComplete ($progress / $EXTENSIONS.Count * 100)
    code --install-extension $EXTENSION
}

# Check if WSL is already installed
if ($env:Username -eq "dind" -Or $env:Username -eq "Conor") {
    $wslInstalled = wsl.exe --list --all | Select-String -Pattern "Ubuntu"
    if (!$wslInstalled) {
        Write-Output "Installing WSL..."
        wsl --install
    } else {
        Write-Output "WSL is already installed"
    }
}
