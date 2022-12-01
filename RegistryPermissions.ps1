#	Description
#This script will remotely update Registry Key permissions and write the results to a log

[STRING]$TimeStamp = Get-Date -Format "yyyy-MM-dd_HH_mm"

#Check Log path so Log can be created
$Logfile = "D:\log\Add-RegPermissions_" + $TimeStamp + ".log"

Write-Output "$('[{0:MM/d/yyyy} {0:HH:mm:ss}]' -f (Get-Date))"
Write-Output "$('[{0:MM/d/yyyy} {0:HH:mm:ss}]' -f (Get-Date))" | Out-File $Logfile

$env:USERNAME | Out-File $Logfile -Append

<#
$Servers = "Server 1",`
           "Server 2",`
           "Server 3" | Get-ADComputer
#>

$Servers = "Server"| Get-ADComputer

#Users to add to the Object
#Must be Full CN User CN=,OU=,DC=,DC=,DC=,DC=com
$RmsAdmins = "CN User 1 CN=,OU=,DC=,DC=,DC=,DC=com",`
             "CN User 1 CN=,OU=,DC=,DC=,DC=,DC=com" | Get-ADObject -Properties Samaccountname

#Keys to update
$Keys = "HKLM:\SOFTWARE\Key 1",`
        "HKLM:\SOFTWARE\Key 2",`
        "HKLM:\SOFTWARE\Key 3"

foreach($Server in $Servers){
    foreach($RmsAdmin in $RmsAdmins){
        foreach($Key in $Keys){
   
            Write-Host "`n"

            Try{
                Invoke-Command -ComputerName $Server.DNSHostName {
                    $Acl = Get-Acl -Path $using:Key
#Domain needs to be specified
                    $idRef = [System.Security.Principal.NTAccount]("DOMAIN\" + $using:RmsAdmin.Samaccountname)
                    $regRights = [System.Security.AccessControl.RegistryRights]::FullControl
                    $inhFlags = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit
                    $prFlags = [System.Security.AccessControl.PropagationFlags]::None
                    $acType = [System.Security.AccessControl.AccessControlType]::Allow

                    $Rule = New-Object System.Security.AccessControl.RegistryAccessRule ($idRef, $regRights, $inhFlags, $prFlags, $acType)

                    $Acl.AddAccessRule($Rule)

                    $Acl | Set-Acl
                    }
                Write-Host "Set ACL for" $Key "`ton`t" $Server.Name -ForegroundColor Green
                "Set ACL," + $Key + "," + $Server.Name | Out-File $Logfile -Append
#Green Good
                }
            Catch{
                Write-Host "Unable to set ACL for" $Key "`ton`t" $Server.Name -ForegroundColor Red
                Write-Host $Error[0] -ForegroundColor Red
                "[ERROR]Unable to set ACL," + $Key + "," + $Server.Name | Out-File $Logfile -Append
                $Error[0] | Out-File $Logfile -Append
#Red Bad
#Both outcomes are Logged in the File for review
                }
        }
    }
}

Pause