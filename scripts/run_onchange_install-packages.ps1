#$POLICTY = Get-ExecutionPolicy
Add-AppxPackage -RegisterByFamilyName -MainPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe

$PACKAGES = (
	'Git.Git'
	'twpayne.chezmoi'
	'Microsoft.PowerShell'
)

{{ if eq .chezmoi.username "chiba\dind" -}}
$PACKAGES += 'VideoLAN.VLC'
$PACKAGES += 'Valve.Steam'
$PACKAGES += 'Anki.Anki'
$PACKAGES += 'Klocman.BulkCrapUninstaller'
$PACKAGES += 'GIMP.GIMP'
$PACKAGES += 'Microsoft.PowerToys'
{{ end -}}

{{ if eq .chezmoi.username "chiba\lewis" -}}
$PACKAGES += 'BlenderFoundation.VLC'
{{ end -}}

Foreach ($PACKAGE in $PACKAGES) {
	echo "winget install -e --id $PACKAGE"
}
