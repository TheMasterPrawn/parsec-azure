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
    [Parameter()][String]$key = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon",
    [Parameter()][String]$valueName = "AutoAdminLogon",
    [Parameter()][String]$valueData = "1",
    [Parameter()][ValidateSet('DWORD','STRING')]$valueType = "DWORD"
)

. .\common\Helpers.ps1

if (!(Test-Path -Path $key)) {
    Write-Log "Writing path $key in reg" -Severity Error
    New-Item -Path $key
}


try 
{
    $searchKey = Get-ItemProperty -Path $key -Name $valueName -ErrorAction SilentlyContinue
    if($null -eq $searchKey)
    {
        Write-Log "Writing property $valueName under path $key in reg to $valueData" -Severity Information -ErrorVariable $err
        New-ItemProperty -Path $key -PropertyType $valueType -Name $valueName -Value $valueData -Force
    }
    else 
    {
        Write-Log "Updating property $valueName under path $key in reg to $valueData" -Severity Information -ErrorVariable $err
        Set-ItemProperty -Path $key -Name $valueName -Value $valueData 
    }
}
catch 
{
    Write-Log "Error message : $err" -Severity Error
}

