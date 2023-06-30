$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (Get-Command winget -ErrorAction SilentlyContinue) {

    $cmd = "winget upgrade --all --silent"

    if (-not $isAdmin) {
        $cmd += " --scope=user"
    }

    Write-Host "# winget - Running $cmd"
    Invoke-Expression $cmd
    Write-Host "# winget - Done running $cmd" -ForegroundColor Green
}

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

Write-Host "do-upgrade-all - All done"
