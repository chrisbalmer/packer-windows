Write-Output "Starting VMware tools download..."

$HTTP_ISO_PATH = "https://nas.balmerfamilyfarm.com:9000/public/vmware/tools/windows.iso"
Write-Output "HTTP_ISO_PATH: $HTTP_ISO_PATH"


$ISO_PATH = "C:\Windows\Temp\windows.iso"
Write-Output "ISO_PATH: $ISO_PATH"


$webClient = New-Object System.Net.WebClient
$Webclient.DownloadFile($HTTP_ISO_PATH, $ISO_PATH)

$mount = Mount-DiskImage -ImagePath $ISO_PATH -PassThru
$driveLetter = ( $mount | Get-Volume ).DriveLetter
$vmwareToolsInstaller = ( $driveLetter + ":\setup64.exe" )

Write-Host "VMware Tools installer located at: $vmwareToolsInstaller"

# Install VMware Tools
Write-Host "Installing VMware Tools"
Start-Process $vmwareToolsInstaller -ArgumentList '/S','/v','"/qn REBOOT=r"' -Wait

