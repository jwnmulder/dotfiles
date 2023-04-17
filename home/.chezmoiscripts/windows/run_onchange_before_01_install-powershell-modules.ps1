# '-ForceBootstrap' will Install the NuGet package provider if not already done
Get-PackageProvider -Name "NuGet" -ForceBootstrap

if (-not ((Get-PSRepository -Name "PSGallery" -ErrorAction SilentlyContinue).InstallationPolicy -eq "Trusted")) {
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
}

if (-not (Get-Module -Name PSScriptAnalyzer -ListAvailable)) {
    Install-Module -Name PSScriptAnalyzer -Scope CurrentUser
}
