<#
.SYNOPSIS
    Disables windows update
.DESCRIPTION
    https://docs.microsoft.com/en-gb/archive/blogs/jamesone/managing-windows-update-with-powershell
.NOTES
    NOTES
.INPUTS
    N/A
.OUTPUTS
    N/A
.EXAMPLE
#>

$AUSettings = (New-Object -com "Microsoft.Update.AutoUpdate").Settings
$AUSettings.NotificationLevel = 1 
$AUSettings.Save
