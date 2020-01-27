
Stop-Service wuauserv -Verbose
Stop-Service cryptSvc -Verbose
Stop-Service bits -Verbose

Remove-Item -Recurse C:\Windows\Temp -Force

Remove-Item -Recurse C:\Windows\SoftwareDistribution.old -Verbose
Remove-Item -Recurse C:\Windows\System32\catroot2.old -Verbose

Rename-Item C:\Windows\SoftwareDistribution SoftwareDistribution.old -Force
Rename-Item C:\Windows\System32\catroot2 Catroot2.old -Force


#Break glass in case renaming the folder doesn't work
#rm -Recurse C:\Windows\SoftwareDistribution

Start-Service wuauserv -Verbose
Start-Service CryptSvc -Verbose
Start-Service BITS -Verbose
