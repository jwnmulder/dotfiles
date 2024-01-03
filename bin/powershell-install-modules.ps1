Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

$PSVersion = $PSVersionTable.PSVersion.ToString()
Write-Output "PSVersion=${PSVersion}, PSModulePath=${env:PSModulePath}"

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

function Install-Module-If-Missing {
    param(
        [Parameter(Mandatory,Position=0)]
        [string]$Name,

        [Parameter(Mandatory,Position=1)]
        [string]$MinimumVersion,

        [string]$Scope = "CurrentUser",
        [switch]$Force,
        [switch]$AllowClobber
    )

    if (-not (Get-Module -ListAvailable -FullyQualifiedName @{ModuleName=$Name;ModuleVersion=$MinimumVersion})) {
        Install-Module -Name $Name -Scope $Scope -MinimumVersion $MinimumVersion -Force:$Force -AllowClobber:$AllowClobber -ErrorAction 'Stop'
    }
}

# Needed for GitHubs 'windows-latest' image. Somehow version 1.4.7 is selected which is not working
Install-Module-If-Missing -Name "PackageManagement" -MinimumVersion 1.4.8 -Force -AllowClobber
Import-Module PackageManagement -MinimumVersion 1.4.8

Install-Module-If-Missing -Name "PowerShellGet" -MinimumVersion 2.0 -Force -AllowClobber

# '-ForceBootstrap' will Install the NuGet package provider if not already done
Get-PackageProvider -Name "NuGet" -ForceBootstrap

if (-not ((Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue).InstallationPolicy -eq "Trusted")) {
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
}

# PSScriptAnalyzer
Install-Module-If-Missing -Name PSScriptAnalyzer -MinimumVersion 1.0

# 2.1.0 has support for Predictive IntelliSense (F2 switches between InlineView and ListView)
# https://learn.microsoft.com/en-us/powershell/scripting/learn/shell/using-predictors?view=powershell-7.3$
Install-Module-If-Missing -Name PSReadLine -MinimumVersion 2.2.6 -Force -AllowClobber

# WslInterop
Install-Module-If-Missing -Name WslInterop -MinimumVersion 0.4.0
