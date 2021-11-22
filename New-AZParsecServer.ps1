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
    $password = "53ba152d-6840-44bb-984d-fd2709b3c1ea"
)

$rgname = $projName + "Rg"
New-AzResourceGroup -Name $rgname  -Location 'westeurope'

$parameters = @{
    Name              = "$projName"
    ResourceGroupName = $rgname 
    TemplateFile      = ".\template.json"
    #dnsLabelPrefix    = $projName + "$((1..13 | ForEach-Object { [char[]](97..122) | Get-Random }) -join '')"
    #adminUsername     = $userName
    adminPassword     = ConvertTo-SecureString -String $password -AsPlainText -Force
    # librarySizeGB     = 1024
    location          = "westeurope"
}

New-AzResourceGroupDeployment -TemplateParameterFile .\parameters.json -TemplateFile .\template.json
Restart-AzVm -Name ParsecGaming -ResourceGroupName $rgname -PerformMaintenance
