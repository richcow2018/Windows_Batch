:: This program is to generate a traceroute result report and send it to me
:: 5 July 2018 created by Jimmy Chu
:: filename: traceroute.bat

@echo off

echo "The program is started !  Normally it takes less than a minute to finish this process."

:: check if the old traceroute report is exit or not, if so, remove it
if exist traceroute-result.txt (
	del /q /f traceroute-result.txt
) 

:: get a user name
powershell.exe -ExecutionPolicy Bypass -Command "[System.Security.Principal.WindowsIdentity]::GetCurrent().Name | Out-File traceroute-result.txt -NoClobber -Append"

:: get current date and time
powershell.exe -ExecutionPolicy Bypass -Command "Get-Date -Format g | Out-File traceroute-result.txt -NoClobber -Append"

:: get hk4 traceroute result
powershell.exe -ExecutionPolicy Bypass -Command "Test-NetConnection hk123.abc.com -TraceRoute  | Out-File traceroute-result.txt -NoClobber -Append"

:: get hk4 traceroute result
powershell.exe -ExecutionPolicy Bypass -Command "Test-NetConnection hk123.abc.com -TraceRoute | Select -ExpandProperty TraceRoute | ForEach{ Resolve-DnsName $_ -type PTR -ErrorAction SilentlyContinue }  | Out-File traceroute-result.txt -NoClobber -Append"

:: get hk6 traceroute result
powershell.exe -ExecutionPolicy Bypass -Command "Test-NetConnection hk123.abc.com -TraceRoute  | Out-File traceroute-result.txt -NoClobber -Append"

:: get hk6 traceroute result
powershell.exe -ExecutionPolicy Bypass -Command "Test-NetConnection hk123.abc.com -TraceRoute | Select -ExpandProperty TraceRoute | ForEach{ Resolve-DnsName $_ -type PTR -ErrorAction SilentlyContinue }  | Out-File traceroute-result.txt -NoClobber -Append"

:: send out the traceroute report
Powershell.exe -executionpolicy remotesigned -File  sendemail.ps1

echo "The program is ended ! "
set /p DUMMY=Hit ENTER to close...

