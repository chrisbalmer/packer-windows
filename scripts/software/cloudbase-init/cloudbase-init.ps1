Write-Output "Starting cloudbase-init download..."

$HTTP_PATH = "https://nas.balmerfamilyfarm.com:9000/public/cloud/CloudbaseInitSetup_Stable_x64.msi"
Write-Output "HTTP_PATH: $HTTP_PATH"

$LOCAL_PATH = "C:\Windows\Temp\CloudbaseInitSetup_Stable_x64.msi"
Write-Output "LOCAL_PATH: $LOCAL_PATH"

Write-Host "Downloading cloudbase-init..."
Invoke-WebRequest $HTTP_PATH -OutFile $LOCAL_PATH

Write-Host "Installing cloudbase-init..."

Start-Process msiexec -ArgumentList "/i $LOCAL_PATH /qn /l*v USERNAME='Administrator'" -Wait

$unattendedXmlPath = "${env:ProgramFiles}\Cloudbase Solutions\Cloudbase-Init\conf\Unattend.xml"
$unattend_path = "${env:ProgramFiles}\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init-unattend.conf"
$conf_path = "${env:ProgramFiles}\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf"

Copy-Item "A:\cloudbase-init.conf" -Destination $conf_path
Copy-Item "A:\cloudbase-init-unattend.conf" -Destination $unattend_path

$contents = Get-Content -Path $unattendedXmlPath
Write-Host $contents

Write-Host "Running Cloudbase-Init SetSetupComplete..."
"${env:ProgramFiles}\Cloudbase Solutions\Cloudbase-Init\bin\SetSetupComplete.cmd"

$contents = Get-Content -Path $unattendedXmlPath
Write-Host $contents

Write-Host "Running Sysprep..."

#& "${env:SystemRoot}\System32\Sysprep\Sysprep.exe" `/generalize `/oobe `/shutdown #`/unattend:"$unattendedXmlPath"

