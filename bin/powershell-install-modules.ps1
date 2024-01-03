Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

$PSVersion = $PSVersionTable.PSVersion.ToString()
Write-Output "PSVersion=${PSVersion}, PSModulePath=${env:PSModulePath}"

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

if (-not (Get-Module -ListAvailable -FullyQualifiedName @{ModuleName="PackageManagement";ModuleVersion="1.4.8"})) {
    Install-Module PackageManagement -Scope CurrentUser -MinimumVersion 1.4.8.0 -Force -AllowClobber
}

# Needed for GitHubs 'windows-latest' image. Somehow version 1.4.7 is selected which is not working
Import-Module PackageManagement -MinimumVersion 1.4.8

if (-not (Get-Module -ListAvailable -FullyQualifiedName @{ModuleName="PowerShellGet";ModuleVersion="2.0"})) {
    Install-Module PowerShellGet -Scope CurrentUser -MinimumVersion 2.0 -Force -AllowClobber
}

# '-ForceBootstrap' will Install the NuGet package provider if not already done
Get-PackageProvider -Name "NuGet" -ForceBootstrap

if (-not ((Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue).InstallationPolicy -eq "Trusted")) {
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
}

# PSScriptAnalyzer
if (-not (Get-Module -ListAvailable -FullyQualifiedName @{ModuleName="PSScriptAnalyzer";ModuleVersion="1.0"})) {
    Install-Module -Name PSScriptAnalyzer -Scope CurrentUser
}

# 2.1.0 has support for Predictive IntelliSense (F2 switches between InlineView and ListView)
# https://learn.microsoft.com/en-us/powershell/scripting/learn/shell/using-predictors?view=powershell-7.3$
if (-not (Get-Module -ListAvailable -FullyQualifiedName @{ModuleName="PSReadLine";ModuleVersion="2.2.6"})) {
    Install-Module PSReadLine -Scope CurrentUser -MinimumVersion 2.2.6 -Force -AllowClobber
}
