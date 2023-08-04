#Requires -Modules @{ ModuleName="PowerShellGet"; ModuleVersion="2.0.0" }

Import-Module -Name "PowerShellGet"
Import-Module -Name "PackageManagement"

$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

#region winget
if (Get-Command winget -ErrorAction SilentlyContinue) {

    $cmd = "winget upgrade --all --silent"

    if (-not $isAdmin) {
        $cmd += " --scope=user"
    }

    Write-Host "# winget - Running $cmd"
    Invoke-Expression $cmd
    Write-Host "# winget - Done running $cmd" -ForegroundColor Green
}
#endregion

#region scoop
if (Get-Command scoop -ErrorAction SilentlyContinue) {

    $cmd = "scoop update --all"

    if ($isAdmin) {

        Write-Host "# scoop - Skipping $cmd as we are running as Administrator" -ForegroundColor Cyan

    } else {

        Write-Host "# scoop - Ensure correct permissions $cmd"
        takeown /f $env:USERPROFILE\scoop\buckets /r >$null

        Write-Host "# scoop - Running $cmd"
        Invoke-Expression $cmd
        Write-Host "# scoop - Done running $cmd" -ForegroundColor Green
    }
}
#endregion

#region powershell modules
Write-Host "# pwsh - Updating powershell modules"

$pwsh_cmd = "Update-Module -Confirm"
if (-not $isAdmin) {
    $pwsh_cmd += " -Scope CurrentUser"
}

Write-Host "# pwsh - Running $pwsh_cmd"
Invoke-Expression $pwsh_cmd

Write-Host "# pwsh - Cleanup of old powershell module versions"
$InstalledModules = Get-InstalledModule
foreach ($mod in $InstalledModules) {
    $Latest = Get-InstalledModule $mod.Name; 
    Get-InstalledModule $mod.Name -AllVersions | ? {$_.Version -ne $Latest.Version} | Uninstall-Module
}

Remove-Variable -Name "pwsh_cmd"
Remove-Variable -Name "InstalledModules"

Write-Host "# pwsh - Done updating powershell modules" -ForegroundColor Green
#endregion

Write-Host "do-upgrade-all - All done"
