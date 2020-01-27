$userName = Read-Host "Enter username here: "
$Userinfo = Get-ADUser -Filter * -Properties LockedOut |
 Where-Object { $_.SAMAccountName -like "*$userName*" } |
 Select-Object -Property SamAccountName, DistinguishedName, LockedOut

$locked = $Userinfo.lockedout

if ($locked -eq "True") {
    Write-Host -f red "Account locked"
    Write-Host""
    Write-Host -f Green "Unlocking Account"
    Unlock-ADAccount -Identity $userName
    }
    else{
    Write-Host -f Green "Account is not Locked out"
    }
    Read-Host -Prompt “Press Enter to exit”
