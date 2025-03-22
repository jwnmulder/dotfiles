# dsc

The DSC v3 configurations in this repository require powershell resources to be setup correctly.

These pre-requisites are managed via `bin/powershell-install-resources.ps1` which will configure the powershell session as configured in the chezmoi.yaml configuration file. This chezmoi.yaml configuration prefers PowerShell Core over PowerShell Desktop unless specified otherwise via the `CHEZMOI_PS1_COMMAND` environment variable.

To test that the pre-requisites are setup correctly. The following commands help

```powershell
dsc resource list --adapter Microsoft.DSC/PowerShell
dsc resource list --adapter Microsoft.Windows/WindowsPowerShell
```

To test the DSC v3 configuration files, the following might help

```powershell
dsc -l info config test --file $env:USERPROFILE/.config/dsc/windows_desktop_config.dsc.yaml
dsc -l info config test --file $env:USERPROFILE/.config/dsc/windows_desktop_config_elevated.dsc.yaml
```

To check:

* WSL setup: <https://github.com/addianto/dotfiles/blob/master/windows/configurations/setupWSL.dsc.yaml>
* More Microsoft.Windows.Developer settings
  * <https://github.com/ddieppa/configuration-files/blob/main/windows.settings.dsc.yaml>
  * <https://github.com/microsoft/winget-dsc/blob/main/samples/DscResources/Microsoft.Windows.Developer/ModifyWindowsSettings.yaml>
* Something about fonts: <https://github.com/dyskette/.dotconfigs/blob/master/windows/configuration.dsc.yaml>
