
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
$ErrorActionPreference = "Continue"
    
function Get-Packages
{
    #Set-ExecutionPolicy Bypass -Scope Process -Force
    # Inshtall Shtuff
    Invoke-Expression ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

    choco install git.install -y
    choco install bginfo -y # machine info
    choco install vscode -y
    choco install firefox -y
    
    #choco install speedtest -y

    # Update management framework
    #powershell.exe -NoLogo -NoProfile -Command '[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Install-Module -Name PackageManagement -Force -MinimumVersion 1.4.6 -Scope CurrentUser -AllowClobber -Repository PSGallery'

    <#
    choco install visualstudio2019professional --package-parameters " --quiet
        --add Microsoft.VisualStudio.Workload.ManagedDesktop;includeRecommended;includeOptional" -y
        

    choco install visualstudio2019professional --package-parameters " --quiet
        --add Microsoft.VisualStudio.Workload.Azure;includeRecommended;includeOptional
        --add Microsoft.VisualStudio.Workload.Data;includeRecommended;includeOptional 
        --add Microsoft.VisualStudio.Workload.ManagedDesktop;includeRecommended;includeOptional" -y
    #>

    #choco install dotnet4.7.2 -y
    #choco install dotnetcore-3.1-sdk -y # contains runtime
    #choco install netfx-4.7.2-devpack -y
    Write-Host "Blooop"

    #choco install powershell -y # Need powershell 5, needs reboot
    # Set local administrator password
    #$user = [adsi]"WinNT://localhost/Administrator,user"
    #$user.SetPassword("P@ssword1")
    #$user.SetInfo()

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

Set-PSHpackages
Get-Packages


