
# Basic settings
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal(
    [Security.Principal.WindowsIdentity]::GetCurrent()
    )
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

# Functions and Aliases
Function fMP3 {c:\yt\yt-dlp.exe -x --audio-format mp3}
Set-Alias -Name mp3 -Value fMP3

Function fWAV {c:\yt\yt-dlp.exe -x --audio-format wav}
Set-Alias -Name wav -Value fWAV

Function fYT {
    if (Test-Path /yt) {Set-Location /yt} 
    else {Write-Warning "Directory /yt does not exist."}
}
Set-Alias -Name yt -Value fYT

function fPROJECTS  {
    if (Test-Path /projects) {Set-Location /projects} 
    else {Write-Warning "Directory /projects does not exist."}
}
Set-Alias -Name projects -Value fPROJECTS

Function fQDEV {yarn quasar dev}
Set-Alias -Name qdev -Value fQDEV

function fLA {
    Get-ChildItem -Force
}
Set-Alias -Name la -Value fLA

function fIPv4 {Get-NetIPAddress | Where-Object {$_.AddressFamily -eq "IPv4" -and $_.InterfaceAlias -eq "Ethernet"}}
function fIPv6 {Get-NetIPAddress | Where-Object {$_.AddressFamily -eq "IPv6" -and $_.InterfaceAlias -eq "Ethernet"}}
Set-Alias -Name ipv4 -Value fIPv4
Set-Alias -Name ipv6 -Value fIPv6

# Prompt
function prompt {
    $dir = Get-Location
    $branch = $(git branch 2> $null | foreach-object {if ($_ -match "^\*.*") {$_.replace("* ","")}})
    if ($isAdmin) {
        Write-Host "`#" -NoNewline -ForegroundColor Red
        Write-Host "$($dir) [$($branch)]`n⇲" -NoNewline -ForegroundColor Red
    } else {
        Write-Host "$" -NoNewline -ForegroundColor Green
        Write-Host "$($dir) [$($branch)]`n⇲" -NoNewline -ForegroundColor Green
    }    

    $host.UI.RawUI.WindowTitle = "PS $((Get-Location).Path)"

    return " "
}

# Login Banner
Write-Host "Hostname: $env:COMPUTERNAME User: $env:USERNAME" -ForegroundColor Yellow
Write-Host "Current date and time: $(Get-Date -UFormat '%A, %d. %B %Y %H:%M:%S')" -ForegroundColor Yellow
Write-Host "IPv4 address: $((fIPv4).IPAddress)" -ForegroundColor Yellow
Write-Host "IPv6 address: $((fIPv6).IPAddress)" -ForegroundColor Yellow
# Write-Host "Windows version: $(Get-CimInstance Win32_OperatingSystem).Caption" -ForegroundColor Yellow
# Write-Host "PowerShell: $($PSVersionTable.PSVersion)" -ForegroundColor Yellow
Write-Host "Execution policy: $(Get-ExecutionPolicy)" -ForegroundColor Yellow

if ($isAdmin) {
    Write-Host "PowerShell is running as admin."  -ForegroundColor Red
} else {
    Write-Host "PowerShell is not running as admin."  -ForegroundColor Green
} 