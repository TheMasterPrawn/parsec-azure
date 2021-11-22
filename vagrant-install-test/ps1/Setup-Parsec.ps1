
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

$installers = @('goggalaxy', 'steam', 'origin', 'uplay')
$psscriptroot
"$psscriptroot\Get-GameInstallers.ps1" -installers $installers

. disable-updates.ps1 