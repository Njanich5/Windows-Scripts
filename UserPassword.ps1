#Powershell Script to enter a username then check if the AD password is expired within a 90 day password policy

#Establishes Convert-TimetoDays Function which is needed later
function Convert-TimeToDays {
    [CmdletBinding()]
    param (
        $StartTime,
        $EndTime,
        #[nullable[DateTime]] $StartTime, # can't use this just yet, some old code uses strings in StartTime/EndTime.
        #[nullable[DateTime]] $EndTime, # After that's fixed will change this.
        [string] $Ignore = '*1601*'
    )
    if ($null -ne $StartTime -and $null -ne $EndTime) {
        try {
            if ($StartTime -notlike $Ignore -and $EndTime -notlike $Ignore) {
                $Days = (NEW-TIMESPAN -Start $StartTime -End $EndTime).Days
            }
        } catch {}
    } elseif ($null -ne $EndTime) {
        if ($StartTime -notlike $Ignore -and $EndTime -notlike $Ignore) {
            $Days = (NEW-TIMESPAN -Start (Get-Date) -End ($EndTime)).Days
        }
    } elseif ($null -ne $StartTime) {
        if ($StartTime -notlike $Ignore -and $EndTime -notlike $Ignore) {
            $Days = (NEW-TIMESPAN -Start $StartTime -End (Get-Date)).Days
        }
    }
    return $Days
}

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
