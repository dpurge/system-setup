@echo off

if '%1'=='/?' goto help
if '%1'=='-help' goto help
if '%1'=='-h' goto help

pwsh -NoProfile -ExecutionPolicy Bypass -Command "Invoke-PSake '%~dp0build.psake.ps1' %*; if ($psake.build_success -eq $false) { exit 1 } else { exit 0 }"
exit /B %errorlevel%

:help
pwsh -NoProfile -ExecutionPolicy Bypass -Command "Invoke-PSake -help"