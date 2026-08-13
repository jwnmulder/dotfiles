Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

$userprofile_documents = "$env:USERPROFILE\Documents"  # local folder
$mydocuments = [environment]::getfolderpath("mydocuments")  # can be a local or OneDrive folder

# Prints all profile locations
# $profile | Select-Object *

if (-Not $mydocuments.ToLower().StartsWith($userprofile_documents.ToLower())) {

    # Sync profile for PowerShell Desktop (built-in)
    New-Item -Path "$mydocuments\WindowsPowerShell" -ItemType Directory -Force | Out-Null
    Copy-Item "$userprofile_documents\WindowsPowerShell\profile.ps1" -Destination "$mydocuments\WindowsPowerShell\" -Recurse

    # Sync profile for PowerShell Core (separately installed PowerShell, version 7+)
    New-Item -Path "$mydocuments\PowerShell" -ItemType Directory -Force | Out-Null
    Copy-Item "$userprofile_documents\WindowsPowerShell\profile.ps1" -Destination "$mydocuments\PowerShell\" -Recurse
}
