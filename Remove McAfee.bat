echo y | wmic product where name="Malwarebytes' Managed Client" call uninstall
echo y | wmic product where name="McAfee VirusScan Enterprise" call uninstall
echo y | wmic product where name="McAfee Product Improvement Program" call uninstall

IF NOT DEFINED MINIMIZED SET MINIMIZED=1 && START "" /MIN "%~dpnx0" %* && EXIT

SET TARGETPATH=C:\Program Files\McAfee\Common Framework\x86\
IF NOT EXIST "%TARGETPATH%" GOTO :SECOND
cd %TARGETPATH%
start FrmInst.exe /remove=agent
GOTO :END

:SECOND
SET SECONDPATH=C:\Program Files\McAfee\Agent\x86\
IF NOT EXIST "%SECONDPATH%" GOTO :THIRD
cd %SECONDPATH%
start FrmInst.exe /remove=agent
GOTO :END

:THIRD
SET THIRDPATH=C:\Program Files (x86)\McAfee\Common Framework\x86
IF NOT EXIST "%THIRDPATH%" GOTO :ERROR
cd %THIRDPATH%
start FrmInst.exe /remove=agent
GOTO :END

:ERROR
SET msgboxTitle=McAfee Removal
SET msgboxBody=Your Computer doesn't have McAfee currently installed. Please go to Part 2: Installing Sophos Endpoint from the install doc.
SET tmpmsgbox=%temp%\~tmpmsgbox.vbs
IF EXIST "%tmpmsgbox%" DEL /F /Q "%tmpmsgbox%"
ECHO msgbox "%msgboxBody%",0,"%msgboxTitle%">"%tmpmsgbox%"
WSCRIPT "%tmpmsgbox%"

:END
exit