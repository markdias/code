<#
.Synopsis
Short description
.DESCRIPTION
Long description
.EXAMPLE
Example of how to use this cmdlet
.EXAMPLE
Another example of how to use this cmdlet
#>
function Get-EufyConnect {
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)]
        $username,

        # Param2 help description
        $password, 

        # Param2 help description
        $BaseURI


    )

    Begin {
        $AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
[System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
        
        $Session_URI = $BaseURI

        $Session_Body = @{
            email = $username
            password = $password
            
        } | ConvertTo-Json

    }
    Process {
        $result = Invoke-RestMethod -URI $Session_URI -Method POST -Body $Session_Body
    
    }
    End {
        return $Result.Data.Auth_token
    }
}
$token = Get-EufyConnect -username "api@mdias.co.uk" -password "HOTH2vont3gun*klub" -BaseURI "https://mysecurity.eufylife.com/apieu/v1/passport/login"
function Get-EufyList {
    [CmdletBinding()]
    [Alias()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0)]
        $token,
        $BaseURI


    )

    Begin {
        
        
        $Session_URI = $BaseURI

        $Session_Header = @{
            'x-auth-token' = $token
           
            
        }

    }
    Process {
        $result = Invoke-RestMethod -URI $Session_URI -Method POST -Headers $Session_Header
    
    }
    End {
        return $Result.data
    }
}

$StatusAdd
[int]$BackDoorStatus = (Get-EufyList -token $token -BaseURI "https://security-app-eu.eufylife.com/v1/app/get_devs_list" | Where {$_.Device_name -eq "Back Door"}).params | where {$_.param_id -eq 4689852} | Select -ExpandProperty param_value

[int]$StatusAdd = get-content c:\Eufy\backdoor.txt
[int]$StatusAdd = $StatusAdd + $BackDoorStatus
[int]$StatusAdd | Set-Content C:\Eufy\backdoor.txt 

If ($BackDoorStatus -eq 0)

{
 $StatusAdd = 0
 [int]$StatusAdd | Set-Content C:\Eufy\backdoor.txt 
}

If ($StatusAdd -eq 20){

Invoke-RestMethod -Method Post -Uri 'https://maker.ifttt.com/trigger/back_door_opened/with/key/GgV5YYDYTpvWqT6Tsanff'
 $StatusAdd = 0
 [int]$StatusAdd | Set-Content C:\Eufy\backdoor.txt 
}
