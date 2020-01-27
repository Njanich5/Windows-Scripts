@echo off
echo\
echo I am logged on as %UserName%.
echo My computer's name is %ComputerName%.
echo My IP settings are
ipconfig | find "IPv4"
echo\
echo Press the Space bar to close this window.
pause > nul