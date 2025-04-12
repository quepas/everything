<#
  Turn off user signin after sleep. This code is based on the following recipes:
    * URL: https://www.guidingtech.com/top-ways-to-disable-login-screen-after-sleep-on-windows-11/
    * URL: https://www.elevenforum.com/t/enable-or-disable-require-sign-in-on-wakeup-in-windows-11.864/
  
  It seems there are two main methods to do this with Powershell:
    1. Using `powercfg` tool
    2. Modify System Registry

  In my tests, it seems that only the 2nd method worked.
  However, we will perform them both here... just to be sure!
#>
# The subsequent code comes from:
# URL: https://stackoverflow.com/a/31602095/1319478
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

Write-Host "--------------------------------------"
Write-Host "Applying method 1 with `powercfg` tool"
Write-Host "--------------------------------------"
# For battery
powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 0
# For AC adapter
powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_NONE CONSOLELOCK 0

Write-Host "--------------------------------------"
Write-Host "Applying method 2 with System Registry"
Write-Host "--------------------------------------"
$regkey = "HKCU:Control Panel\Desktop"
$name = "DelayLockInterval"
$value = 0
$type = "DWord"
New-ItemProperty -Path $regkey -Name $name -Value $value -PropertyType $type -Force

Read-Host "Press ENTER to exit..."
