<#
.Synopsis

.EXAMPLE

.INPUTS

#>

[CmdletBinding()]
param (
    [Parameter()]$subscriptionName = "Pay-As-You-Go"
    
)

if($null -eq (Get-InstalledModule az)) 
{
    Install-Module -Name az -Scope CurrentUser
}

if($null -eq (Get-Module az)) 
{
    Import-Module az
    Get-Module -name az
}

Connect-AzAccount

$subid = (Get-AzSubscription | Where-Object {$_.name -eq "Pay-As-You-Go"}).Id

Select-AzSubscription -SubscriptionId $subid 

