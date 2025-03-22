Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

$PSVersion = $PSVersionTable.PSVersion
Write-Output "PSVersion=${PSVersion}, PSModulePath=${env:PSModulePath}"

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process

# Get-Module -ListAvailable


# https://learn.microsoft.com/en-US/powershell/gallery/powershellget/install-powershellget?view=powershellget-3.x

# using Get-Command loads the module after which it cannot be updated unless the
# current shell is restarted
# if (-not (Get-Command Install-PSResource -FullyQualifiedModule @{ModuleName="Microsoft.dPowerShell.PSResourceGet";ModuleVersion="1.1.0"} -ErrorAction SilentlyContinue)) {

# Get-Module -ListAvailable "Microsoft.PowerShell.PSResourceGet"

if (-not (Get-Module -ListAvailable "Microsoft.PowerShell.PSResourceGet" | Where-Object { $_.Version -ge [version]"1.1.0" })) {
    Write-Output "Microsoft.PowerShell.PSResourceGet not installed, will install now"

    # Update PowerShellGet on Powershell v5 as it is too old to install Microsoft.PowerShell.PSResourceGet
    if ($PSVersion.Major -eq 5) {
        Write-Output "Install/update PowerShellGet"
        Install-Module -Name "PowerShellGet" -Scope CurrentUser -Force -AllowClobber
    }

    Write-Output "Install/update Microsoft.PowerShell.PSResourceGet"
    Install-Module -Name "Microsoft.PowerShell.PSResourceGet" -Scope CurrentUser -Repository PSGallery -Force

    # Import-Module "Microsoft.PowerShell.PSResourceGet" -Force
}
