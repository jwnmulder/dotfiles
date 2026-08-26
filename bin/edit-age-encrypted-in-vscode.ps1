param(
    [Parameter(Mandatory = $true)]
    [string]$EncryptedFile
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $EncryptedFile -PathType Leaf)) {
    Write-Error "$EncryptedFile not found"
    exit 1
}

$base = if ($EncryptedFile.EndsWith(".age")) {
    $EncryptedFile.Substring(0, $EncryptedFile.Length - 4)
} else {
    $EncryptedFile
}

$ext = [System.IO.Path]::GetExtension($base).TrimStart('.')
$tmpFile = Join-Path $env:TEMP "agefile.tmp.$ext"

try {
    chezmoi decrypt $EncryptedFile | Set-Content -Path $tmpFile

    & code --wait $tmpFile

    if ($LASTEXITCODE -eq 0) {
        chezmoi encrypt $tmpFile | Set-Content -Path $EncryptedFile
    }
}
finally {
    if (Test-Path $tmpFile) {
        Remove-Item $tmpFile -Force
    }
}
