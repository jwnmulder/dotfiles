#!/usr/bin/env pwsh

Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

if (-not (Get-InstalledModule -Name PSScriptAnalyzer -ErrorAction SilentlyContinue)) {
    Install-Module -Name PSScriptAnalyzer -Scope CurrentUser -Force
}

# Write-Host @args
Import-Module PSScriptAnalyzer

Invoke-ScriptAnalyzer @args
