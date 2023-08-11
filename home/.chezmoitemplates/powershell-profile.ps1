$env:STARSHIP_CONFIG = "$HOME\AppData\Local\starship\starship.toml"

# https://github.com/starship/starship/issues/2057#issuecomment-831336770
&"$HOME\AppData\Local\starship\starship.exe" init powershell --print-full-init | Out-String | Invoke-Expression

Set-Alias do-upgrade-all $HOME\Documents\WindowsPowerShell\do-upgrade-all.ps1

. $HOME\Documents\WindowsPowerShell\completions\_chezmoi.ps1
