# ------------------------------------------------------------------------------
#           User Preferences: Explorer, Taskbar, and System Tray
# ------------------------------------------------------------------------------
Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

function Update-ItemProperty {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='Low')]
    param(
        [Parameter(Mandatory = $True)][String]$Path,
        [Parameter(Mandatory = $True)][String]$Name,
        [Parameter(Mandatory = $True)]$Value,
        [Parameter(Mandatory = $True)][String]$Description
    )

    $CurrentValue = Get-ItemPropertyValue -Path $Path -Name $Name
    if ($Value -ne $CurrentValue) {
        Write-Output "$Description - Updating '$Name' from $CurrentValue to $Value"
        if ($PSCmdlet.ShouldProcess("$Path - $Name=$Value")) {
            $keyName = $Path.Replace("HKCU:", "HKEY_CURRENT_USER")
            [microsoft.win32.registry]::SetValue($keyName, $Name, $Value)
        }
    }
    else {
        Write-Output "$Description - Skipping, '$Name' already set to $Value"
    }
}

Write-Output "Configuring Explorer, Taskbar, and System Tray..."

# Explorer: Show hidden files by default: Show Files: 1, Hide Files: 2
Update-ItemProperty -Description "Explorer: Show hidden files by default" `
    -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
    -Name "Hidden" -Value 0

# Explorer: Show file extensions by default: Show Extensions: 0, Hide Extensions: 1
Update-ItemProperty -Description "Explorer: Show file extensions by default" `
    -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
    -Name "HideFileExt" -Value 0

Write-Output "Completed configuration of Explorer, Taskbar, and System Tray"
