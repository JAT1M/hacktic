@echo off
rem stage 2 of the payload
echo stage 2
echo by Jacky Timmermans

echo debloating...
if exist %temp%\remove-packages.txt (
    del /q %temp%\remove-packages.txt
)
rem Package list to remove
for /d %%s in (
    Microsoft.Microsoft3DViewer
    Microsoft.WindowsFeedbackHub
    Microsoft.GetHelp
    Microsoft.Getstarted
    Microsoft.WindowsMaps
    Microsoft.BingNews
    Microsoft.MicrosoftOfficeHub
    Microsoft.Office.OneNote
    Microsoft.MSPaint
    Microsoft.People
    Microsoft.SkypeApp
    Microsoft.MicrosoftSolitaireCollection
    Microsoft.MicrosoftStickyNotes
    Microsoft.Todos
    Microsoft.BingWeather
    Microsoft.Xbox
    Microsoft.GamingApp
    Microsoft.YourPhone
    Microsoft.549981C3F5F10
) do (
    echo %%s >> %temp%\remove-packages.txt
)
if exist %temp%\remove-caps.txt (
    del /q %temp%\remove-caps.txt
)
rem Windows capability packages to remove
for /d %%s in (
    OpenSSH.Client
    App.StepsRecorder
) do (
    echo %%s >> %temp%\remove-caps.txt
)
powershell.exe -NoProfile -Command "Get-AppxProvisionedPackage -Online | where DisplayName -In (Get-Content $env:temp\remove-packages.txt ) | Remove-AppxProvisionedPackage -Online *>&1 >> $env:TEMP\remove-packages.log;"
powershell.exe -NoProfile -Command "Get-WindowsCapability -Online | where {($_.Name -split '~')[0] -in (Get-Content $env:temp\remove-caps.txt ) } | Remove-WindowsCapability -Online *>&1 >> $env:TEMP\remove-caps.log;"

if exist %temp%\StartLayout.xml (
    del /q %temp%\StartLayout.xml
)

rem    echo {"pinnedList":[{"desktopAppLink":"%ALLUSERSPROFILE%\\Microsoft\\Windows\\Start Menu\\Programs\\Microsoft Edge.lnk"},{"desktopAppLink":"%APPDATA%\\Microsoft\\Windows\\Start Menu\\Programs\\File Explorer.lnk"},{"packagedAppId":"Microsoft.Windows.Photos_8wekyb3d8bbwe!App"},{"packagedAppId":"Microsoft.ZuneVideo_8wekyb3d8bbwe!Microsoft.ZuneVideo"},{"packagedAppId":"Microsoft.WindowsCalculator_8wekyb3d8bbwe!App"},{"packagedAppId":"Microsoft.WindowsNotepad_8wekyb3d8bbwe!App"},{"packagedAppId":"Microsoft.Paint_8wekyb3d8bbwe!App"},{"packagedAppId":"MicrosoftCorporationII.QuickAssist_8wekyb3d8bbwe!App"},{"packagedAppId":"Microsoft.WindowsStore_8wekyb3d8bbwe!App"},{"packagedAppId":"windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel"}]} > %temp%\StartLayout.xml
rem     powershell.exe -NoProfile -Command "Import-StartLayout -LayoutPath "$env:temp\StartLayout.xml" -MountPath "C:\""

rem setting up windows settings
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Communications" /v ConfigureChatAutoInstall /t REG_DWORD /d 0 /f
rem Taskbar icons
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f
rem Desktop icons: ondrive, this pc, user folder, network, control panel, recycle bin
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {018D5C66-4533-4307-9B53-224DE2ED1FE6} /t REG_DWORD /d 1 /f
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {20D04FE0-3AEA-1069-A2D8-08002B30309D} /t REG_DWORD /d 0 /f
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {59031a47-3f72-44a7-89c5-5595fe6b30ee} /t REG_DWORD /d 0 /f
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {F02C1A0D-BE21-4350-88B0-7367FC96EF3C} /t REG_DWORD /d 1 /f
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {5399E694-6CE5-4D6C-8FCE-1D8870FDCBA0} /t REG_DWORD /d 1 /f
reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v {645FF040-5081-101B-9F08-00AA002F954E} /t REG_DWORD /d 0 /f