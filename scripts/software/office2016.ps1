# Unfinished
Write-Output "Starting"

#$HTTP_PATH = (Get-Item Env:PACKER_HTTP_ADDR).Value
$HTTP_PATH = "HTTP_PATH"
$HTTP_ISO_PATH = "http://$HTTP_PATH/ISO_FILE_PATH.ISO"
$HTTP_MSP_PATH = "http://$HTTP_PATH/MSP_FILE_PATH.MSP"
$HTTP_MSP_XML_PATH = "http://$HTTP_PATH/MSP_FILE_PATH.MSP.xml"
Write-Output "HTTP_ISO_PATH: $HTTP_ISO_PATH"
Write-Output "HTTP_MSP_PATH: $HTTP_MSP_PATH"
Write-Output "HTTP_MSP_XML_PATH: $HTTP_MSP_XML_PATH"


$ISO_PATH = "C:\Windows\Temp\office2016.iso"
$MSP_PATH = "C:\Windows\Temp\office2016.msp"
$MSP_XML_PATH = "C:\Windows\Temp\office2016.msp.xml"
Write-Output "ISO_PATH: $ISO_PATH"
Write-Output "MSP_PATH: $MSP_PATH"
Write-Output "MSP_XML_PATH: $MSP_XML_PATH"


$webClient = New-Object System.Net.WebClient
$Webclient.DownloadFile($HTTP_ISO_PATH, $ISO_PATH)
$Webclient.DownloadFile($HTTP_MSP_PATH, $MSP_PATH)
$Webclient.DownloadFile($HTTP_MSP_XML_PATH, $MSP_XML_PATH)


$mount = Mount-DiskImage -ImagePath $ISO_PATH -PassThru
$driveLetter = ( $mount | Get-Volume ).DriveLetter
$officeInstaller = ( $driveLetter + ":\setup.exe" )

Write-Host "Office installer located at: $officeInstaller"

# Install Office
Write-Host "Installing Office"
Start-Process $officeInstaller -ArgumentList '/AdminFile', $MSP_PATH -Wait