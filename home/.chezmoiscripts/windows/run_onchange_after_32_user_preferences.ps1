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

    if (!(Test-Path $Path)) {
        # if ($PSCmdlet.ShouldProcess("$Path")) {
        #     New-Item -Path $Path -Force
        # }
        Write-Output "WARN: Skipping $Name as $Path does not exist"
    } else {
        if (!(Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue)) {
            Write-Output "$Description - Creating registry key $Name in $Path"
            New-ItemProperty -Path $Path -Name $Name | Out-Null
        }
        $CurrentValue = Get-ItemPropertyValue -Path $Path -Name $Name

        if (!$Value.equals($CurrentValue)) {
            Write-Output "$Description - Updating '$Name' from $CurrentValue to $Value"
            if ($PSCmdlet.ShouldProcess("$Path - $Name=$Value")) {
                # Using [microsoft.win32.registry]::SetValue instead of
                # Set-ItemPropertyValue as it updates the registry type at the same time
                $keyName = $Path.Replace("HKCU:", "HKEY_CURRENT_USER")
                [microsoft.win32.registry]::SetValue($keyName, $Name, $Value)
            }
        } else {
            Write-Output "$Description - Skipping, '$Name' already set to $Value"
        }
    }
}

Write-Output "Configuring Windows user preferences"

# Explorer: Show hidden files by default: Show Files: 1, Hide Files: 2
Update-ItemProperty -Description "Explorer: Show hidden files by default" `
    -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
    -Name "Hidden" -Value 0

# Explorer: Show file extensions by default: Show Extensions: 0, Hide Extensions: 1
Update-ItemProperty -Description "Explorer: Show file extensions by default" `
    -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" `
    -Name "HideFileExt" -Value 0

Update-ItemProperty -Description "Search: Bing search disabled" `
    -Path "HKCU:\SOFTWARE\MicrosoftJW\Windows\CurrentVersion\Search" `
    -Name "BingSearchEnabled" -Value 0

Write-Output "Completed configuration of Windows user preferences"
