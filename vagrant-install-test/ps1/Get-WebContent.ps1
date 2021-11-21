<#
.SYNOPSIS
    Gets a installer / content and puts in a place
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
    [Parameter()][String]$URI = "https://download.microsoft.com/download/B/0/0/B00291D0-5A83-4DE7-86F5-980BC00DE05A/AzureADConnect.msi",
    [Parameter()][String]$localFile = "C:\dev\AzureADConnect.msi"
)

$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("$URI","$localFile")