<#
.SYNOPSIS
    Helper functions in PowerShell
.DESCRIPTION

.NOTES
    Get-Objects gets a ps list from a data source, such as SQL or parsed JSON and returns a PS
    native object with all properties as notefields. 

    Contains functions and config pertinant to logging.
.INPUTS
    N/A
.OUTPUTS
    N/A
#>

# Globals
$logLocation = "log"
$dataLocation = "data"

Function Get-Objects($objData)
{   
    <#
    .SYNOPSIS
        Takes a list of objects in an array and return them as a list of PowerShell Objects.

    .DESCRIPTION
        Takes an array of elements and loops through the properties to create a custom Object.

    .PARAMETER objData
        An array of elements taken from some lookup, such as a SQL query or web response.

    .INPUTS
        Array of elements

    .OUTPUTS
        PSCustomObject

    .NOTES
        Author:  Rob Allen
    #>

    $OBJs = @()
    foreach ($row in $objData) 
    {
        $rowDetail = New-Object PSCustomObject

        foreach($object_properties in $row.PsObject.Properties)
        {
            $rowDetail | Add-Member -MemberType NoteProperty -Name  $object_properties.Name `
             -Value $object_properties.Value
        }
        $OBJs = $OBJs + $rowDetail
    }
    return $OBJs;
}

function Write-Log {
    <#
    .SYNOPSIS
        Writes to a log directory.

    .DESCRIPTION
        Writes to a log file in the \log folder.

    .PARAMETER Message
        The message you want written to the file or to the console.

    .PARAMETER Severity
        The severity of the message 'Information','Warning','Error','Success'.
    
    .PARAMETER WriteConsole
        Set to true to write to the console. False will supress console output. 

    .NOTES
        Author:  Rob Allen
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$Message,
 
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Information','Warning','Error','Success')]
        [string]$Severity = 'Information',

        [bool]$WriteConsole = $true
    )
    
    Switch ($Severity)
    {
        "Information" {$color = "White"}
        "Warning"     {$color = "Yellow"}
        "Error"       {$color = "Red"}
        "Success"     {$color = "Green"}
    }
    if ($WriteConsole) {
        Write-Host $Message -ForegroundColor $color
    }

    $fdate = Get-Date -Format "dd_MM_yyyy"
    $fdate = $fdate.ToString()
    [PSCustomObject]@{
        Time = (Get-Date -f g)
        Message = $Message
        Severity = $Severity
        Tool = $myInvocation.ScriptName
    } | Export-Csv -Path "log\$fdate.LogFile.csv" -Append -NoTypeInformation
 }

 function New-SupportingFolder([String]$path)
 {
     <#
    .SYNOPSIS
        Created a folder for supporting logging and operations.

    .DESCRIPTION
        Make a folder in scriptroot and return the full path to the caller.

    .PARAMETER path
        Single name of the folder.

    .OUTPUTS
        Full path to the folder

    .NOTES
        Author:  Rob Allen
    #>
    if( (Test-Path -Path $path -ErrorAction SilentlyContinue) -eq $false )
    {
        New-Item -ItemType "directory" -Path $path
    }
    $location = (Get-Item $path).FullName
    return $location
}

function Get-ListFromObjectArray($p)
{
    <#
    .SYNOPSIS
        Copies a PSObject into an ArrayList to gind to Winform Datagrid

    .DESCRIPTION
        Creates a file save windows dialog and returns the filename.

    .PARAMETER p
        A array of PSObject.

    .OUTPUTS
        List of type ArrayList.

    .NOTES
        Author:  Rob Allen
    #>
    $list = New-Object System.collections.ArrayList
    $list.AddRange($p)
    return $list
} 

function Get-ScriptDirectory {
    Split-Path -parent $PSCommandPath
}

$logLocation  = New-SupportingFolder $logLocation
$dataLocation = New-SupportingFolder $dataLocation
