@echo off
rem concept of skipping oobe on pre oem machines and pre-configure the machine
echo DROPPING PAYLOAD...
echo by Jacky Timmermans
%systemroot%\system32\reg.exe load "HKU\mount" "C:\Users\Default\NTUSER.DAT"
%systemroot%\system32\reg.exe add "HKU\mount\Software\Microsoft\Windows\CurrentVersion\Runonce" /v "UserFirstLogon" /t REG_SZ /d "C:\Windows\Setup\Scripts\UserFirstLogon.cmd" /f
%systemroot%\system32\reg.exe unload "HKU\mount"
copy /y "%~dp0\UserFirstLogon.cmd" "C:\Windows\Setup\Scripts\UserFirstLogon.cmd"
%systemroot%\system32\sysprep\sysprep.exe /oobe /reboot /unattend:%~dp0\unattend.xml