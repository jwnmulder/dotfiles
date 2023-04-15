Install-PackageProvider -Name NuGet -Scope CurrentUser -Force

Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

Install-Module -Name PSScriptAnalyzer -Scope CurrentUser
