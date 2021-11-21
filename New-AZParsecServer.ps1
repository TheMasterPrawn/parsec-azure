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
[CmdletBinding()]
param (
    $projName = "ParsecGaming",
    $userName = "admin",        
    $password = "password"
)

New-AzResourceGroup -Name CloudGamingRg -Location 'westeurope'

$parameters = @{
    Name              = "$projName"
    ResourceGroupName = $projName + "Rg"
    TemplateFile      = "$psscriptroot\azuredeploy.json"
    dnsLabelPrefix    = $projName + "$((1..13 | ForEach-Object { [char[]](97..122) | Get-Random }) -join '')"
    adminUsername     = $userName
    adminPassword     = ConvertTo-SecureString -String $password -AsPlainText -Force
    # librarySizeGB     = 1024
}

New-AzResourceGroupDeployment @parameters
Restart-AzVm -Name TheBeast -ResourceGroupName CloudGamingRg -PerformMaintenance
