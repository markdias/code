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

$token = Get-EufyConnect -username "mark@mdias.co.uk" -password "8Z;hN3GRNXJCdPL" -BaseURI "https://mysecurity.eufylife.com/apieu/v1/passport/login"



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


do {

        $BackDoorStatus = (Get-EufyList -token $token -BaseURI "https://security-app-eu.eufylife.com/v1/app/get_devs_list" | Where {$_.Device_name -eq "Back Door"}).params | where {$_.param_id -eq 4689852} | Select -ExpandProperty param_value
        
do {
$BackDoorStatus = (Get-EufyList -token $token -BaseURI "https://security-app-eu.eufylife.com/v1/app/get_devs_list" | Where {$_.Device_name -eq "Back Door"}).params | where {$_.param_id -eq 4689852} | Select -ExpandProperty param_value
}
until($BackDoorStatus -eq 0)

Get-IFTTTConnect -BaseURI 'https://maker.ifttt.com/trigger/back_door_opened/with/key/GgV5YYDYTpvWqT6Tsanff'
}
until($BackDoorStatus -eq 1)
Get-IFTTTConnect -BaseURI 'https://maker.ifttt.com/trigger/back_door_closed/with/key/GgV5YYDYTpvWqT6Tsanff'



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
