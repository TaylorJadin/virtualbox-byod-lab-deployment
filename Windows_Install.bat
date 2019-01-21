@echo off
:: BatchGotAdmin (Run as Admin code starts)

REM --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
echo Requesting administrative privileges...
goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

"%temp%\getadmin.vbs"
exit /B

:gotAdmin
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"

:: BatchGotAdmin (Run as Admin code ends)
:: Your codes should start from the following line

cls
echo This installer will set up Virtualbox and its Extenion Pack,
echo then import the CompSci.ova file to set up the Virtual Machine.
echo.
echo This script will take several minutes to complete, 
echo and will require approximately 30gb of free space on your hard drive.
echo.
pause
cls

REM Install chocolatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

REM Use chocolatey to install Virtualbox and extension pack
choco upgrade all -y
choco install virtualbox -y

REM Uncomment the following line and change the path if you want to install on external storage
REM "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" setproperty machinefolder C:\

REM VBoxManage setproperty machinefolder /Volumes/MYUSBDRIVE

REM Import the image, make the shared folder
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" import "%~dp0CompSci.ova"
"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" sharedfolder add CompSci --name LocalMachine --hostpath C:\ --automount

echo.
echo.
echo.
echo Installation complete. You may now close this window.
echo.
echo If you have questions/problems, please contact the ITS Service Desk:
echo snc.edu/its
echo servicedesk@snc.edu
echo (920) 403-4040
echo Cofrin Hall Room 119

REM Launch Virtualbox
"c:\Program Files\Oracle\VirtualBox\VirtualBox.exe"