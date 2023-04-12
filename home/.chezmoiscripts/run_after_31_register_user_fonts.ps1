Set-StrictMode -Version latest
$ErrorActionPreference = "Stop"

$shell = New-Object -ComObject Shell.Application
# $FONTS = 0x14
# $objFolder = $shell.Namespace($FONTS)

$fontsPath = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
$shellFontsFolder = $shell.Namespace($fontsPath)

$userFontsRegistryPath = 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts'
If (-not (Test-Path $userFontsRegistryPath)) {
  New-Item -Path $userFontsRegistryPath
}

Get-ChildItem $fontsPath -Filter *.ttf | foreach-object {

    $fontFile = $_.FullName
    $fontFileName = $_.Name

    $shellFontFile = $shellFontsFolder.ParseName($fontFileName)
    $shellFontFileType = $shellFontsFolder.GetDetailsOf($shellFontFile, 2)
    $shellFontFileTitle = $shellFontsFolder.GetDetailsOf($shellFontFile, 21)

    if ($shellFontFileType -Like '*TrueType font file*') {
      $fontType = "(TrueType)"
    } else {
      $fontType = ""
    }

    $fontName = $shellFontFileTitle + ' ' + $fontType

    # Write-Host "Registering '${fontName}': ${fontFile}"
    New-ItemProperty -Path $userFontsRegistryPath -Name $fontName -Value $fontFile -PropertyType String -Force | Out-Null
}
