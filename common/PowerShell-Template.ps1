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
    [Parameter()][String]$sampleParam = "Somevalue",
    [Parameter()][ValidateSet('DEV','PROD')]$sampleEnum = "DEV"
)

. .\common\Helpers.ps1

Write-Log "Here is a Information" -Severity Information
Write-Log "Here is a Error" -Severity Error
Write-Log "Here is a Warning" -Severity Warning
Write-Log "Here is a Success" -Severity Success
Write-Log "Here is not written to console, check in log" -Severity Success -WriteConsole:$false
