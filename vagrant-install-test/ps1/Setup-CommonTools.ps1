
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
$ErrorActionPreference = "Continue"
    
function Get-Packages($installers  =  @('git.install', 'vscode', 'firefox', 
                                        'speedtest','microsoft-windows-terminal', 'parsec'))
{
    Set-ExecutionPolicy Bypass -Scope Process -Force

    Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

    foreach($installer in $installers)
    {
        choco install $installer -y 
    }
}

function Set-PSHpackages
{
    Write-Host "Install-PackageProvider -Name Nuget -force"
    Install-PackageProvider -Name Nuget -force
    Write-Host "Set-PSHpackages"
    Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery -Confirm:$false
    Write-Host "Trusting PSgallery"
    Set-PSRepository -name "PSGallery" -InstallationPolicy Trusted 
    #Write-Host "Install-Module -Name Az -Confirm:$false"
    #Install-Module -Name Az -Confirm:$false
    #Write-Host "Install-Module -Name MSOnline -Confirm:$false"
    #Install-Module -Name MSOnline -Confirm:$false
}

Set-PSHpackages
Get-Packages

# Set-PSHpackages





