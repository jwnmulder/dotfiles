$env:STARSHIP_CONFIG = "$HOME\AppData\Local\starship\starship.toml"
Invoke-Expression (&"$HOME\AppData\Local\starship\starship.exe" init powershell)

Set-Alias do-upgrade-all $HOME\Documents\WindowsPowerShell\do-upgrade-all.ps1
