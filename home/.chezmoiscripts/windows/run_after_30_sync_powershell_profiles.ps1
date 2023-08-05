Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

$userprofile_documents = "$env:USERPROFILE\Documents"
$mydocuments = [environment]::getfolderpath("mydocuments")

if (-Not $mydocuments.ToLower().StartsWith($userprofile_documents.ToLower())) {
    Copy-Item "$userprofile_documents\WindowsPowerShell\profile.ps1" -Destination "$mydocuments\WindowsPowerShell\" -Recurse
}
