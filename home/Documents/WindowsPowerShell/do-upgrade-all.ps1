$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$IsAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (Get-Command winget -ErrorAction SilentlyContinue) {

    $wingetUpgradeCommand = "winget upgrade --all --silent"

    if (-not $IsAdmin) {
        $wingetUpgradeCommand += " --scope=user"
    }

    Write-Host "# winget - Running $wingetUpgradeCommand"
    Invoke-Expression $wingetUpgradeCommand
    Write-Host "# winget - Done running $wingetUpgradeCommand"
}
    
Write-Host "do-upgrade-all - All done"
