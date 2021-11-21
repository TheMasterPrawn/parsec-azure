
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
$ErrorActionPreference = "Continue"
    
function Get-Packages
{
    #Set-ExecutionPolicy Bypass -Scope Process -Force
    # Inshtall Shtuff
    Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

    choco install git.install -y
    choco install vscode -y
    choco install firefox -y
    choco install speedtest -y
    choco install microsoft-windows-terminal -y
}

function Set-PSHpackages
{
    Write-Host "Install-PackageProvider -Name Nuget -force"
    Install-PackageProvider -Name Nuget -force
    Write-Host "Set-PSHpackages"
    Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery -Confirm:$false
    Write-Host "Trusting PSgallery"
    Set-PSRepository -name "PSGallery" -InstallationPolicy Trusted 
    Write-Host "Install-Module -Name Az -Confirm:$false"
    Install-Module -Name Az -Confirm:$false
    Write-Host "Install-Module -Name MSOnline -Confirm:$false"
    Install-Module -Name MSOnline -Confirm:$false
}

Get-Packages

# Set-PSHpackages
$thePath = "c:\parsec-config"
New-Item -ItemType Directory $thePath
Set-Location  -Path $thePath
git pull https://github.com/TheMasterPrawn/parsec-azure.git



