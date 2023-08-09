Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

# Needed for GitHubs 'windows-latest' image. Somehow version 1.4.7 is selected which is not working
Import-Module PackageManagement -MinimumVersion 1.4.8

# '-ForceBootstrap' will Install the NuGet package provider if not already done
Get-PackageProvider -Name "NuGet" -ForceBootstrap

if (-not ((Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue).InstallationPolicy -eq "Trusted")) {
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
}

if (-not (Get-InstalledModule -Name "PowerShellGet" -MinimumVersion 2.0 -ErrorAction SilentlyContinue)) {
    Install-Module PowerShellGet -Scope CurrentUser -MinimumVersion 2.0 -Force -AllowClobber
}

# PSScriptAnalyzer
if (-not (Get-Module -Name PSScriptAnalyzer -ListAvailable)) {
    Install-Module -Name PSScriptAnalyzer -Scope CurrentUser
}

# 2.1.0 has support for Predictive IntelliSense (F2 switches between InlineView and ListView)
# https://learn.microsoft.com/en-us/powershell/scripting/learn/shell/using-predictors?view=powershell-7.3$
if (-not (Get-InstalledModule -Name "PSReadLine" -MinimumVersion 2.2.6 -ErrorAction SilentlyContinue)) {
    Install-Module PSReadLine -Scope CurrentUser -MinimumVersion 2.2.6 -Force -AllowClobber
}
