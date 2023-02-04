# Set-Alias ngen (Join-Path ([Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory()) ngen.exe)
# ngen update

$env:STARSHIP_CONFIG = "$HOME\AppData\Local\starship\starship.toml"
Invoke-Expression (&"$HOME\AppData\Local\starship\starship.exe" init powershell)
   