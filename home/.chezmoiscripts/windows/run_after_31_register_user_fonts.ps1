Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

$shell = New-Object -ComObject Shell.Application

$downloadedFontsPath = "$env:USERPROFILE\.cache\chezmoi\fonts"
$fontsPath = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
$userFontsRegistryPath = 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts'

function Get-FontName {
  param(
    [System.IO.FileInfo]$fontFile
  )

  $fontFilePath = $fontFile.Directory.FullName
  $shellFolder = $shell.NameSpace($fontFilePath)

  $shellFontFile = $shellFolder.ParseName($fontFile.Name)
  $shellFontFileType = $shellFolder.GetDetailsOf($shellFontFile, 2)
  $shellFontFileTitle = $shellFolder.GetDetailsOf($shellFontFile, 21)

  if ($shellFontFileType -Like '*TrueType font file*') {
    $fontType = "(TrueType)"
  }
  else {
    $fontType = ""
  }

  $fontName = $shellFontFileTitle + ' ' + $fontType

  return $fontName
}

If (-not (Test-Path $userFontsRegistryPath)) {
  New-Item -Path $userFontsRegistryPath
}

# Copy or update existing fonts in the users local font dir
Get-ChildItem $downloadedFontsPath -Filter *.ttf -Recurse | foreach-object {

  $srcFile = $_
  $dstFile = Get-Item (Join-Path $fontsPath $srcFile.Name) -ErrorAction SilentlyContinue

  $fontOutdated = $dstFile -eq $null
  if (-not $fontOutdated) {
    $srcHash = (Get-FileHash $srcFile.FullName).Hash
    $dstHash = (Get-FileHash $dstFile.FullName).Hash

    $fontOutdated = -not $srcHash -eq $dstHash
  }

  if ($fontOutdated) {
    $fontName = Get-FontName $srcFile
    Write-Output "Font outdated, updating '$fontName'"

    Remove-ItemProperty -Path $userFontsRegistryPath -Name $fontName -ErrorAction SilentlyContinue

    if ($dstFile) {
      # Delete file with -Force to avoid 'file used by another process' error
      Remove-Item $dstFile.FullName -Force
    }

    Copy-Item -Path $srcFile.FullName -Destination $fontsPath
  }
}

# Register all fonts in Windows registry if not already done
Get-ChildItem $fontsPath -Filter *.ttf | foreach-object {

  $fontFileFullName = $_.FullName
  $fontName = Get-FontName $_

  if (-not (Get-ItemProperty -Path $userFontsRegistryPath -Name $fontName -ErrorAction SilentlyContinue)) {
    Write-Output "Registering font '$fontName': $fontFileFullName"
    New-ItemProperty -Path $userFontsRegistryPath -Name $fontName -Value $fontFileFullName -PropertyType String -Force | Out-Null
  }
}
