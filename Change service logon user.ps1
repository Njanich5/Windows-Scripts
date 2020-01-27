$acc = "domain\username"
$service = "name='Service Name Here'"
$PScred1 = Get-Credential -Message "Enter the Password for $acc"
$pass = $PScred1.GetNetworkCredential().Password


$svc =gwmi win32_service -ComputerName localhost -filter $service
$svc.StopService()
$svc.change($null,$null,$null,$null,$null,$null,$acc,$pass,$null,$null,$null)

try #Try/Catch to make sure the Service Starts
{
    $svc.StartService()
}
catch #If server doesnt start, throw error message in a pop-up
{
    #write-host "An error has occured and the service was unable to start"
    #Add an error message pop-up
    Add-Type -AssemblyName PresentationCore,PresentationFramework
    $ButtonType = [System.Windows.MessageBoxButton]::Ok #Button Options
    $MessageboxTitle = “Login Failed”
    $Messageboxbody = “The Service was unable to start. Make sure you are typing the correct password and that the account is not locked out.”
    $MessageIcon = [System.Windows.MessageBoxImage]::Warning
    [System.Windows.MessageBox]::Show($Messageboxbody,$MessageboxTitle,$ButtonType,$messageicon)
}
 
#Requires -runasAdministrator    
Add-LocalGroupMember -Group "Administrators" -Member "$acc"