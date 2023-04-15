if (-not (Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)) {
    Install-PackageProvider -Name NuGet -Scope CurrentUser -Force
}

if (-not (Get-PSRepository -Name "PSGallery").InstallationPolicy -eq "Trusted") {
    Write-Output "PSGallery InstallationPolicy Trusted"
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
}

Install-Module -Name PSScriptAnalyzer -Scope CurrentUser
