@echo off

@rem https://github.com/PowerShell/PowerShell/issues/18108
@rem https://github.com/PowerShell/PowerShell/issues/8635#issuecomment-454028787
@rem https://github.com/PowerShell/PowerShell/issues/6850#issuecomment-1272640607
@rem https://github.com/twpayne/chezmoi/issues/2589

set PSModulePath=

powershell.exe %*
