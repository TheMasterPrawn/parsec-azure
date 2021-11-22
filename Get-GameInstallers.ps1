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
    $installers  =   @('goggalaxy', 'steam', 'origin', 'uplay')
)

foreach($installer in $installers)
{
    choco install $installer -y 
}