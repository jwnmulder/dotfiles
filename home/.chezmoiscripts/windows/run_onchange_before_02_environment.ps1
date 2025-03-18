Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

function Add-EnvPath {
    param(
        [Parameter(Mandatory=$true)]
        [string] $Path,

        [ValidateSet('Machine', 'User', 'Session')]
        [string] $Container = 'Session'
    )

    <#
    Using the .NET registry calls is necessary here in order to preserve environment variables embedded in PATH values;
    Powershell's registry provider doesn't provide a method of preserving variable references, and we don't want to
    accidentally overwrite them with absolute path values. Where the registry allows us to see "%SystemRoot%" in a PATH
    entry, PowerShell's registry provider only sees "C:\Windows", for example.
    #>
    if ($Container -ne 'Session') {
        $envRegKey = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey('Environment', $true)
        if ($Container -eq "Machine") {
            $envRegKey = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey('SYSTEM\ControlSet001\Control\Session Manager\Environment\',$true)
        }

        $envPath = $envRegKey.GetValue('Path', [string]::Empty, 'DoNotExpandEnvironmentNames').ToString()
        $envPaths = $envPath -split [System.IO.Path]::PathSeparator
        if ($envPaths -notcontains $Path) {
            $envPaths = $envPaths + $Path | Where-Object { $_ }

            # NEVER use [Environment]::SetEnvironmentVariable() for PATH values; see https://github.com/dotnet/corefx/issues/36449
            # This issue exists in ALL released versions of .NET and .NET Core as of 12/19/2019
            $envRegKey.SetValue('Path', $envPaths -join [System.IO.Path]::PathSeparator, 'ExpandString')
        }
    }

    $envPaths = $env:Path -split [System.IO.Path]::PathSeparator
    if ($envPaths -notcontains $Path) {
        $envPaths = $envPaths + $Path | Where-Object { $_ }
        $env:Path = $envPaths -join [System.IO.Path]::PathSeparator
    }
}

Add-EnvPath -Container User -Path "$env:USERPROFILE\.local\bin"
Add-EnvPath -Container User -Path "$env:USERPROFILE\.krew\bin"
