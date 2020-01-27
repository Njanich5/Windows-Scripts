xcopy "\\FILE_LOCATION_HERE\WindowsUpdatesFix.ps1" "C:\Users\%UserName%\Desktop\" /i
REM Copied PoSh Scripts

PowerShell.exe -NoProfile -Command "& {Start-Process PowerShell.exe -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File "C:\Users\%UserName%\Desktop\WindowsUpdatesFix.ps1"' -Verb RunAs}"
PAUSE
del "C:\Users\%UserName%\Desktop\WindowsUpdatesFix.ps1"