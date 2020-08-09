# Setup a new packer directory for our files
$packerWindowsDir = 'C:\Windows\packer'
New-Item -Path $packerWindowsDir -ItemType Directory -Force | Out-Null

# Copy the unattend.xml file over to the packer directory
$unattendedXmlPath = "${env:ProgramFiles}\Cloudbase Solutions\Cloudbase-Init\conf\Unattend.xml"
Copy-Item $unattendedXmlPath -Destination "$($packerWindowsDir)\Unattend.xml"

# Add any shutdown tasks into this string
$shutdownCmd = @"
${env:SystemRoot}\system32\sysprep\sysprep.exe /generalize /oobe /unattend:$($packerWindowsDir)\Unattend.xml /quiet /shutdown
"@

# Put the tasks into the batch file for shutdown
Set-Content -Path "$($packerWindowsDir)\PackerShutdown.bat" -Value $shutdownCmd
