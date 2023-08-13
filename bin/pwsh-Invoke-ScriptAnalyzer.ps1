#!/usr/bin/env pwsh -NoProfile

Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

if (-not (Get-InstalledModule -Name PSScriptAnalyzer)) {
    Install-Module -Name PSScriptAnalyzer -Scope CurrentUser
}

Invoke-ScriptAnalyzer @args
