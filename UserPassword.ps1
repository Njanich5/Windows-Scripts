$User = Read-Host -Prompt 'Input the user name'
Get-ADUser -Identity “$User” -Properties “PasswordLastSet”
Read-Host -Prompt “Press Enter to exit”