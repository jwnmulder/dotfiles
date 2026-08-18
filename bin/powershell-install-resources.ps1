Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

$PSVersion = $PSVersionTable.PSVersion
Write-Output "PSVersion=${PSVersion}, PSModulePath=${env:PSModulePath}"

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath?view=powershell-7.6#starting-windows-powershell-from-powershell-7
# $HOME\Documents\WindowsPowerShell\Modules is missing when powershell.exe is started from within pwsh.exe
# When $HOME\Documents\WindowsPowerShell\Modules is not on $env:PSModulePath, installation errors might occure
$UserWinPSModulePath = Join-Path ([System.Environment]::GetFolderPath('MyDocuments')) 'WindowsPowerShell\Modules'
$modulePaths = $env:PSModulePath -split ';'
if ($UserWinPSModulePath -notin $modulePaths) {
    $env:PSModulePath = "$UserWinPSModulePath;$env:PSModulePath"
}

# Powershell Core comes with PSResourceGet installed
# PowerShell Desktop (version 5.1) requires an installation
if ($PSVersion.Major -eq 5) {
    $PSResourceGet = Get-Module Microsoft.PowerShell.PSResourceGet -ListAvailable
    if (-not $PSResourceGet) {
        Write-Output "Install/update Microsoft.PowerShell.PSResourceGet"
        Install-Module -Name "Microsoft.PowerShell.PSResourceGet" -Scope CurrentUser -Repository PSGallery
    }
}

# Trust PSGallery for PowerShellGet
if (Get-Command Get-PSRepository -ErrorAction SilentlyContinue) {
    if (-not ((Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue).InstallationPolicy -eq "Trusted")) {
        Write-Output "Trust PSGallery for PowerShellGet"
        Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
    }
}

# Trust PSGallery for PSResourceGet
if (-not ((Get-PSResourceRepository -Name "PSGallery" -ErrorAction SilentlyContinue).Trusted)) {
    Write-Output "Trust PSGallery for PSResourceGet"
    Set-PSResourceRepository -Name "PSGallery" -Trusted
}

# version ranges do not work yet, so we have to specify 1.23 for PSScriptAnalyzer
# https://github.com/PowerShell/PSResourceGet/issues/1776
$requiredResources = @{
    "PSScriptAnalyzer" = @{
        Version = '[1.25,)'
        Repository = 'PSGallery'
    }
    "PSReadLine" = @{
        Version = '[2.4.5,)'
        Repository = 'PSGallery'
    }
    "WslInterop" = @{
        Version = '[0.4.1,)'
        Repository = 'PSGallery'
    }
    "Microsoft.Windows.Developer" = @{
        Version = '[0.2,)'
        Repository = 'PSGallery'
        Prerelease = $true
    }
    "Microsoft.WinGet.Client" = @{
        Version = '[1.29.280,)'
        Repository = 'PSGallery'
    }
}

foreach ($item in $requiredResources.GetEnumerator()) {
    $name = $item.Key
    $version = $item.Value.Version
    $params = $item.Value

    # Check if the package is already installed with the required version
    $r = Get-InstalledPSResource -Name $name -Version $version -Scope CurrentUser -ErrorAction SilentlyContinue
    if (-not $r) {
        Write-Output "Installing $name version $version..."
        Install-PSResource -Name $name -Scope CurrentUser @params -Reinstall
    } else {
        $currentVersion = $r.Version
        Write-Output "$name version=$version currentVersion=$currentVersion - is already installed. Skipping..."
    }
}
