@echo off
setlocal
cd /d %~dp0
powershell -WindowStyle Hidden -File "Accounts.ps1"