@echo off

SETLOCAL

set ENCRYPTED_KEY=%1/key.txt.age
set AGE_BIN=age
set AGE_DOWNLOAD_URL="https://github.com/FiloSottile/age/releases/download/v1.1.1/age-v1.1.1-windows-amd64.zip"
set AGE_TMP_DIR=%TEMP%/age

WHERE age >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    mkdir "%AGE_TMP_DIR%" 2> NUL

    bitsadmin.exe /transfer "Chezmoi" "%AGE_DOWNLOAD_URL%" "%AGE_TMP_DIR%\age-windows-amd64.zip" 1> NUL
    tar -C "%AGE_TMP_DIR%" --strip-components 1 -xf "%AGE_TMP_DIR%\age-windows-amd64.zip"
    set AGE_BIN=%AGE_TMP_DIR%/age.exe
)

echo Decrypt the age key by running: %AGE_BIN% --decrypt --output "%USERPROFILE%/.config/chezmoi/key.txt" "%ENCRYPTED_KEY%"
