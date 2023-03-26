# Get the security principal for the Administrator role
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator

# Check to see if we are currently running "as Administrator"
if ($myWindowsPrincipal.IsInRole($adminRole))
{
	# We are running "as Administrator" - so change the title and background color to indicate this
	$Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"
	$Host.UI.RawUI.BackgroundColor = "DarkBlue"
	clear-host
}
else
{
	# We are not running "as Administrator" - so relaunch as administrator

	# Create a new process object that starts PowerShell
	$newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";

	# Specify the current script path and name as a parameter
	$newProcess.Arguments = $myInvocation.MyCommand.Definition;

	# Indicate that the process should be elevated
	$newProcess.Verb = "runas";

	# Start the new process
	[System.Diagnostics.Process]::Start($newProcess);

	# Exit from the current, unelevated, process
	exit
}

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
	#'Mozilla.Firefox'
	'Valve.Steam'
	'VideoLAN.VLC'
	'Xournal++.Xournal++'
	'twpayne.chezmoi'
)

if ($env:Username -eq "Lewis") {
	$PACKAGES += 'BlenderFoundation.VLC'
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
