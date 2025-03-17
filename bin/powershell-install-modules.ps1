Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

$PSVersion = $PSVersionTable.PSVersion
Write-Output "PSVersion=${PSVersion}, PSModulePath=${env:PSModulePath}"

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

# Needed for GitHubs 'windows-latest' image. Somehow version 1.4.7 is selected which is not working
# Install-Module-If-Missing -Name "PackageManagement" -MinimumVersion 1.4.8 -Force -AllowClobber
# Import-Module PackageManagement -MinimumVersion 1.4.8

# https://learn.microsoft.com/en-US/powershell/gallery/powershellget/install-powershellget?view=powershellget-3.x
if (-not (Get-Command Install-PSResource -FullyQualifiedModule @{ModuleName="Microsoft.PowerShell.PSResourceGet";ModuleVersion="1.0"} -ErrorAction SilentlyContinue)) {
    Write-Output "Microsoft.PowerShell.PSResourceGet not installed, will install now"

    # Update PowerShellGet on Powershell v5 as it is too old to install Microsoft.PowerShell.PSResourceGet
    if ($PSVersion.Major -eq 5) {
        Install-Module -Name "PowerShellGet" -Scope CurrentUser -Force -AllowClobber -Confirm
    }

    Install-Module -Name "Microsoft.PowerShell.PSResourceGet" -Scope CurrentUser -Repository PSGallery -Confirm
}

# # '-ForceBootstrap' will Install the NuGet package provider if not already done
# Get-PackageProvider -Name "NuGet" -ForceBootstrap

# Trust PSGallery for PowerShellGet
if (Get-Command Get-PSRepository -ErrorAction SilentlyContinue) {
    if (-not ((Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue).InstallationPolicy -eq "Trusted")) {
        Write-Output "Trust PSGallery for PowerShellGet"
        Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
    }
}

# Trust PSGallery for PSResourceGet
if (Get-Command Get-PSResourceRepository -ErrorAction SilentlyContinue) {
    if (-not ((Get-PSResourceRepository -Name "PSGallery" -ErrorAction SilentlyContinue).Trusted)) {
        Write-Output "Trust PSGallery for PSResourceGet"
        Set-PSResourceRepository -Name "PSGallery" -Trusted
    }
}

# https://github.com/PowerShell/PSResourceGet/issues/1776
$requiredResources = @{
    "PSScriptAnalyzer" = @{
        Version = '[1.23,)'
        Repository = 'PSGallery'
    }
    "PSReadLine" = @{
        Version = '[2.2.6,)'
        Repository = 'PSGallery'
    }
    "WslInterop" = @{
        Version = '[0.4.0,)'
        Repository = 'PSGallery'
    }
    "Microsoft.Windows.Developer" = @{
        Version = '[0.2,)'
        Repository = 'PSGallery'
        Prerelease = $true
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
