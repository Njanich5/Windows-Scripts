#Powershell Script to enter a username then check if the AD password is expired within a 90 day password policy

$User = Read-Host -Prompt 'Input the user name'
Get-ADUser -Identity “$User” -Properties “PasswordLastSet”

$aduserprops = Get-ADUser -Identity “$User” -Properties "PasswordLastSet"
$username = ($aduserprops.GivenName, $aduserprops.Surname)
$pwdate = $aduserprops.PasswordLastSet 
$date = Convert-TimeToDays($pwdate)
$DaysTillExpired = (90 - $date)

if ($DaysTillExpired -le 3)
{ $PositiveDays = [math]::abs($DaysTillExpired)
Write-Host "$username's is expired $PositiveDays days ago and needs to be changed" }
else {
Write-Host "$username's Password will expire in $DaysTillExpired Days"
}
Read-Host -Prompt “Press Enter to exit”
