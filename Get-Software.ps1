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

. .\common\Helpers.ps1
function Get-Software($software = "software.csv")
{
    $installers = Import-Csv $software

    foreach($installer in $installers)
    {
        $uri = $installer.Uri
        Write-Log "Getting $uri" -severity Information
        .\Get-WebContent.ps1 -URI $uri -localFile $installer.path
    }
}

function Set-Software($software = "software.csv")
{
    $installers = Import-Csv $software

    
    foreach($installer in $installers)
    {
        if($installer.Type -eq "ZIP")
        {
            Expand-Archive -LiteralPath $installer.Path -DestinationPath C:\parsec-azure\data -Force
        }
    }

    foreach($installer in $installers)
    {
        $cmd   = $installer.Installer
        $argsv = $installer.InstallArgs
        Start-Process -Wait -FilePath $cmd -ArgumentList $argsv -PassThru
    }
}

Get-Software
Set-Software

