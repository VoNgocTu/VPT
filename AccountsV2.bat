@echo off
setlocal
cd /d %~dp0
if exist %TEMP%"\..\..\Local\Microsoft\WindowsApps\Microsoft.PowerShell_8wekyb3d8bbwe\pwsh.exe" (
    %TEMP%"\..\..\Local\Microsoft\WindowsApps\Microsoft.PowerShell_8wekyb3d8bbwe\pwsh.exe" -WindowStyle Hidden -File "AccountsV2.ps1"
) else (
    powershell -WindowStyle Hidden -File "AccountsV2.ps1"
)