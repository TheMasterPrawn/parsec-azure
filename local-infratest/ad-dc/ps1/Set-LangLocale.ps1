
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
function Set-LocaleGB
{
    Write-host "Set-LocaleGB"
    # Adapted from https://www.lewisroberts.com/2017/03/01/set-language-culture-timezone-using-powershell/
    # Set Locale, language etc. 
    $xml = '"
    <gs:GlobalizationServices xmlns:gs="urn:longhornGlobalizationUnattend"> 
    <!--User List-->
    <gs:UserList>
        <gs:User UserID="Current" CopySettingsToDefaultUserAcct="true" CopySettingsToSystemAcct="true"/> 
    </gs:UserList>
    <!-- user locale -->
    <gs:UserLocale> 
        <gs:Locale Name="en-GB" SetAsCurrent="true"/> 
    </gs:UserLocale>
    <!-- system locale -->
    <gs:SystemLocale Name="en-GB"/>
    <!-- GeoID -->
    <gs:LocationPreferences> 
        <gs:GeoID Value="242"/> 
    </gs:LocationPreferences>
    <gs:MUILanguagePreferences>
        <gs:MUILanguage Value="en-GB"/>
        <gs:MUIFallback Value="en-US"/>
    </gs:MUILanguagePreferences>
    <!-- input preferences -->
    <gs:InputPreferences>
        <!--en-GB-->
        <gs:InputLanguageID Action="add" ID="0809:00000809" Default="true"/> 
    </gs:InputPreferences>
    </gs:GlobalizationServices>"'

    $xml | Out-File -FilePath UKRegion.xml
    
    & $env:SystemRoot\System32\control.exe "intl.cpl,,/f:`"UKRegion.xml`""
     # Set Timezone
    & tzutil /s "GMT Standard Time"
    
    # Set languages/culture
    Set-Culture en-GB # This one works!
}

function Disable-IEESC 
{
    Write-host "Disable-IEESC"
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
    #Stop-Process -Name Explorer
    Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green
}
    

function Set-engb
{
    $LanguageList = Get-WinUserLanguageList
    $LanguageList.Add("en-GB")
    Set-WinUserLanguageList $LanguageList -force
    $psdrive = New-PSDrive -PSProvider Registry -Name HKU -Root HKEY_USERS
    Set-ItemProperty -Path "HKU:\.DEFAULT\Keyboard Layout\Preload\" -Name 1 -Value 00000809
    $psdrive | Remove-PSDrive
    Set-WinUserLanguageList en-GB -force # for locale bug with keyboard setting
}

Set-LocaleGB
Disable-IEESC
Set-engb
