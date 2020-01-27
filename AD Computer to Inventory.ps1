$InventoryName = 'Put your Inventory DistinguishedName Path here'
$Repeat = $true
#While loop setup to keep searching for computers
While ($Repeat)
{
    $Hname = Read-Host -Prompt 'Input any part of the hostname'
    Get-ADComputer -Filter ('Name -like "*' + $Hname + '*"') -Properties IPv4Address,MacAddress
    
    #Answer setup to determine if you want to see the OU status of more computers
    $Answer = Read-Host -Prompt "To exit press n. Type 'move' to move this computer to the Inventory. Otherwise, press any key to search again"

    #If Answer = n, stop the script
    If ($Answer -eq "n")
    { 
        $Repeat = $false
    }

    <#  If Answer = move, Ask to enter a comma seperated list for all computers you want to move to the Inventory OU.
        These hostnames need to be entered exactly as displayed by CN.
        Example = COMPUTER1-1234,COMPUTER2-2345,COMPUTER3-3456
    #>
    If ($Answer -eq "move")
    {
     $array = Read-Host -Prompt 'Input the complete hostname of the computer you want to move to Inventory, seperate multiple computers you want to move by a comma'
     #Split the array by each , to get each individual hostname
     $SplitArray=$array.Split(',') 
      Foreach ($Computer in $SplitArray)
        {
            #Write-Host $Computer // Checked to see values created from foreach
            #Foreach Computer entered, move it to the Inventory OU
            Get-ADComputer -Filter ('Name -eq $Computer') | Move-ADObject -TargetPath '$InventoryName' 
            $Repeat = $True
        }
    }
    else 
    { 
        $Repeat = $true
    }
}