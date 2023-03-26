#Requires -RunAsAdministrator

# Install winget
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe

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

Foreach ($PACKAGE in $PACKAGES) {
	echo "winget install -e --id $PACKAGE"
	winget install -e --id $PACKAGE
}

$EXTENSIONS = @(
	'eamodio.gitlens'
)

Foreach ($EXTENSION in $EXTENSIONS) {
	code --install-extension $EXTENSION
}

if ($env:Username -eq "dind" -Or $env:Username -eq "Conor") {
	wsl --install
}
