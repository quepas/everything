$msi_url = "https://github.com/PowerShell/PowerShell/releases/download/v7.5.0/PowerShell-7.5.0-win-x64.msi"
$target_path = "$env:USERPROFILE\Downloads\powershell.msi"

Write-Host "Downloading Powershell. This will take a while..."
(New-Object Net.WebClient).DownloadFile($msi_url, $target_path)

Write-Host "Installing Powershell. This will take a while..."
# Add /quite if needed
msiexec.exe /package $target_path ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 USE_MU=1 ENABLE_MU=1 ADD_PATH=1

Write-Host "Restarting. After that, just run 'pwsh' instead of 'powershell'"
Restart-Computer -Force
