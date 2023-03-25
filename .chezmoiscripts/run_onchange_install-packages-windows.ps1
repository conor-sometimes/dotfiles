#$POLICTY = Get-ExecutionPolicy
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe

$PACKAGES = @(
	'Git.Git',
	'twpayne.chezmoi'
	'Microsoft.PowerShell'
	'VideoLAN.VLC'
	'Valve.Steam'
	'Anki.Anki'
	'Klocman.BulkCrapUninstaller'
	'GIMP.GIMP'
	'Microsoft.PowerToys'
	'Doist.Todoist'
	'KeePassXCTeam.KeePassXC'
	'Cryptomator.Cryptomator'
	'AntibodySoftware.WizTree'
	'Microsoft.VisualStudioCode'
	'Microsoft.WindowsTerminal'
	'Mozilla.Firefox'
	'AutoHotkey.AutoHotkey'
	'Xournal++.Xournal++'
	'Microsoft.VisualStudioCode'
)

# TODO: Get lewis's username
# tell him to run `env $env:username`
if ($env:Username -eq "Lewis") {
	$PACKAGES += 'BlenderFoundation.VLC'
}

Foreach ($PACKAGE in $PACKAGES) {
	echo "winget install -e --id $PACKAGE"
	#winget install -e --id $PACKAGE
}

$EXTENSIONS = @(
	'eamodio.gitlens'
)

Foreach ($EXTENSION in $EXTENSIONS) {
	echo "vscode.exe --install-extension $EXTENSION"
	#vscode.exe --install-extension $EXTENSION
}

if ($env:Username -eq "dind" -Or $env:Username -eq "Conor") {
	wsl --install
}
