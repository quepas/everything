<#
  Turn on Autologin. This code is based on the following recipe:
  URL: https://learn.microsoft.com/en-us/troubleshoot/windows-server/user-profiles-and-logon/turn-on-automatic-logon
#>
# The subsequent code comes from:
# # URL: https://stackoverflow.com/a/31602095/1319478
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$user = Read-Host 'What is the username?'
$password = Read-Host 'What is the password?'

$regkey = "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$auto_logon = "AutoAdminLogon"
$default_user = "DefaultUserName"
$default_password = "DefaultPassword"

function Has-KeyEntry {
  param (
    [Parameter(Mandatory)]
    [string]$RegKey,
    [Parameter(Mandatory)]
    [string]$Name
  )
  (Get-ItemProperty $regkey).PSObject.Properties.Name -contains $name
}

function Create-KeyEntry {
  param (
    [Parameter(Mandatory)]
    [string]$RegKey,
    [Parameter(Mandatory)]
    [string]$Name,
    [Parameter(Mandatory)]
    [string]$Value,
    [Parameter()]
    [string]$Type = "string"
  )
  New-ItemProperty -Path $RegKey -Name $Name -Value $Value -PropertyType $Type -Force
}


Create-KeyEntry -RegKey $regkey -Name $auto_logon -Value "1"
Create-KeyEntry -RegKey $regkey -Name $default_user -Value $User
Create-KeyEntry -RegKey $regkey -Name $default_password -Value $Password

$has_autologon = Has-KeyEntry -RegKey $regkey -Name $auto_logon
$has_default_user = Has-KeyEntry -RegKey $regkey -Name $default_user
$has_default_password = Has-KeyEntry -RegKey $regkey -Name $default_password

Write-Host "Has `AutoAdminLogon` key: $has_autologon"
Write-Host "Has `DefaultUserName` key: $has_default_user"
Write-Host "Has `DefaultPassword` key: $has_default_password"
