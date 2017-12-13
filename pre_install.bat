@ECHO OFF

REG ADD "HKLM\Software\Policies\Microsoft\Internet Explorer\Main" /v DisableFirstRunCustomize /t REG_DWORD /d 00000001 /f

PowerShell.exe -ExecutionPolicy Bypass -File version.ps1


