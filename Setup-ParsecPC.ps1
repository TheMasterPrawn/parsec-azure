
<#
.SYNOPSIS
    SYNOPSIS
.DESCRIPTION
    DESCRIPTION
.NOTES
    NOTES
.INPUTS
    N/A
.OUTPUTS
    N/A
.EXAMPLE
#>

function Update-Registry($keys = "regkeys.csv")
{
    $regKeys = Import-Csv $keys
    foreach($regKey in $regKeys)
    {
        .\Set-RegKey.ps1 -key $regKey.Key -valueName $regKey.ValueName `
                         -valueType $regKey.ValueType -valueData $regkey.ValueData
    }
}

$installers = @('steam')

.\Get-GameInstallers.ps1 -installers $installers
.\Disable-Updates.ps1
Update-Registry
