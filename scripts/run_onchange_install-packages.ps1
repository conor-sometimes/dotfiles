#$POLICTY = Get-ExecutionPolicy
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe

$PACKAGES = @(
	'Git.Git',
	'twpayne.chezmoi'
	'Microsoft.PowerShell'
)

if ($env:Username -eq "dind" -Or $env:Username -eq "Conor") {
	$PACKAGES += 'VideoLAN.VLC'
	$PACKAGES += 'Valve.Steam'
	$PACKAGES += 'Anki.Anki'
	$PACKAGES += 'Klocman.BulkCrapUninstaller'
	$PACKAGES += 'GIMP.GIMP'
	$PACKAGES += 'Microsoft.PowerToys'
	$PACKAGES += 'Doist.Todoist'
	$PACKAGES += 'KeePassXCTeam.KeePassXC'
	$PACKAGES += 'Cryptomator.Cryptomator'
	$PACKAGES += 'AntibodySoftware.WizTree'
	$PACKAGES += 'Microsoft.VisualStudioCode'
	$PACKAGES += 'Microsoft.WindowsTerminal'
}

Foreach ($PACKAGE in $PACKAGES) {
	echo "winget install -e --id $PACKAGE"
}

if ($env:Username -eq "dind" -Or $env:Username -eq "Conor") {
	wsl --install
}

if ($env:Username -eq "lewis") {
	$PACKAGES += 'BlenderFoundation.VLC'
}
