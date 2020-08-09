$Delay = 5

Write-Output "Starting cloudbase-init download..."

$HTTP_PATH = "https://www.cloudbase.it/downloads/CloudbaseInitSetup_Stable_x64.msi"
Write-Output "HTTP_PATH: $HTTP_PATH"

$LOCAL_PATH = "C:\Windows\Temp\CloudbaseInitSetup_Stable_x64.msi"
Write-Output "LOCAL_PATH: $LOCAL_PATH"

do {
    $downloading = $true
    try {
        Write-Host "Downloading cloudbase-init..."
        Invoke-WebRequest $HTTP_PATH -OutFile $LOCAL_PATH
        $downloading = $false
    } catch {
        Write-Error $_.Exception.InnerException.Message -ErrorAction Continue
        Start-Sleep -Seconds $Delay
    }
} while ($downloading)

Write-Host "Installing cloudbase-init..."
Start-Process msiexec -ArgumentList "/i $LOCAL_PATH /qn /l*v USERNAME='Administrator'" -Wait -NoNewWindow

$unattend_path = "${env:ProgramFiles}\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init-unattend.conf"
$conf_path = "${env:ProgramFiles}\Cloudbase Solutions\Cloudbase-Init\conf\cloudbase-init.conf"

Copy-Item "A:\cloudbase-init.conf" -Destination $conf_path
Copy-Item "A:\cloudbase-init-unattend.conf" -Destination $unattend_path

Write-Host "Running Cloudbase-Init SetSetupComplete..."
"${env:ProgramFiles}\Cloudbase Solutions\Cloudbase-Init\bin\SetSetupComplete.cmd"
