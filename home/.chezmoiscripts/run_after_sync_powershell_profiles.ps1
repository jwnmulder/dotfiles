$mydocuments = [environment]::getfolderpath("mydocuments")

if (-Not $mydocuments.ToLower().StartsWith($env:USERPROFILE.ToLower())) {
    Copy-Item "$env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Destination "$mydocuments\WindowsPowerShell\" -Recurse
} 
