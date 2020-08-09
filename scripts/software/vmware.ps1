Write-Output "Starting VMware tools download..."

$HTTP_PATH = "https://packages.vmware.com/tools/releases/11.1.1/windows/x64/VMware-tools-11.1.1-16303738-x86_64.exe"
Write-Output "HTTP_PATH: $HTTP_PATH"


$LOCAL_PATH = "C:\Windows\Temp\vmware.exe"
Write-Output "LOCAL_PATH: $LOCAL_PATH"


$webClient = New-Object System.Net.WebClient
$Webclient.DownloadFile($HTTP_PATH, $LOCAL_PATH)

# Install VMware Tools
Write-Host "Installing VMware Tools"
Start-Process $LOCAL_PATH -ArgumentList '/S /v /qn REBOOT=R' -Wait -NoNewWindow
Write-Host "VMware Tools Installed"
