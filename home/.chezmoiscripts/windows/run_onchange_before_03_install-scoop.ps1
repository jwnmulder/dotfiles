Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Installing scoop"
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
}
