<#
  Turn on Autologin. This code is based on the following recipe:
  URL: https://learn.microsoft.com/en-us/troubleshoot/windows-server/user-profiles-and-logon/turn-on-automatic-logon

  Take into the account that this is a very unsafe way of doing things as 
  the password is stored in plain text in the System Registry.
#>
# The subsequent code comes from:
# URL: https://stackoverflow.com/a/31602095/1319478
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

$user = Read-Host 'What is the username?'
$password = Read-Host 'What is the password?'

$regkey = "HKLM:SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$auto_logon = "AutoAdminLogon"
$default_user = "DefaultUserName"
$default_password = "DefaultPassword"

function Has-RegValue {
  param (
    [Parameter(Mandatory)]
    [string]$RegKey,
    [Parameter(Mandatory)]
    [string]$Name
  )
  (Get-ItemProperty $RegKey).PSObject.Properties.Name -contains $Name
}

function Get-RegValue {
  param (
    [Parameter(Mandatory)]
    [string]$RegKey,
    [Parameter(Mandatory)]
    [string]$Name
  )
  (Get-ItemProperty $RegKey).$Name
}

function Create-RegValue {
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


Create-RegValue -RegKey $regkey -Name $auto_logon -Value "1"
Create-RegValue -RegKey $regkey -Name $default_user -Value $User
Create-RegValue -RegKey $regkey -Name $default_password -Value $Password

$has_autologon = Has-RegValue -RegKey $regkey -Name $auto_logon
$value_autologon = Get-RegValue -RegKey $regkey -Name $auto_logon

$has_default_user = Has-RegValue -RegKey $regkey -Name $default_user
$value_default_user = Get-RegValue -RegKey $regkey -Name $default_user

$has_default_password = Has-RegValue -RegKey $regkey -Name $default_password
$value_default_password = Get-RegValue -RegKey $regkey -Name $default_password

Write-Host "Has `AutoAdminLogon` key: $has_autologon with value: $value_autologon"
Write-Host "Has `DefaultUserName` key: $has_default_user with value: $value_default_user"
Write-Host "Has `DefaultPassword` key: $has_default_password with value: $value_default_password"

Read-Host "Press ENTER to exit..."
