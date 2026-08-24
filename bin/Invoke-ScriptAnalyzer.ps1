#!/usr/bin/env pwsh -NoProfile -NoLogo

Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

# This makes running PSScriptAnalyzer faster on wsl2
$env:PATH = ($env:PATH -split ':' | Where-Object { $_ -notlike '/mnt/c/*' }) -join ':'

if (-not (Get-Module -ListAvailable -Name PSScriptAnalyzer -ErrorAction SilentlyContinue)) {
    Install-Module -Name PSScriptAnalyzer -Scope CurrentUser -Force
}

Import-Module PSScriptAnalyzer

Invoke-ScriptAnalyzer @args
