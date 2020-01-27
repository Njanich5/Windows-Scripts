$Software = "*mimecast*"
$Installed = (Get-WmiObject Win32_Product | Where Name -like $Software)

If (-Not $Installed) {
    Write-host -f red "Software is not Installed :("
    }
else {
    Write-Host -f Green "Software IS Installed!"
    }